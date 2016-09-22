package khake.tools.collision;

import khake.Entity;
import khake.Sprite;

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

	/**
		Detects pixel perfect overlap between two sprites. Performs
		hitbox overlap check beforehand.
		@param	s1	Subject sprite
		@param	s2	Object sprite
		@return	`true` if both sprites are collidable and their 
	**/
	public static function detectPixelPerfectOverlap(s1 : Sprite, s2 : Sprite) : Bool {
		return detectOverlap(s1, s2);
	}
}