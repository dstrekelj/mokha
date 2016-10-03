package mokha.managers.input;

import mokha.Mokha;

import kha.input.Mouse;

/**
    Helper class for managing mouse / touch input.
**/
class MouseInputManager {
    /**
        Mouse input manager instance.
    **/
    static var instance : MouseInputManager;

    /**
        Pointer X position.
    **/
    public var x : Int;
    
    /**
        Pointer Y position.
    **/
    public var y : Int;
    
    /**
        Mouse wheel movement delta.
    **/
    public var dw : Int;
    
    /**
        Pointer horizontal movement delta.
    **/
    public var dx : Int;
    
    /**
        Pointer vertical movement delta.
    **/
    public var dy : Int;
    
    /**
        ID of button pressed.
    **/
    public var buttonId : Int;
    
    /**
        State of any button press.
    **/
    public var isPressed : Bool;

    /**
        Horizontal scale factor.
    **/
    var scaleX : Float;

    /**
        Vertical scale factor.
    **/
    var scaleY : Float;

    /**
        Creates new mouse input manager.
    **/
    function new() : Void {
        Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, onMouseWheel);
        
        scaleX = Mokha.renderWidth / Mokha.windowWidth;
        scaleY = Mokha.renderHeight / Mokha.windowHeight;
    }

    /**
        Gets existing mouse input manager if possible, otherwise
        creates a new instance.
        @return Mouse input manager instance
    **/
    public static function get() : MouseInputManager {
        if (instance == null) instance = new MouseInputManager();
        return instance;
    }

    /**
        Updates tracked mouse input states.
    **/
    public function update() : Void {
        dy = 0;
        dx = 0;
        dw = 0;
    }

    /**
        Handles the event of a mouse button being held down.
        @param  b   Mouse button ID
        @param  x   Mouse pointer X position
        @param  y   Mouse pointer Y position
    **/
    function onMouseDown(b : Int, x : Int, y : Int) : Void {
        buttonId = b;
        setX(x);
        setY(y);
        isPressed = true;
    }

    /**
        Handles the event of a mouse button being released.
        @param  b   Mouse button ID
        @param  x   Mouse pointer X position
        @param  y   Mouse pointer Y position
    **/
    function onMouseUp(b : Int, x : Int, y : Int) : Void {
        buttonId = b;
        setX(x);
        setY(y);
        isPressed = false;
    }

    /**
        Handles the event of the mouse pointer being moved.
        @param  x   Mouse pointer X position
        @param  y   Mouse pointer Y position
        @param  dx  Mouse pointer horizontal movement delta
        @param  dy  Mouse pointer vertical movement delta
    **/
    function onMouseMove(x : Int, y : Int, dx : Int, dy : Int) : Void {
        setX(x);
        setY(y);
        this.dx = dx;
        this.dy = dy;
    }

    /**
        Handles the event of the mouse wheel being used.
        @param  dw  Mouse wheel movement delta
    **/
    function onMouseWheel(dw : Int) : Void {
        this.dw = dw;
    }

    /**
        Sets mouse X position according to scale factor.
        @param  x   Mouse X position
    **/
    inline function setX(x : Int) : Void {
        this.x = (scaleX == 1) ? x : Std.int(x * scaleX);
    }

    /**
        Sets mouse Y position according to scale factor.
        @param  y   Mouse Y position
    **/
    inline function setY(y : Int) : Void {
        this.y = (scaleY == 1) ? y : Std.int(y * scaleY);
    }
}
