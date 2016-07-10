package khake.shapes;

class Ellipse extends Shape {
    public var a : Float;
    public var b : Float;
    
    public function new(x : Float, y : Float, a : Float, b : Float) {
        super(x, y);
        this.a = a;
        this.b = b;
    }
}
