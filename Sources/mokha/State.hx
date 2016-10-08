package mokha;

import kha.graphics2.Graphics;

/**
    States are containers of game logic. For example, a menu state
    would describe a game's menu screen, while a play state would
    describe a game's gameplay screen.
**/
class State {
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
    public function update() : Void {}

    /**
        Override this. Called after state is updated.
    **/
    public function postUpdate() : Void {}

    /**
        Override this. Called before state is drawn.
    **/
    public function preDraw(g : Graphics) : Void {}

    /**
        Override this. Called when state is drawn.
    **/
    public function draw(g : Graphics) : Void {}

    /**
        Override this. Called after state is drawn.
    **/
    public function postDraw(g : Graphics) : Void {}
}
