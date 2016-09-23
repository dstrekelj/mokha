package mokha.managers.input;

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
        Creates new mouse input manager.
    **/
    function new() : Void {
        Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, onMouseWheel);
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
        @param  _b  Mouse button ID
        @param  _x  Mouse pointer X position
        @param  _y  Mouse pointer Y position
    **/
    function onMouseDown(_b : Int, _x : Int, _y : Int) : Void {
        buttonId = _b;
        x = _x;
        y = _y;
        isPressed = true;
    }

    /**
        Handles the event of a mouse button being released.
        @param  _b  Mouse button ID
        @param  _x  Mouse pointer X position
        @param  _y  Mouse pointer Y position
    **/
    function onMouseUp(_b : Int, _x : Int, _y : Int) : Void {
        buttonId = _b;
        x = _x;
        y = _y;
        isPressed = false;
    }

    /**
        Handles the event of the mouse pointer being moved.
        @param  _x  Mouse pointer X position
        @param  _y  Mouse pointer Y position
        @param  _dx Mouse pointer horizontal movement delta
        @param  _dy Mouse pointer vertical movement delta
    **/
    function onMouseMove(_x : Int, _y : Int, _dx : Int, _dy : Int) : Void {
        x = _x;
        y = _y;
        dx = _dx;
        dy = _dy;
    }

    /**
        Handles the event of the mouse wheel being used.
        @param  _dw Mouse wheel movement delta
    **/
    function onMouseWheel(_dw : Int) : Void {
        dw = _dw;
    }
}
