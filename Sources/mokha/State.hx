package mokha;

import mokha.Camera;
import mokha.Object;

import kha.graphics2.Graphics;

/**
    States are containers of game logic. For example, a menu state
    would describe a game's menu screen, while a play state would
    describe a game's gameplay screen.
**/
class State {
    /**
        Reference to state camera.
    **/
    var camera : Camera;

    /**
        State objects.
    **/
    @:noCompletion var objects : Array<Object>;

    /**
        Creates new state.
    **/
    function new() : Void {
        camera = new Camera();
        objects = new Array<Object>();
    }

    /**
        Override this. Called when states are switched, after the
        previous state has been destroyed.
    **/
    public function onCreate() : Void {}

    /**
        Override this. Called when states are switched, before the
        next state is created.
    **/
    public function onDestroy() : Void {}

    /**
        Override this. Called before state is updated.
    **/
    public function preUpdate() : Void {}

    /**
        Override this. Called when state is updated.
    **/
    public function update() : Void {
        for (object in objects) object.update();

        camera.update();
    }

    /**
        Override this. Called after state is updated.
    **/
    public function postUpdate() : Void {
        for (object in objects) object.postUpdate();
    }

    /**
        Override this. Called before state is drawn.
    **/
    public function preDraw(g : Graphics) : Void {}

    /**
        Override this. Called when state is drawn.
    **/
    public function draw(g : Graphics) : Void {
        camera.draw(g);

        for (object in objects) {
            g.pushTransformation(g.transformation.multmat(object.transformer.transformation));
            object.draw(g);
            g.popTransformation();
        }
    }

    /**
        Override this. Called after state is drawn.
    **/
    public function postDraw(g : Graphics) : Void {}

    /**
        Adds object to state objects.
    **/
    inline function add(object : Object) : Void {
        objects.push(object);
    }
}
