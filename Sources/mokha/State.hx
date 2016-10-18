package mokha;

import mokha.Camera;
import mokha.Object;

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
        State objects.
    **/
    var objects : Array<Object>;

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
        Override this. Called when state is updated.
    **/
    public function update() : Void {
        for (object in objects) object.update();

        camera.update();
    }

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
        Adds object to the front of the state.
        @param  object  Object
    **/
    inline function add(object : Object) : Void {
        objects.push(object);
    }

    /**
        Adds object to the back of the state.
        @param  object  Object
    **/
    inline function addToBack(object : Object) : Void {
        objects.insert(0, object);
    }

    /**
        Remove object from state. Object is not destroyed.
        @param  object  Object
    **/
    inline function remove(object : Object) : Void {
        objects.remove(object);
    }

    /**
        Sends existing object to the front of the state.
        @param  object  Object
    **/
    inline function sendToFront(object : Object) : Void {
        if (objects.remove(object)) objects.push(object);
    }

    /**
        Sends existing object to the back of the state.
        @param  object  Object
    **/
    inline function sendToBack(object : Object) : Void {
        if (objects.remove(object)) objects.insert(0, object);
    }
}
