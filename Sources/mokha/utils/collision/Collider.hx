package mokha.utils.collision;

import mokha.shapes.Rectangle;

/**
    A collider is a tool for detecting collision.
**/
class Collider {
    /**
        Rectangular hitbox or bounding box.
    **/
    public var hitbox : Rectangle;

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
        hitbox = new Rectangle(x, y, width, height);
        isCollideable = true;
    }

    /**
        Cleans up references.
    **/
    public function destroy() : Void {
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
}