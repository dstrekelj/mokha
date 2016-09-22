package khake.tools.tilemaps;

import khake.groups.Group;
import khake.tools.tilemaps.Tile;

import kha.graphics2.Graphics;
import kha.Image;

/**
	A tilemap is a collection of tiles.
**/
class Tilemap extends Group<Tile> {
	var tileWidth : Int;
	var tileHeight : Int;
	var tileSheet : Image;
	var tileColumns : Int;
	var tileRows : Int;

	public function new(tileWidth : Int, tileHeight : Int, tileSheet : Image) : Void {
		super();
		this.tileWidth = tileWidth;
		this.tileHeight = tileHeight;
		this.tileSheet = tileSheet;

		this.tileColumns = Std.int(tileSheet.width / tileWidth);
        this.tileRows = Std.int(tileSheet.height / tileHeight);
	}

	override public function draw(g : Graphics) : Void {
		for (m in this.members) {
			var sy = Std.int(m.index / tileColumns);
			var sx = Std.int(m.index - sy * tileColumns);
			g.drawSubImage(tileSheet, m.x, m.y, sx * m.width, sy * m.height, m.width, m.height);
		}	
	}
}