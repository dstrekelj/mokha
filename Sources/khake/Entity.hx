package khake;

import khake.shapes.Rectangle;

import kha.graphics2.Graphics;

/**
    An entity is an object with physical properties: position, width,
    and height. It has a hitbox and can therefore be collideable.
**/
class Entity extends Object {
    /**
        Entity x position.
    **/
    public var x(default, set) : Float;
    inline function set_x(x : Float) {
        this.x = x;
        this.hitbox.x = x;
        return this.x;
    }
    /**
        Entity y position.
    **/
    public var y(default, set) : Float;
    inline function set_y(y : Float) {
        this.y = y;
        this.hitbox.y = y;
        return this.y;
    }
    /**
        Entity width. Equals hitbox width by default.
    **/
    public var width : Float;
    /**
        Entity height. Equals hitbox height by default.
    **/ 
    public var height : Float;
    /**
        Rectangular area where the entity is collideable with others.
    **/
    public var hitbox : Rectangle;
    /**
        If true, collision logic applies. True by default.
    **/
    public var isCollideable : Bool;
    
    /**
        @param  x       Entity horizontal position
        @param  y       Entity vertical position
        @param  width   Entity width
        @param  height  Entity height
    **/
    public function new(x : Float, y : Float, width : Float, height : Float) {
        super();
        this.hitbox = new Rectangle(x, y, width, height);
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.isCollideable = true;
    }

    override public function draw(g : Graphics) : Void {
        super.draw(g);
        g.color = kha.Color.Red;
        g.drawRect(this.hitbox.x, this.hitbox.y, this.hitbox.width, this.hitbox.height);
    }
    
    /**
        Nulls references.
    **/
    override public function destroy() : Void {
        super.destroy();
        this.hitbox = null;
    }

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
        this.x = x - this.width / 2;
        this.y = y - this.height / 2; 
    }
    
    /**
        Checks if hitbox overlaps point.
        
        @param  x   Point horizontal position
        @param  y   Point vertical position
        @return True if hitbox overlaps point, false if not
    **/
    public function collidesPoint(x : Float, y : Float) : Bool {
        return this.hitbox.collidesPoint(x, y);
    }
    
    /**
        Checks if hitbox overlaps with another entity's hitbox.
        
        @param  e   Entity to collide with
    **/
    public function collidesEntity(e : Entity) : Bool {
        return this.hitbox.collidesRectangle(e.hitbox);
    }
}
