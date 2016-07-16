package khake;

import khake.Khake;
import khake.managers.input.MouseInputManager;

import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Engine {
    static var width : Int;
    static var height : Int;
    static var elapsed : Float;
    static var delta : Float;
    static var game : Game;

    public static function init(_game : Class<Game>, _title : String, _width : Int, _height : Int, _frameRate : Float) {
        elapsed = 0;
        delta = 0;
        System.init({ title : _title, width : _width, height : _height }, function () {
            Khake.windowWidth = _width;
            Khake.windowHeight = _height;
            Assets.loadEverything(function () {
                game = Type.createInstance(_game, []);

                MouseInputManager.get();

                System.notifyOnRender(render);
                Scheduler.addTimeTask(update, 0, _frameRate);
            });
        });
    }

    static function render(framebuffer : Framebuffer) : Void {
        game.render(framebuffer);
    }

    static function update() : Void {
        delta = Scheduler.time() - elapsed;
        elapsed = Scheduler.time();

        Khake.delta = delta;
        Khake.elapsed = elapsed;

        game.update();
    }
}