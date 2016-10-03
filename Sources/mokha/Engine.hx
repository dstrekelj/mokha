package mokha;

import mokha.Mokha;

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
        Initialises the mokha "engine".
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
            Mokha.windowWidth = _width;
            Mokha.windowHeight = _height;
            
            Assets.loadEverything(function () {
                game = Type.createInstance(_game, []);

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
        game.preDraw(framebuffer);
        game.draw(framebuffer);
        game.postDraw(framebuffer);
    }

    /**
        Updates game and engine parameters.
    **/
    static function update() : Void {
        delta = Scheduler.time() - elapsed;
        elapsed = Scheduler.time();

        Mokha.delta = delta;
        Mokha.elapsed = elapsed;
        
        game.preUpdate();
        game.update();
        game.postUpdate();
    }
}