package mokha;

import mokha.Mokha;

import kha.graphics2.ImageScaleQuality;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

/**
    The game class prepares a backbuffer to which states draw. The
    backbuffer is defined by the game's rendering resolution (width
    and height). It also handles states and state changes.
**/
class Game {
    /**
        Rendering resolution width.
    **/
    var width : Int;

    /**
        Rendering resolution height.
    **/
    var height : Int;

    /**
        Backbuffer to which current state draws.
    **/
    var backbuffer : Image;

    /**
        Reference to current state.
    **/
    var state : State;
    
    /**
        @param  width   Rendering resolution width
        @param  height  Rendering resolution height
        @param  state   Initial state
    **/
    public function new(width : Int, height : Int, state : Class<State>) : Void {
        this.width = width;
        this.height = height;
        
        this.backbuffer = Image.createRenderTarget(width, height);
        
        Mokha.game = this;
        Mokha.renderWidth = width;
        Mokha.renderHeight = height;
        this.switchState(state);
    }
    
    /**
        Updates current game state.
    **/
    public function update() : Void { 
        if (this.state != null) this.state.update();
    }
    
    /**
        Renders current game state. Backbuffer is scaled to fit the
        framebuffer, which has its dimensions defined by the window.
        @param  f   Framebuffer
    **/
    public function render(f : Framebuffer) : Void {
        var bg = this.backbuffer.g2;
        bg.begin(true, kha.Color.Black);
        if (state != null) state.draw(bg);
        bg.end();
        var fg = f.g2;
        fg.begin(true, kha.Color.Blue);
        fg.imageScaleQuality = ImageScaleQuality.High;
        Scaler.scale(backbuffer, f, System.screenRotation);
        fg.end();
    }
    
    /**
        Switches current state to a different one. Current state is
        destroyed before the next state is created.
    **/
    public function switchState(s : Class<State>) : Void {
        if (this.state != null) this.state.onDestroy();
        this.state = Type.createInstance(s, []);
        this.state.onCreate();
    }
}
