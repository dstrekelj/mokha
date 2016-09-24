package mokha;

import mokha.shapes.Rectangle;
import mokha.Entity;
import mokha.Object;

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

class Camera extends Object {
	public var viewport : Rectangle;
	public var transformation : FastMatrix3;
	public var target : Entity;

	public function new() : Void {
		super();
		
		viewport = new Rectangle(0, 0, Mokha.renderWidth, Mokha.renderHeight);
		transformation = FastMatrix3.identity();
		target = null;
	}

	override public function update() : Void {
		super.update();

		if (target != null) {
			transformation = FastMatrix3.translation(-target.x + viewport.width / 2, -target.y + viewport.height / 2);
		}
	}

	override public function draw(g : Graphics) : Void {
		super.draw(g);

		g.transformation = transformation;
	}

	override public function destroy() : Void {
		super.destroy();

		viewport = null;
		transformation = null;
	}
}