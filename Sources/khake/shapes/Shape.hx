package khake.shapes;

/**
 * Base shape class.
 */
class Shape {
    public var x : Float;
    public var y : Float;
    
    public function new(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }
    
    public function setPosition(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }
}
