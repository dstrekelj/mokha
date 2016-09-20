package khake.tools.animation;

class AnimationFrame {
	/**
		X position on sprite sheet.
	**/
	public var x(get, null) : Float;
	inline function get_x() return this.x;

	/**
		Y position on sprite sheet.
	**/
	public var y(get, null) : Float;
	inline function get_y() return this.y;

	/**
		Width.
	**/
	public var width(get, null) : Float;
	inline function get_width() return this.width;

	/**
		Height.
	**/
	public var height(get, null) : Float;
	inline function get_height() return this.height;

	/**
		Row index in sprite sheet.
	**/
	public var row(get, null) : Int;
	inline function get_row() return this.row;

	/**
		Column index in sprite sheet.
	**/
	public var column(get, null) : Int;
	inline function get_column() return this.column;

	/**
		Creates new animation frame.
	**/
	public function new(width : Float, height : Float) : Void {
		this.width = width;
		this.height = height;

		this.x = 0;
		this.y = 0;
		this.row = 0;
		this.column = 0;
	}

	/**
		Updates animation frame position on sprite sheet.
	**/
	public function update(frameIndex : Int, totalRows : Int, totalColumns : Int) : Void {
		this.row = Std.int(frameIndex / totalColumns);
		this.column = Std.int(frameIndex - this.row * totalColumns);
		this.y = this.row * this.height;
		this.x = this.column * this.width;
	}
}