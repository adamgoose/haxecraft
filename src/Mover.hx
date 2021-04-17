package;

import defold.Push.PushOrigin;
import defold.support.ScriptOnInputAction;
import defold.Msg;

typedef MoverData = {
	var oPos:Vector3;
	var speed:Vector3;
};

class Mover extends Script<MoverData> {
	var speed = 5;

	override function init(self:MoverData) {
		Msg.post(".", GoMessages.acquire_input_focus);
		self.oPos = Go.get_position();
		self.speed = Vmath.vector3();
	}

	override function update(self:MoverData, dt) {
		var p = Go.get_position();

		p += self.speed * dt;
		Go.set_position(p);
		self.speed = Vmath.vector3();
	}

	override function on_input(self:MoverData, action_id:Hash, action:ScriptOnInputAction):Bool {
		if (action_id == hash("w")) {
			self.speed.z -= speed;
		} else if (action_id == hash("a")) {
			self.speed.x -= speed;
		} else if (action_id == hash("s")) {
			self.speed.z += speed;
		} else if (action_id == hash("d")) {
			self.speed.x += speed;
		} else if (action_id == hash("space")) {
			self.speed.y += speed;
		} else if (action_id == hash("shift")) {
			self.speed.y -= speed;
		} else if (action_id == hash("esc")) {
			Go.set_position(self.oPos);
		}

		return false;
	}
}
