package khake.managers.input;

import kha.Key;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.Surface;

class MouseInputManager {
    public var x : Int;
    public var y : Int;
    public var dw : Int;
    public var dx : Int;
    public var dy : Int;
    public var buttonId : Int;
    public var isPressed : Bool;
    public var isReleased : Bool;
    
    static var instance : MouseInputManager;

    function new() {
        Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, onMouseWheel);
    }

    public static function get() : MouseInputManager{
        if (instance == null) instance = new MouseInputManager();
        return instance;
    }

    function onMouseDown(_b : Int, _x : Int, _y : Int) : Void {
        buttonId = _b;
        x = _x;
        y = _y;
        isPressed = true;
    }

    function onMouseUp(_b : Int, _x : Int, _y : Int) : Void {
        buttonId = _b;
        x = _x;
        y = _y;
        isPressed = false;
    }

    function onMouseMove(_x : Int, _y : Int, _dx : Int, _dy : Int) : Void {
        x = _x;
        y = _y;
        dx = _dx;
        dy = _dy;
    }

    function onMouseWheel(_dw : Int) : Void {
        dw = _dw;
    }
}
