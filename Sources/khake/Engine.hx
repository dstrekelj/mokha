package khake;

import khake.managers.input.KeyboardInputManager;
import khake.managers.input.MouseInputManager;
import khake.Khake;

import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

/**
    The engine initializes the current game, sets up the window and 
    framerate.
**/
class Engine {
    /**
        Total elapsed time.
    **/
    static var elapsed : Float;

    /**
        Time elapsed between frames.
    **/
    static var delta : Float;

    /**
        Current game object.
    **/
    static var game : Game;

    /**
        Keyboard input manager.
    **/
    static var keyboardInputManager : KeyboardInputManager;

    /**
        Mouse input manager.
    **/
    static var mouseInputManager : MouseInputManager;

    /**
        Initialises the Khake "engine".
        @param  _game       Game object
        @param  _title      Window title
        @param  _width      Window width
        @param  _height     Window height
        @param  _frameRate  Update frame rate
    **/
    public static function init(_game : Class<Game>, _title : String, _width : Int, _height : Int, _frameRate : Float) : Void {
        elapsed = 0;
        delta = 0;
        
        System.init({ title: _title, width: _width, height: _height }, function () {
            Khake.windowWidth = _width;
            Khake.windowHeight = _height;
            
            Assets.loadEverything(function () {
                game = Type.createInstance(_game, []);

                keyboardInputManager = KeyboardInputManager.get();
                mouseInputManager = MouseInputManager.get();

                System.notifyOnRender(render);
                Scheduler.addTimeTask(update, 0, _frameRate);
            });
        });
    }

    /**
        Renders game to framebuffer.
        @param  framebuffer Framebuffer
    **/
    static function render(framebuffer : Framebuffer) : Void {
        game.render(framebuffer);
    }

    /**
        Updates game and engine parameters.
    **/
    static function update() : Void {
        delta = Scheduler.time() - elapsed;
        elapsed = Scheduler.time();

        Khake.delta = delta;
        Khake.elapsed = elapsed;

        keyboardInputManager.update();
        mouseInputManager.update();

        game.update();
    }
}