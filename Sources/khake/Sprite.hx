package khake;

import khake.systems.AnimationSystem;

import kha.Color;
import kha.Image;
import kha.graphics2.Graphics;

class Sprite extends Entity {
    /**
            Sprite graphic.
    **/
    public var graphic : Image;
    
    /**
            Sprite animator.
    **/
    public var animator : AnimationSystem;
    
    /**
            @param  x       Horizontal position
            @param  y       Vertical position
            @param  graphic Graphic
    **/
    public function new(x : Float, y : Float, graphic : Image, width : Float, height : Float) {
        super(x, y, width, height);
        this.graphic = graphic;
        this.animator = new AnimationSystem(this, width, height); 
    }
    
    override public function update() : Void {
        super.update();
        this.animator.update();
    }
    
    /**
            Draws sprite using the graphic. Color is set to white before the
            image is drawn because of default multiplicative color blending.
            
            @param  g   G2 API access to framebuffer
    **/
    override public function draw(g : Graphics) : Void {
        super.update();
        g.color = Color.White;
        this.animator.draw(g);
    }
    
    /**
            Nulls references.
    **/
    override public function destroy() : Void {
        super.destroy();
        this.graphic = null;
    }
}
