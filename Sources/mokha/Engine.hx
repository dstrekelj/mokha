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
        Current game object.
    **/
    static var game : Game;

    /**
        Initialises the mokha "engine".
        @param  config  Engine configuration structure
    **/
    public static function init(config : EngineConfig) : Void {
        if (config.title == null) config.title = "Mokha";
        if (config.width == null) config.width = 640;
        if (config.height == null) config.height = 480;
        if (config.frameRate == null) config.frameRate = 1 / 60;

        var systemOptions : SystemOptions = {
            title: config.title,
            width: config.width,
            height: config.height,
            samplesPerPixel: config.antiAliasing
        };

        System.init(systemOptions, function () {
            Assets.loadEverything(function () {
                Mokha.elapsed = 0;
                Mokha.delta = 0;
                Mokha.windowWidth = systemOptions.width;
                Mokha.windowHeight = systemOptions.height;

                game = Type.createInstance(config.game, []);
            
                System.notifyOnRender(render);
                Scheduler.addTimeTask(update, 0, config.frameRate);
            });
        });
    }

    /**
        Renders game to framebuffer.
        @param  framebuffer Framebuffer
    **/
    static function render(framebuffer : Framebuffer) : Void {
        game.draw(framebuffer);
    }

    /**
        Updates game and engine parameters.
    **/
    static function update() : Void {
        Mokha.delta = Scheduler.time() - Mokha.elapsed;
        Mokha.elapsed = Scheduler.time();
        
        game.update();
    }
}

/**
    Engine configuration options.
    @param  game            Game class
    @param  ?frameRate      Game frame rate, defaults to 1 / 60
    @param  ?height         Window height
    @param  ?antiAliasing   Number of samples per pixel, defaults to 1 (no anti-aliasing)
    @param  ?title          Window title
    @param  ?width          Window width
**/
typedef EngineConfig = {
    game : Class<Game>,
    ?frameRate : Float,
    ?height : Int,
    ?antiAliasing : Int,
    ?title : String,
    ?width : Int
}
