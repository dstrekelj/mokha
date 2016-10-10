package mokha.ui;

import mokha.ui.BitmapFont;
import mokha.Entity;

import kha.graphics2.Graphics;
import kha.Color;

class BitmapText extends Entity {
    public var bitmapFont : BitmapFont;
    public var value : String;

    public function new(value : String, bitmapFont : BitmapFont) : Void {
        super(0, 0, 0, 0);

        this.value = value;
        this.bitmapFont = bitmapFont;
    }

    override public function draw(g : Graphics) : Void {
        super.draw(g);

        g.color = Color.White;
        for (i in 0...value.length) {
            bitmapFont.drawChar(g, i * bitmapFont.charWidth, 0, value.charAt(i));
        }
    }
}