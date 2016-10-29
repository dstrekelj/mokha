package mokha.utils.collision;

import mokha.shapes.Rectangle;

/**
    A collider is a tool for detecting collision.
**/
class Collider {
    /**
        Reference to body.
    **/
    public var body : Rectangle;

    /**
        Rectangular hitbox or bounding box.
    **/
    public var hitbox(get, null) : Rectangle;

    public var offsetX : Float;
    public var offsetY : Float;

    /**
        If `true`, overlap and collision checks can be performed.
    **/
    public var isCollideable : Bool;

    /**
        Creates new collideable collider with rectangular hitbox.
        @param	x		Hitbox X position
        @param	y		Hitbox Y position
        @param	width	Hitbox width
        @param	height	Hitbox height
        @return	Collider
    **/
    public function new(x : Float, y : Float, width : Float, height : Float) : Void {
        body = new Rectangle(0, 0, 0, 0);
        hitbox = new Rectangle(x, y, width, height);
        offsetX = 0;
        offsetY = 0;
        isCollideable = true;
    }

    /**
        Cleans up references.
    **/
    public function destroy() : Void {
        body = null;
        hitbox = null;
    }

    /**
        Detects overlap between two entities.
        @param	e1	Subject entity
        @param	e2	Object entity
        @return	`true` if both entities are collidable and their hitboxes overlap
    **/
    public function detectOverlap(collider : Collider) : Bool {
        return isCollideable && collider.isCollideable ? hitbox.overlapsRectangle(collider.hitbox) : false;
    }

    @:noCompletion inline function get_hitbox() : Rectangle {
        hitbox.setPosition(body.x + offsetX, body.y + offsetY);
        return hitbox;
    }
}