package mokha;

import mokha.utils.collision.Collider;

import kha.graphics2.Graphics;

/**
    An entity is an object with physical properties: position, width,
    and height. It has a hitbox and can therefore be collideable.
**/
class Entity extends Object {
    /**
        Entity x position. Changes apply to hitbox as well.
    **/
    public var x(default, set) : Float;
    @:noCompletion inline function set_x(x : Float) {
        if (collider != null) collider.hitbox.x = x;
        return this.x = x;
    }

    /**
        Entity y position. Changes apply to hitbox as well.
    **/
    public var y(default, set) : Float;
    @:noCompletion inline function set_y(y : Float) {
        if (collider != null) collider.hitbox.y = y;
        return this.y = y;
    }

    /**
        Entity width. Equals hitbox width by default. Changes do not apply to hitbox.
    **/
    public var width : Float;

    /**
        Entity height. Equals hitbox height by default. Changes do not apply to hitbox
    **/ 
    public var height : Float;

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
        
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        
        collider = new Collider(x, y, width, height);
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

    /**
        Positions entity top-left corner at (x, y) position.
    **/
    public function setPosition(x : Float, y : Float) : Void {
        this.x = x;
        this.y = y;
    }
    
    /**
        Positions entity center point at (x, y) position.
        @param  x   Horizontal position
        @param  y   Vertical position
    **/
    public function setCenterPosition(x : Float, y : Float) : Void {
        this.x = x - width / 2;
        this.y = y - height / 2; 
    }
}
