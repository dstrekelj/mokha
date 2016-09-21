package khake.ui;

import khake.Entity;

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
    public var font : Font;

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
    var size : Int;

    /**
        Text value.
    **/
    var value : String; 

    /**
        Creates new text object.
        @param  font    Text font family
        @param  size    Text font size
    **/
    public function new(font : Font, size : Int) : Void {
        super(0, 0, 0, 0);
        this.font = font;
        this.size = size;
        
        this.backgroundColor = Color.fromValue(0x00000000);
        this.foregroundColor = Color.White;
        this.value = "";
        updateDimensions();
    }

    /**
        Draws text.
    **/
    override public function draw(g : Graphics) : Void {
        super.draw(g);
        g.color = this.backgroundColor;
        g.fillRect(this.x, this.y, this.width, this.height);
        g.color = this.foregroundColor;
        g.font = this.font;
        g.fontSize = this.size;
        g.drawString(this.value, this.x, this.y);
        g.color = Color.White;
    }

    /**
        Sets text size, updating width and height in the process.
    **/
    public function setSize(size : Int) : Void {
        this.size = size;
        updateDimensions();
    }

    /**
        Sets text value, updating width and height in the process.
    **/
    public function setValue(value : String) : Void {
        this.value = value;
        updateDimensions();
    }

    /**
        Updates text dimensions.
    **/
    function updateDimensions() : Void {
        this.height = this.font.height(this.size);
        this.width = this.font.width(this.size, this.value);
    }
}
