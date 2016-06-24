package khake;

import kha.graphics2.Graphics;

/**
 * An object contains the bare minimum of methods and properties
 * required to partake in the Khake game life cycle.
 */
class Object {
    /**
     * If true, object is updated. True by default.
     */
    public var isActive : Bool;
    /**
     * If true, object is drawn. True by default.
     */
    public var isVisible : Bool;
    
    public function new() {
        this.isActive = true;
        this.isVisible = true;
    }
    
    /**
     * Override this. Intended for game logic and property updating.
     */
    public function update() : Void {
    }
    
    /**
     * Override this. Intended for drawing.
     * @param   g   `kha.graphics2.Graphics` API access to framebuffer 
     */
    public function draw(g : Graphics) : Void {
    }
    
    /**
     * Shorthand for making the object inactive and invisible.
     */
    public function kill() : Void {
        this.isActive = false;
        this.isVisible = false;
    }
    
    /**
     * Shorthand for making the object active and visible.
     */
    public function revive() : Void {
        this.isActive = true;
        this.isVisible = true;
    }
}
