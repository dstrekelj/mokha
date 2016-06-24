package khake;

import kha.Color;
import kha.Image;
import kha.graphics2.Graphics;

class Sprite extends Entity {
    public var graphic : Image;
    
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic.width, graphic.height);
        this.graphic = graphic;
    }
    
    override public function draw(g : Graphics) : Void {
        g.color = Color.White;
        g.drawImage(this.graphic, this.position.x, this.position.y);
    }
}
