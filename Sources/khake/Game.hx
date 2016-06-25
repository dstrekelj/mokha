package khake;

import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

class Game {
    public var width : Int;
    public var height : Int;
    
    var backbuffer : Image;
    var state : State;
    
    public function new(width : Int, height : Int, state : Class<State>) {
        this.width = width;
        this.height = height;
        this.backbuffer = Image.createRenderTarget(width, height);
        Khake.game = this;
        switchState(state);
    }
    
    public function update() : Void {
        if (state != null) state.update();
    }
    
    public function render(f : Framebuffer) : Void {
        var bg = this.backbuffer.g2;
        bg.begin();
        if (state != null) state.draw(bg);
        bg.end();
        var fg = f.g2;
        fg.begin();
        Scaler.scale(backbuffer, f, System.screenRotation);
        fg.end();
    }
    
    public function switchState(s : Class<State>) {
        if (this.state != null) this.state.onDestroy();
        this.state = Type.createInstance(s, []);
        this.state.onCreate();
    }
}
