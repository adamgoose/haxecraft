package;

import Geometry;
import lua.PairTools;
import lua.TableTools;
import defold.Resource;
import defold.Buffer;
import haxe.ds.Vector;

typedef Block = {
	var position:RVector3;
	var empty:Bool;
};

typedef ChunkData = {
	var position:RVector3;
	var blocks:Array<Array<Array<Block>>>;
	var vertices:Array<RVector3>;
	var normals:Array<RVector3>;
	var uvs:Array<Vector2>;
};

class Chunk extends Script<ChunkData> {
	public var blockSize = 1;
	public var chunkSize = {x: 16, y: 16, z: 16};

	override public function init(self:ChunkData):Void {
		self.position = RVmath.vector3(Go.get_position("."));
		self.blocks = [
			for (x in 0...chunkSize.x) [
				for (y in 0...chunkSize.y) [
					for (z in 0...chunkSize.z)
						{
							position: RVmath.vector3(x, y, z),
							empty: (x % 2 == 0) || (y % 2 == 0)
						}
				]
			]
		];

		Go.set("#mesh", "light", Vmath.vector4(0, 64, 0, 0));
		updateChunk(self);
	}

	function updateChunk(self:ChunkData):Void {
		// clear the mesh
		self.vertices = [];
		self.normals = [];
		self.uvs = [];

		for (x in 0...chunkSize.x) {
			for (y in 0...chunkSize.y) {
				for (z in 0...chunkSize.z) {
					var block = self.blocks[x][y][z];
					if (block.empty)
						continue;

					for (face in [Top, Bottom, Left, Right, Far, Near]) {
						if (neighborIsEmpty(self, block.position, face)) {
							trace("block is empty");
							addVertices(self, block.position, face);
						}
					}
				}
			}
		}

		var buf = Buffer.create(self.vertices.length, untyped __lua__('{
			{ name = hash("position"), type=buffer.VALUE_TYPE_FLOAT32, count = 3 },
			{ name = hash("normal"), type=buffer.VALUE_TYPE_FLOAT32, count = 3 },
			{ name = hash("texcoord0"), type=buffer.VALUE_TYPE_FLOAT32, count = 2 }
		}'));
		var pos = Buffer.get_stream(buf, "position");
		var nor = Buffer.get_stream(buf, "normal");
		var tex = Buffer.get_stream(buf, "texcoord0");

		var i = 1;
		for (j in 0...self.vertices.length) {
			pos[i] = self.vertices[j].x;
			pos[i + 1] = self.vertices[j].y;
			pos[i + 2] = self.vertices[j].z;
			nor[i] = self.normals[j].x;
			nor[i + 1] = self.normals[j].y;
			nor[i + 2] = self.normals[j].z;
			i += 3;
		}

		var i = 1;
		for (j in 0...self.uvs.length) {
			tex[i] = self.uvs[j].x;
			tex[i + 1] = self.uvs[j].y;
			i += 2;
		}

		var res:Hash = Go.get("#mesh", "vertices");
		Resource.set_buffer(res, buf);
	}

	function neighborIsEmpty(self:ChunkData, position:RVector3, face:Face):Bool {
		var p = RVmath.vector3(position.x, position.y, position.z);

		switch (face) {
			case Top:
				p.y++;
			case Bottom:
				p.y--;
			case Left:
				p.x--;
			case Right:
				p.x++;
			case Far:
				p.z--;
			case Near:
				p.z++;
			default:
				return true;
		}

		if (p.x < 0 || p.x >= chunkSize.x) {
			return true;
		}
		if (p.y < 0 || p.y >= chunkSize.y) {
			return true;
		}
		if (p.z < 0 || p.z >= chunkSize.z) {
			return true;
		}

		var block = self.blocks[p.x][p.y][p.z];
		return block.empty;
	}

	function addVertices(self:ChunkData, p:RVector3, face:Face):Void {
		var tri = [];
		var nor = [];
		var tex = null;
		switch face {
			case Top:
				tri = Triangles.Top;
				nor = Normals.Top;
				tex = Wool.LightGreen;
			case Bottom:
				tri = Triangles.Bottom;
				nor = Normals.Bottom;
				tex = Wool.Brown;
			case Left:
				tri = Triangles.Left;
				nor = Normals.Left;
				tex = Wool.Brown;
			case Right:
				tri = Triangles.Right;
				nor = Normals.Right;
				tex = Wool.Brown;
			case Near:
				tri = Triangles.Near;
				nor = Normals.Near;
				tex = Wool.Brown;
			case Far:
				tri = Triangles.Far;
				nor = Normals.Far;
				tex = Wool.Brown;
			default:
		}

		for (v in tri) {
			self.vertices.push(p + (v * blockSize));
		}
		for (v in nor) {
			self.normals.push(v);
		}
		for (v in Wool.Shape) {
			self.uvs.push(v + tex);
		}
	}
}
