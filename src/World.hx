package;

import defold.Factory;
import defold.support.ScriptOnInputAction;

typedef WorldData = {
	//
};

class World extends Script<WorldData> {
	var chunkSize = RVmath.vector3(16, 16, 16);

	override function init(self:WorldData) {
		for (x in 0...4) {
			for (z in 0...4) {
				// Factory.create("#chunkFactory", RVmath.vector3(x * chunkSize.x, 0, z * chunkSize.z));
			}
		}
		// Factory.create("#chunkFactory");
	}

	override function update(self:WorldData, dt:Float) {
		//
	}

	override function on_input(self:WorldData, action_id:Hash, action:ScriptOnInputAction):Bool {
		return false;
	}
}
