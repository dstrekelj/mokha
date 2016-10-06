package mokha;

import mokha.shapes.Rectangle;
import mokha.utils.collision.Collider;

import kha.graphics2.Graphics;

/**
    An entity is an object with a "physical" body which describes
    position and size properties. It also contains a collider to make
    it collideable.
**/
class Entity extends Object {
    /**
        A rectangle which describes the (x, y) position and (width,
        height) size of the entity.
    **/
    public var body : Rectangle;

    /**
        Collider object to handle collision with.
    **/
    public var collider : Collider;
    
    /**
        Creates new collideable entity.
        @param  x       Entity horizontal position
        @param  y       Entity vertical position
        @param  width   Entity width
        @param  height  Entity height
    **/
    public function new(x : Float, y : Float, width : Float, height : Float) : Void {
        super();

        body = new Rectangle(x, y, width, height);
        collider = new Collider(x, y, width, height);
    }

    override public function postUpdate() : Void {
        super.postUpdate();

        collider.hitbox.setPosition(body.x, body.y);
    }

    /**
        Draws entity.
    **/
    override public function draw(g : Graphics) : Void {
        super.draw(g);
    }
    
    /**
        Nulls references.
    **/
    override public function destroy() : Void {
        super.destroy();
        
        collider.destroy();

        body = null;
        collider = null;
    }

    /**
        Kills entity, also making it not collideable.
    **/
    override public function kill() : Void {
        super.kill();

        collider.isCollideable = false;
    }

    /**
        Revives entity, also making it collideable.
    **/
    override public function revive() : Void {
        super.revive();
        
        collider.isCollideable = true;
    }
}
