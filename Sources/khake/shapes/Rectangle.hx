package khake.shapes;

/**
    Rectangle shape with collision logic.
**/
class Rectangle extends Shape {
    /**
        Rectangle width.
    **/
    public var width : Float;
    /**
        Rectangle height.
    **/
    public var height : Float;
    
    /**
        @param  x       Horizontal position (top left corner)
        @param  y       Vertical position (top left corner)
        @param  width   Rectangle width
        @param  height  Rectangle height
    **/
    public function new(x : Float, y : Float, width : Float, height : Float) {
        super(x, y);
        this.width = width;
        this.height = height;
    }
    
    /**
        Checks if rectangle area overlaps point.
        
        @param  x   Point horizontal position
        @param  y   Point vertical position
    **/
    public function collidesPoint(x : Float, y : Float) : Bool {
        if (this.x > x) return false;
        if (this.y > y) return false;
        if ((this.x + this.width) < x) return false;
        if ((this.y + this.width) < y) return false;
        return true;
    }
    
    /**
        Checks if rectange area overlaps another rectangle.
        
        @param  r   Rectangle
    **/
    public function collidesRectangle(r : Rectangle) : Bool {
        if (this.x > (r.x + r.width)) return false;
        if (this.y > (r.y + r.height)) return false;
        if ((this.x + this.width) < r.x) return false;
        if ((this.y + this.width) < r.y) return false;
        return true;
    }
}
