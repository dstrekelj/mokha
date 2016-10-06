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
    public var x(get, null) : Int;
    
    /**
        Pointer Y position.
    **/
    public var y(get, null) : Int;
    
    /**
        Mouse wheel movement delta.
    **/
    public var dw(get, null) : Int;
    
    /**
        Pointer horizontal movement delta.
    **/
    public var dx(get, null) : Int;
    
    /**
        Pointer vertical movement delta.
    **/
    public var dy(get, null) : Int;

    /**
        A map of buttons pressed during a frame.
    **/
    public var buttonsPressed(get, null) : Map<Int, Bool>;
    
    /**
        `true` if any button is pressed or remains pressed this frame.
    **/
    public var isPressed(get, null) : Bool;

    /**
        `true` if any button was pressed last frame.
    **/
    public var justPressed(get, null) : Bool;

    /**
        `true` if any button was released last frame.
    **/
    public var justReleased(get, null) : Bool;

    /**
        Number of buttons pressed.
    **/
    public var buttonsPressedCount(get, null) : Int;

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
        buttonsPressed = new Map<Int, Bool>();
        buttonsPressedCount = 0;
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
        justPressed = false;
        justReleased = false;

        for (button in buttonsPressed.keys())
            if(!buttonsPressed.get(button))
                buttonsPressed.remove(button);
        
        if (buttonsPressedCount == 0) isPressed = false;
    }

    /**
        Performs a check to see if a button is currently pressed.
        Buttons are referenced by their integer IDs.
        @param  b   Button ID
        @return `true` if button is pressed
    **/
    public function isPressedButton(b : Int) : Bool {
        return isPressed && buttonsPressed.exists(b) && buttonsPressed.get(b);
    }

    /**
        Performs a check to see if a button was just pressed in the
        last frame. Buttons are referenced by their integer IDs.
        @param  b   Button ID
        @return `true` if button was just pressed
    **/
    public function justPressedButton(b : Int) : Bool {
        return justPressed && buttonsPressed.exists(b) && buttonsPressed.get(b);
    }

    /**
        Performs a check to see if a button was just released in the
        last frame. Buttons are referenced by their Integer IDs.
        @param  b   Button ID
        @return `true` if button was just released
    **/
    public function justReleasedButton(b : Int) : Bool {
        return justReleased && buttonsPressed.exists(b) && !buttonsPressed.get(b);
    }

    /**
        Handles the event of a mouse button being held down.
        @param  b   Mouse button ID
        @param  x   Mouse pointer X position
        @param  y   Mouse pointer Y position
    **/
    function onMouseDown(b : Int, x : Int, y : Int) : Void {
        buttonsPressed.set(b, true);
        buttonsPressedCount += 1;
        setX(x);
        setY(y);
        isPressed = true;
        justPressed = true;
    }

    /**
        Handles the event of a mouse button being released.
        @param  b   Mouse button ID
        @param  x   Mouse pointer X position
        @param  y   Mouse pointer Y position
    **/
    function onMouseUp(b : Int, x : Int, y : Int) : Void {
        buttonsPressed.set(b, false);
        buttonsPressedCount -= 1;
        setX(x);
        setY(y);
        justReleased = true;
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

    @:noCompletion inline function get_x() return x;

    @:noCompletion inline function get_y() return y;

    @:noCompletion inline function get_dw() return dw;

    @:noCompletion inline function get_dx() return dx;

    @:noCompletion inline function get_dy() return dy;

    @:noCompletion inline function get_buttonsPressed() return buttonsPressed;

    @:noCompletion inline function get_isPressed() return isPressed;

    @:noCompletion inline function get_justPressed() return justPressed;

    @:noCompletion inline function get_justReleased() return justReleased;

    @:noCompletion inline function get_buttonsPressedCount() return buttonsPressedCount;
}
