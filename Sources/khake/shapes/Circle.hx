package khake.shapes;

class Circle extends Shape {
    public var r : Float;
    
    public function new(x : Float, y : Float, r : Float) {
        super(x, y);
        this.r = r;
    }
}
