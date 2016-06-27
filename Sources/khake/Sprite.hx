package khake;

import kha.Color;
import kha.Image;
import kha.graphics2.Graphics;

class Sprite extends Entity {
    /**
            Sprite graphic.
    **/
    public var graphic : Image;
    
    /**
            @param  x       Horizontal position
            @param  y       Vertical position
            @param  graphic Graphic
    **/
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic.width, graphic.height);
        this.graphic = graphic;
    }
    
    /**
            Draws sprite using the graphic. Color is set to white before the
            image is drawn because of default multiplicative color blending.
            
            @param  g   G2 API access to framebuffer
    **/
    override public function draw(g : Graphics) : Void {
        g.color = Color.White;
        g.drawImage(this.graphic, this.position.x, this.position.y);
    }
    
    /**
            Nulls references.
    **/
    override public function destroy() : Void {
        super.destroy();
        this.graphic = null;
    }
}
