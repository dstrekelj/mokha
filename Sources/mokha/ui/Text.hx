package mokha.ui;

import mokha.Entity;

import kha.graphics2.Graphics;
import kha.Color;
import kha.Font;

/**
    A rudimentary text label UI element.
**/
class Text extends Entity {
    /**
        Text font family.
    **/
    public var font(default, set) : Font;

    /**
        Text background color.
    **/
    public var backgroundColor : Color;

    /**
        Text foreground color.
    **/
    public var foregroundColor : Color;

    /**
        Text font size.
    **/
    public var size(default, set) : Int;

    /**
        Text value.
    **/
    public var value(default, set) : String;

    /**
        Creates new text object.
        @param  value   Text string
        @param  font    Text font family
        @param  size    Text font size
    **/
    public function new(value : String, font : Font, size : Int) : Void {
        super(0, 0, 0, 0);
        this.font = font;
        this.size = size;
        this.value = value;
        
        backgroundColor = Color.fromValue(0x00000000);
        foregroundColor = Color.White;
    }

    /**
        Draws text.
    **/
    override public function draw(g : Graphics) : Void {
        super.draw(g);
        
        g.color = backgroundColor;
        g.fillRect(body.x, body.y, body.width, body.height);
        g.color = foregroundColor;
        g.font = font;
        g.fontSize = size;
        g.drawString(value, body.x, body.y);
        g.color = Color.White;
    }

    /**
        Updates text height.
    **/

    function updateHeight() : Void {
        if (font == null || size == null) return;
        body.height = font.height(size);
    }

    /**
        Updates text width.
    **/
    function updateWidth() : Void {
        if (font == null || size == null || value == null) return;
        body.width = font.width(size, value);
    }
    
    /**
        Sets font, updating text dimensions in the process.
        @param  font    Font
        @return Font
    **/
    @:noCompletion inline function set_font(font : Font) {
        this.font = font;
        updateHeight();
        updateWidth();
        return font;
    }

    /**
        Sets size, updating text dimensions in the process.
        @param  size    Size
        @return Size
    **/
    @:noCompletion inline function set_size(size : Int) {
        this.size = size;
        updateHeight();
        updateWidth();
        return size;
    }
    
    /**
        Sets value, updating text dimensions in the process.
        @param  value   Value
        @return Value
    **/
    @:noCompletion inline function set_value(value : String) {
        this.value = value;
        updateWidth();
        return value;
    }
}
