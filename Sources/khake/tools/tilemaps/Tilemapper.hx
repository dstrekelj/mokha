package khake.tools.tilemaps;

import khake.tools.tilemaps.Tile;
import khake.tools.tilemaps.Tilemap;

import kha.Image;

/**
	Utility class for creating tilemaps.
**/
class Tilemapper {
	public static function fromMatrix(tileWidth : Int, tileHeight : Int, tileSheet : Image, tileData : Array<Array<Int>>) : Tilemap {
		var tilemap = new Tilemap(tileWidth, tileHeight, tileSheet);

		var height = tileData.length;
		var width = tileData[0].length;

		for (y in 0...height) {
			for (x in 0...width) {
				tilemap.add(new Tile(x * tileWidth, y * tileHeight, tileWidth, tileHeight, tileData[y][x]));
			}
		} 

		return tilemap;
	}
}