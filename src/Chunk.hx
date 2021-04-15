package;

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
	var vertices:Array<Vector3>;
	var normals:Array<Vector3>;
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
							empty: false
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
			{ name = hash("normal"), type=buffer.VALUE_TYPE_FLOAT32, count = 3 }
		}'));
		var pos = Buffer.get_stream(buf, "position");
		var nor = Buffer.get_stream(buf, "normal");

		pprint(self.vertices);

		var i = 1;
		for (j in 1...self.vertices.length) {
			pos[i] = self.vertices[j].x;
			pos[i + 1] = self.vertices[j].y;
			pos[i + 2] = self.vertices[j].z;
			nor[i] = self.normals[j].x;
			nor[i + 1] = self.normals[j].y;
			nor[i + 2] = self.normals[j].z;
			i += 3;
		}

		// for (j in 1...i) {
		// 	pprint('${j}: ${pos[j]}');
		// }

		var res = Go.get("#mesh", "vertices");
		Resource.set_buffer(res, buf);
	}

	function neighborIsEmpty(self:ChunkData, p:RVector3, face:Face):Bool {
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
		switch face {
			case Top:
				self.vertices.push(Vmath.vector3(p.x, p.y + blockSize, p.z));
				self.vertices.push(Vmath.vector3(p.x, p.y + blockSize, p.z + blockSize));
				self.vertices.push(Vmath.vector3(p.x + blockSize, p.y + blockSize, p.z + blockSize));

				self.vertices.push(Vmath.vector3(p.x, p.y + blockSize, p.z));
				self.vertices.push(Vmath.vector3(p.x + blockSize, p.y + blockSize, p.z + blockSize));
				self.vertices.push(Vmath.vector3(p.x + blockSize, p.y + blockSize, p.z));

				for (i in 0...6) {
					self.normals.push(Vmath.vector3(0, 1, 0));
				}
			// case Bottom:
			// 	for (_ in 0...6)
			// 		self.normals.push(Vmath.vector3(0, -1, 0));
			// case Left:
			// 	for (_ in 0...6)
			// 		self.normals.push(Vmath.vector3(-1, 0, 0));
			// case Right:
			// 	for (_ in 0...6)
			// 		self.normals.push(Vmath.vector3(1, 0, 0));
			// case Near:
			// 	for (_ in 0...6)
			// 		self.normals.push(Vmath.vector3(0, 0, -1));
			// case Far:
			// 	for (_ in 0...6)
			// 		self.normals.push(Vmath.vector3(0, 0, 1));
			default:
		}
	}
}

enum Face {
	All;
	Top;
	Bottom;
	Left;
	Right;
	Far;
	Near;
}
