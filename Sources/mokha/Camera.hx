package mokha;

import mokha.shapes.Rectangle;
import mokha.Entity;
import mokha.Object;

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

class Camera extends Object {
    public var deadzone : Rectangle;
    public var viewport : Rectangle;
    public var transformation : FastMatrix3;
    public var target : Entity;
    public var followStyle : CameraFollowStyle;

    var x : Float;
    var y : Float;

    public function new() : Void {
        super();

        x = 0;
        y = 0;

        deadzone = new Rectangle(0, 0, Mokha.renderWidth, Mokha.renderHeight);
        viewport = new Rectangle(0, 0, Mokha.renderWidth, Mokha.renderHeight);
        transformation = FastMatrix3.identity();
        target = null;
        followStyle = null;
    }

    override public function update() : Void {
        super.update();

        follow();
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

    function follow() : Void {
        if (target != null || followStyle != null) {
            switch (followStyle) {
                case CameraFollowStyle.LockOn:
                    transformation = FastMatrix3.translation(-target.body.x + viewport.width / 2, -target.body.y + viewport.height / 2);
                case CameraFollowStyle.RoomByRoom:
                    if (target.body.centroidX + x > viewport.width) {
                        transformation = transformation.multmat(FastMatrix3.translation(-viewport.width, 0));
                        x += -viewport.width;
                    }

                    if (target.body.centroidX + x < viewport.x) {
                        transformation = transformation.multmat(FastMatrix3.translation(viewport.width, 0));
                        x += viewport.width;
                    }

                    if (target.body.centroidY + y> viewport.height) {
                        transformation = transformation.multmat(FastMatrix3.translation(0, -viewport.height));
                        y += -viewport.height;
                    }

                    if (target.body.centroidY + y < viewport.y) {
                        transformation = transformation.multmat(FastMatrix3.translation(0, viewport.height));
                        y += viewport.height;
                    }
                case _:
            }
        }
    }
}

enum CameraFollowStyle {
    LockOn;
    RoomByRoom;
}