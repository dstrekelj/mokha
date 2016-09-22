package khake.tools.tilemaps;

/**
	A tile is an element of a tilemap.
**/
class Tile extends khake.Object {
	public var x : Float;
	public var y : Float;
	public var width : Float;
	public var height : Float;
	public var index : Int;

	public function new(x : Float, y : Float, width : Float, height : Float, index : Int) : Void {
		super();
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.index = index;
	}
}