package khake.ui;

import khake.Entity;

import kha.Font;
import kha.graphics2.Graphics;

class Text extends Entity {
    public var font : Font;
    public var size(default, set) : Int;
    public var value(default, set) : String; 

    public function new(font : Font, size : Int) {
        super(0, 0, 0, 0);
        this.font = font;
        this.size = size;
        this.value = "";
    }

    override public function draw(g : Graphics) : Void {
        g.font = this.font;
        g.fontSize = this.size;
        g.drawString(this.value, this.x, this.y);
    }
    
    private function set_value(value : String) : String {
        this.value = value;
        this.height = this.font.height(this.size);
        this.width = this.font.width(this.size, this.value);
        return this.value;
    }
    
    private function set_size(size : Int) : Int {
        this.size = size;
        this.height = this.font.height(this.size);
        this.width = this.font.width(this.size, this.value);
        return this.size;
    }
}
