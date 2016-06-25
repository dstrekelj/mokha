package khake.shapes;

/**
        Base shape class.
**/
class Shape {
    /**
            Shape horizontal position.
    **/
    public var x : Float;
    /**
            Shape vertical position.
    **/
    public var y : Float;
    
    /**
            @param  x   Horizontal position
            @param  y   Vertical position
    **/
    public function new(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }
    
    /**
            Shorthand for setting shape position.
            
            @param  x   Horizontal position
            @param  y   Vertical position
    **/
    public function setPosition(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }
}
