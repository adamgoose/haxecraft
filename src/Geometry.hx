package;

class Vector2 {
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
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

class Triangles {
	public static var Top:Array<RVector3> = [
		RVmath.vector3(0, 1, 0),
		RVmath.vector3(0, 1, 1),
		RVmath.vector3(1, 1, 1),
		RVmath.vector3(0, 1, 0),
		RVmath.vector3(1, 1, 1),
		RVmath.vector3(1, 1, 0),
	];
	public static var Bottom:Array<RVector3> = [
		RVmath.vector3(0, 0, 0),
		RVmath.vector3(1, 0, 1),
		RVmath.vector3(0, 0, 1),
		RVmath.vector3(0, 0, 0),
		RVmath.vector3(1, 0, 0),
		RVmath.vector3(1, 0, 1),
	];
	public static var Left:Array<RVector3> = [
		RVmath.vector3(0, 0, 0),
		RVmath.vector3(0, 0, 1),
		RVmath.vector3(0, 1, 1),
		RVmath.vector3(0, 0, 0),
		RVmath.vector3(0, 1, 1),
		RVmath.vector3(0, 1, 0),
	];
	public static var Right:Array<RVector3> = [
		RVmath.vector3(1, 0, 0),
		RVmath.vector3(1, 1, 0),
		RVmath.vector3(1, 1, 1),
		RVmath.vector3(1, 0, 0),
		RVmath.vector3(1, 1, 1),
		RVmath.vector3(1, 0, 1),
	];
	public static var Near:Array<RVector3> = [
		RVmath.vector3(0, 0, 1),
		RVmath.vector3(1, 0, 1),
		RVmath.vector3(1, 1, 1),
		RVmath.vector3(0, 0, 1),
		RVmath.vector3(1, 1, 1),
		RVmath.vector3(0, 1, 1),
	];
	public static var Far:Array<RVector3> = [
		RVmath.vector3(0, 0, 0),
		RVmath.vector3(0, 1, 0),
		RVmath.vector3(1, 1, 0),
		RVmath.vector3(0, 0, 0),
		RVmath.vector3(1, 1, 0),
		RVmath.vector3(1, 0, 0),
	];
}

class Wool {
	public static var White:Array<Vector2> = [
		new Vector2(0, 0),
		new Vector2(0, 1 / 4),
		new Vector2(1 / 4, 1 / 4),
		new Vector2(0, 0),
		new Vector2(1 / 4, 1 / 4),
		new Vector2(1 / 4, 0)
	];
}

class Normals {
	public static var Top:Array<RVector3> = [for (_ in 0...6) RVmath.vector3(0, 1, 0)];
	public static var Bottom:Array<RVector3> = [for (_ in 0...6) RVmath.vector3(0, -1, 0)];
	public static var Left:Array<RVector3> = [for (_ in 0...6) RVmath.vector3(-1, 0, 0)];
	public static var Right:Array<RVector3> = [for (_ in 0...6) RVmath.vector3(1, 0, 0)];
	public static var Near:Array<RVector3> = [for (_ in 0...6) RVmath.vector3(0, 0, -1)];
	public static var Far:Array<RVector3> = [for (_ in 0...6) RVmath.vector3(0, 0, 1)];
}
