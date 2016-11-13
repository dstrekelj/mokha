package mokha;

import mokha.Camera;

import kha.graphics2.Graphics;

/**
    States are containers of game logic. For example, a menu state
    would describe a game's menu screen, while a play state would
    describe a game's gameplay screen.

    A state handles the objects assigned to it, and also defines a
    camera which 'observes' the objects. The camera's transformation
    matrix is applied to the objects before they're drawn, so that
    the objects are presented from the viewpoint of the camera.
**/
class State {
    /**
        Reference to state camera.
    **/
    var camera : Camera;

    /**
        Creates new state.
    **/
    function new() : Void {
        camera = new Camera();
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
        Override this. Called when state is updated.
    **/
    public function update() : Void {
        camera.update();
    }

    /**
        Override this. Called when state is drawn.
    **/
    public function draw(g : Graphics) : Void {
        camera.draw(g);
    }
}
