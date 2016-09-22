package khake.tools.collision;

import khake.Entity;

/**
	Utility functions for detecting entity collision.
**/
class Collider {
	/**
		Detects overlap between two entities.
		@param	e1	Subject entity
		@param	e2	Object entity
		@return	`true` if both entities are collidable and their hitboxes overlap
	**/
	public static function detectOverlap(e1 : Entity, e2 : Entity) : Bool {
		return (e1.isCollideable && e2.isCollideable) ? e1.hitbox.overlapsRectangle(e2.hitbox) : false; 
	}
}