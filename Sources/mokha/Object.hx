package mokha;

import mokha.utils.transformation.Transformer;

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
        Handles transformations made to this object.
    **/
    public var transformer : Transformer;
    
    /**
        Creates a new active and visible object.
    **/
    public function new() : Void {
        isActive = true;
        isVisible = true;
        
        transformer = new Transformer();
    }

    /**
        Override this. Intended for pre-collision logic and similar
        applications.
    **/
    public function preUpdate() : Void {}
    
    /**
        Override this. Intended for collision logic.
    **/
    public function update() : Void {}

    /**
        Override this. Intended for post-collision updates, state
        checks, etc.
    **/
    public function postUpdate() : Void {}
    
    /**
        Override this. Intended for a first pass of drawing.
        @param  g  G2 API access to framebuffer
    **/
    public function preDraw(g : Graphics) : Void {}

    /**
        Override this. Intended for drawing to framebuffer.
        @param  g  G2 API access to framebuffer
    **/
    public function draw(g : Graphics) : Void {}
    
    /**
        Override this. Intended for post-process or debug drawing.
        @param  g  G2 API access to framebuffer
    **/
    public function postDraw(g : Graphics) : Void {}
    
    /**
        Override this. Intended for nulling references to objects.
    **/
    public function destroy() : Void {}
    
    /**
        Makes the object inactive and invisible.
    **/
    public function kill() : Void {
        isActive = false;
        isVisible = false;
    }
    
    /**
        Makes the object active and visible.
    **/
    public function revive() : Void {
        isActive = true;
        isVisible = true;
    }
}
