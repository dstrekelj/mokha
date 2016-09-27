package mokha.ui;

import mokha.Entity;

import kha.graphics2.Graphics;
import kha.Color;
import kha.Font;

class TextArea extends Entity {
	public var font(default, set) : Font;
	public var size(default, set) : Int;
	public var value(default, set) : String;
	public var backgroundColor : Color;
	public var foregroundColor : Color;
	
	var lines(default, set) : Array<String>;

	public function new(width : Int, height : Int, font : Font, size : Int) : Void {
		super(0, 0, width, height);

		this.font = font;
		this.size = size;

		value = "";
		backgroundColor = Color.fromValue(0x00000000);
		foregroundColor = Color.White;
	}

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

	inline function set_font(font : Font) : Font {
		this.font = font;
		prepareLines();
		return font;
	}

	inline function set_size(size : Int) : Int {
		this.size = size;
		prepareLines();
		return size;
	}

	inline function set_value(value : String) : String {
		this.value = value;
		prepareLines();
		return value;
	}

	function prepareLines() : Void {
		lines = new Array<String>();

		var lineWidth : Float = 0;
		var lineHeight = font.height(size);
		var line = new StringBuf();
		
		var wordWidth : Float = 0;
		var linesHeight : Float = 0;

		for (sentence in ~/\n|\r/g.split(value)) {
			if (linesHeight + lineHeight > height) {
				break;
			}

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
}