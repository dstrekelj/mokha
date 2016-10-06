package mokha.ui;

import kha.graphics2.Graphics;
import kha.Font;
import kha.Image;

/**
    Monospace bitmap font.
**/
class BitmapFont {
    public var charWidth(default, null) : Float;
    public var charHeight(default, null) : Float;
    
    var bitmap : Image;
    var chars : String;
    var charMap : Map<String, Int>;
    var columns : Int;
    var rows : Int;

    public function new(bitmap : Image, charWidth : Float, charHeight : Float, chars : String) : Void {
        this.bitmap = bitmap;
        this.charWidth = charWidth;
        this.charHeight = charHeight;
        this.chars = chars;
        
        columns = Std.int(bitmap.width / charWidth);
        rows = Std.int(bitmap.height / charHeight);
        
        charMap = new Map<String, Int>();
        for (i in 0...chars.length) {
            charMap.set(chars.charAt(i), i);
        }
    }

    /**
        Font interface. Returns height of font when drawn.
    **/
    public function height(fontSize : Int) : Float {
        return charHeight;
    }

    /**
        Font interface. Returns width of string when drawn.
    **/
    public function width(fontSize : Int, str : String) : Float {
        return charWidth * str.length;
    }

    /**
        Font interface. Returns font baseline position.
    **/
    public function baseline(fontSize : Int) : Float {
        return 0;
    }

    public function drawChar(g : Graphics, x : Float, y : Float, char : String) : Void {
        if (charMap.exists(char)) {
            var charIndex = charMap.get(char);
            g.drawSubImage(bitmap, x, y, getColumn(charIndex) * charWidth, getRow(charIndex) * charHeight, charWidth, charHeight);
        }
    }

    inline function getIndex(column : Int, row : Int) : Int {
        return row * columns + column;
    }

    inline function getRow(index : Int) : Int {
        return Std.int(index / columns);
    }

    inline function getColumn(index : Int) : Int {
        return index - getRow(index) * columns;
    }
} 