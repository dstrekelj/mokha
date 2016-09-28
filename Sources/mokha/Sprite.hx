package mokha;

import mokha.utils.animation.Animator;

import kha.graphics2.Graphics;
import kha.Color;
import kha.Image;

/**
    A sprite is an entity with a visual component. It has an image
    graphic and an animator.
**/
class Sprite extends Entity {
    /**
        Sprite graphic.
    **/
    public var graphic : Image;

    /**
        Sprite animator.
    **/
    public var animator : Animator;
    
    /**
        Creates new sprite.
        @param  x       Horizontal position
        @param  y       Vertical position
        @param  width   Sprite width
        @param  height  Sprite height
        @param  graphic Image graphic
    **/
    public function new(x : Float, y : Float, width : Float, height : Float, graphic : Image) : Void {
        super(x, y, width, height);
        this.graphic = graphic;
        this.animator = new Animator(width, height, graphic.width, graphic.height);
    }
    
    /**
        Updates sprite and its animator.
    **/
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
        super.draw(g);
        g.color = Color.White;
        this.animator.draw(g, this);
    }
    
    /**
        Nulls references.
    **/
    override public function destroy() : Void {
        super.destroy();
        this.animator.destroy();
        this.animator = null;
        this.graphic = null;
    }
}
