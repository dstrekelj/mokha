package khake.ui;

import khake.Entity;

import kha.Font;
import kha.graphics2.Graphics;

class Text extends Entity {
    public var font : Font;
    public var size : Int;
    public var value : String; 

    public function new(font : Font, size : Int) {
        super(0, 0, 0, 0);
        this.font = font;
        this.size = size;
        this.value = "";
        updateDimensions();
    }

    override public function draw(g : Graphics) : Void {
        g.font = this.font;
        g.fontSize = this.size;
        g.drawString(this.value, this.x, this.y);
    }

    public function setSize(size : Int) : Void {
        this.size = size;
        updateDimensions();
    }

    public function setValue(value : String) : Void {
        this.value = value;
        updateDimensions();
    }

    private function updateDimensions() : Void {
        this.height = this.font.height(this.size);
        this.width = this.font.width(this.size, this.value);
    }
}
