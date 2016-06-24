package khake.shapes;

/**
 * Rectangle shape with collision logic.
 */
class Rectangle extends Shape {
    public var width : Float;
    public var height : Float;
    
    public function new(x : Float, y : Float, width : Float, height : Float) {
        super(x, y);
        this.width = width;
        this.height = height;
    }
    
    public function collidesPoint(x : Float, y : Float) : Bool {
        if (this.x > x) return false;
        if (this.y > y) return false;
        if ((this.x + this.width) < x) return false;
        if ((this.y + this.width) < y) return false;
        return true;
    }
    
    public function collidesRectangle(r : Rectangle) : Bool {
        if (this.x > (r.x + r.width)) return false;
        if (this.y > (r.y + r.height)) return false;
        if ((this.x + this.width) < r.x) return false;
        if ((this.y + this.width) < r.y) return false;
        return true;
    }
}
