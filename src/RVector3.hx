package;

@:native("_G.vmath")
extern class RVmath {
	@:overload(function(v:Vector3):RVector3 {})
	static function vector3(x:Int, y:Int, z:Int):RVector3;
}

/**
	Vector3 type, can be created with `defold.Vmath.vector3`.
**/
@:forward
extern abstract RVector3(RVector3Data) {
	@:op(a + b)
	private static inline function add(a:RVector3, b:RVector3):RVector3 {
		return untyped __lua__("({0}) + ({1})", a, b);
	}

	@:op(a - b)
	private static inline function sub(a:RVector3, b:RVector3):RVector3 {
		return untyped __lua__("({0}) - ({1})", a, b);
	}

	@:op(-b)
	private static inline function neg(a:RVector3):RVector3 {
		return untyped __lua__("-({0})", a);
	}

	@:op(a * b) @:commutative
	private static inline function mulScalar(a:RVector3, b:Int):RVector3 {
		return untyped __lua__("({0}) * ({1})", a, b);
	}

	@:op(a / b)
	private static inline function divScalar(a:RVector3, b:Int):RVector3 {
		return untyped __lua__("({0}) / ({1})", a, b);
	}

	@:op(a * b)
	private static inline function mul(a:RVector3, b:RVector3):RVector3 {
		return untyped __lua__("({0}) * ({1})", a, b);
	}
}

private extern class RVector3Data {
	var x:Int;
	var y:Int;
	var z:Int;
}
