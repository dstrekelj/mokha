package mokha;

import kha.graphics2.Graphics;

/**
    An object contains the bare minimum of methods and properties
    required to partake in the Mokha game life cycle.
**/
class Object {
    /**
        If `true`, object is updated. Default is `true`.
    **/
    public var isActive : Bool;
    
    /**
        If `true`, object is drawn. Default is `true`.
    **/
    public var isVisible : Bool;
    
    /**
        Creates a new active and visible object.
    **/
    public function new() : Void {
        this.isActive = true;
        this.isVisible = true;
    }

    /**
        Override this. Intended for possible setup lines.
    **/
    public function preUpdate() : Void {}
    
    /**
        Override this. Intended for game logic and property updating.
    **/
    public function update() : Void {}

    /**
        Override this. Intended for hitbox updating and the like.
    **/
    public function postUpdate() : Void {}
    
    /**
        Override this. Intended for drawing to framebuffer.
        @param  g  G2 API access to framebuffer
    **/
    public function draw(g : Graphics) : Void {}
    
    /**
        Override this. Intended for nulling references to objects.
    **/
    public function destroy() : Void {}
    
    /**
        Makes the object inactive and invisible.
    **/
    public function kill() : Void {
        this.isActive = false;
        this.isVisible = false;
    }
    
    /**
        Makes the object active and visible.
    **/
    public function revive() : Void {
        this.isActive = true;
        this.isVisible = true;
    }
}
