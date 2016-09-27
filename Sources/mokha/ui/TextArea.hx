package mokha.ui;

import mokha.Entity;

import kha.graphics2.Graphics;
import kha.Color;
import kha.Font;

/**
	A text area defines a rectangular area in which text is wrapped
	to fit. Text which exceeds the area is not drawn.
**/
class TextArea extends Entity {
	/**
		Font family.
	**/
	public var font(default, set) : Font;

	/**
		Font size.
	**/
	public var size(default, set) : Int;
	
	/**
		Text area value.
	**/
	public var value(default, set) : String;
	
	/**
		Text area background color.
	**/
	public var backgroundColor : Color;

	/**
		Text area foreground color.
	**/
	public var foregroundColor : Color;
	
	/**
		Lines of text that fit within the text area.
	**/
	var lines(default, set) : Array<String>;

	/**
		Creates new text area.
		@param	width	Text area width
		@param	height	Text area height
		@param	font	Text area font family
		@param	size	Text area font size
	**/
	public function new(width : Int, height : Int, font : Font, size : Int) : Void {
		super(0, 0, width, height);

		this.font = font;
		this.size = size;

		value = "";
		backgroundColor = Color.fromValue(0x00000000);
		foregroundColor = Color.White;
	}

	/**
		Draws text area and text that fits within it.
	**/
	override public function draw(g : Graphics) : Void {
		super.draw(g);

		g.color = backgroundColor;
		g.fillRect(x, y, width, height);
		g.color = foregroundColor;
		g.font = font;
		g.fontSize = size;
		for (i in 0...lines.length) {
			if (lines[i] != "") {
				g.drawString(lines[i], x, y + i * font.height(size));
			}
		}
		g.color = Color.White;
	}

	/**
		Prepares visible lines of text area value, with regard to
		text area dimensions, font family, and font size.
	**/
	function prepareLines() : Void {
		lines = new Array<String>();

		var lineWidth : Float = 0;
		var lineHeight = font.height(size);
		var line = new StringBuf();
		
		var wordWidth : Float = 0;
		var linesHeight : Float = 0;

		// Every sentence should be its own line, if possible
		for (sentence in ~/\n|\r/g.split(value)) {
			if (linesHeight + lineHeight > height) {
				break;
			}
			// Sentences should be broken into new lines if too long
			for (word in ~/\s/g.split(sentence)) { 		 
				wordWidth = 0;
				for (char in (word + " ").split("")) {
					wordWidth += font.width(size, char);
				}
				if (lineWidth + wordWidth <= width) {
					line.add(word);
				} else {
					lines.push(line.toString());
					line = new StringBuf();
					line.add(word);
					lineWidth = wordWidth;
				}
			}
			lines.push(line.toString());
			line = new StringBuf();
			lineWidth = 0;
			linesHeight += lineHeight;
		}
	}
	

	/**
		Internal. Sets new font family and prepares new lines.
		@param	font	Font family
		@return	Font family
	**/
	@:noCompletion inline function set_font(font : Font) : Font {
		this.font = font;
		prepareLines();
		return font;
	}

	/**
		Internal. Sets new font size and prepares new lines.
		@param	size	Font size
		@return	Font size
	**/
	@:noCompletion inline function set_size(size : Int) : Int {
		this.size = size;
		prepareLines();
		return size;
	}

	/**
		Internal. Sets new text area value and prepares new lines.
		@param	value	Text area value
		@return	Text area value
	**/
	@:noCompletion inline function set_value(value : String) : String {
		this.value = value;
		prepareLines();
		return value;
	}
}