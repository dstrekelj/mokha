package khake.systems;

import khake.Object;
import khake.shapes.Rectangle;

import kha.Image;

class AnimationSystem extends Object {
    var frame : Rectangle;
    var graphic : Image;
    
    public function new(graphic : Image, frameWidth : Int, frameHeight : Int) {
        super();
        this.graphic = graphic;
        this.frame = new Rectangle(0, 0, frameWidth, frameHeight);
    }
    
    override public function update() : Void {
    }
}
