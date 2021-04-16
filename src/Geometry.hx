package;

class Vector2Data {
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}
}

@:forward(x, y)
abstract Vector2(Vector2Data) {
	public inline function new(x:Float, y:Float) {
		this = new Vector2Data(x, y);
	}

	@:op(a + b)
	public static inline function add(a:Vector2, b:Vector2):Vector2 {
		return new Vector2(a.x + b.x, a.y + b.y);
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
	public static var White:Vector2 = new Vector2(0, 0);
	public static var Purple:Vector2 = new Vector2(1 / 4, 0);
	public static var Tan:Vector2 = new Vector2(2 / 4, 0);
	public static var LightGreen:Vector2 = new Vector2(0, 1 / 4);
	public static var LightGrey:Vector2 = new Vector2(1 / 4, 1 / 4);
	public static var CottonCandy:Vector2 = new Vector2(2 / 4, 1 / 4);
	public static var Red:Vector2 = new Vector2(3 / 4, 1 / 4);
	public static var Brown:Vector2 = new Vector2(0, 2 / 4);
	public static var LightBlue:Vector2 = new Vector2(1 / 4, 2 / 4);
	public static var Grey:Vector2 = new Vector2(2 / 4, 2 / 4);
	public static var Orange:Vector2 = new Vector2(3 / 4, 2 / 4);
	public static var Black:Vector2 = new Vector2(0, 3 / 4);
	public static var Blue:Vector2 = new Vector2(1 / 4, 3 / 4);
	public static var Green:Vector2 = new Vector2(2 / 4, 3 / 4);
	public static var Pink:Vector2 = new Vector2(3 / 4, 3 / 4);
	public static var Shape:Array<Vector2> = [
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
