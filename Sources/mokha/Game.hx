package mokha;

import mokha.Mokha;

import kha.graphics2.ImageScaleQuality;
import kha.Color;
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
        Backbuffer to which current state draws.
    **/
    var backbuffer : Image;

    /**
        Reference to current state.
    **/
    var state : State;

    /**
        Image scale quality, in case the backbuffer is scaled to
        framebuffer size.
    **/
    var imageScaleQuality : ImageScaleQuality;

    /**
        Game configuration structure.
    **/
    var config : GameConfig;
    
    /**
        Creates a new game.
        @param  config  Game configuration structure
    **/
    public function new(config : GameConfig) : Void {
        if (config.antiAlias == null) config.antiAlias = true;
        if (config.width == null) config.width = Mokha.windowWidth;
        if (config.height == null) config.height = Mokha.windowHeight;
        if (config.backbuffer == null) config.backbuffer = { clear : true, color: Color.Black };
        if (config.framebuffer == null) config.framebuffer = { clear : true, color: Color.Black };

        this.config = config;
        
        backbuffer = Image.createRenderTarget(config.width, config.height);

        imageScaleQuality = config.antiAlias ? ImageScaleQuality.High : ImageScaleQuality.Low;

        Mokha.game = this;
        Mokha.renderWidth = config.width;
        Mokha.renderHeight = config.height;

        switchState(config.state);
    }
    
    /**
        Override this. Updates current game state.
    **/
    public function update() : Void {
        if (state != null) state.update();
    }
    
    /**
        Override this. Draws current game state. Backbuffer is 
        scaled to fit the framebuffer, which has its dimensions 
        defined by the window.
        @param  f   Framebuffer
    **/
    public function draw(f : Framebuffer) : Void {
        var bg = backbuffer.g2;
        
        bg.begin(config.backbuffer.clear, config.backbuffer.color);
        if (state != null) state.draw(bg);
        bg.end();
        
        var fg = f.g2;
        
        fg.begin(config.framebuffer.clear, config.framebuffer.color);
        fg.imageScaleQuality = imageScaleQuality;
        Scaler.scale(backbuffer, f, System.screenRotation);
        fg.end();
    }
    
    /**
        Switches current state to a different one. Current state is
        destroyed before the next state is created.
        @param  state   State class
    **/
    public function switchState(state : Class<State>) : Void {
        if (this.state != null) this.state.onDestroy();
        this.state = Type.createInstance(state, []);
        this.state.onCreate();
    }
}

/**
    Game configuration options.
    @param  state           Initial game state
    @param  ?width          Render width
    @param  ?height         Render height
    @param  ?backbuffer     Backbuffer configuration
    @param  ?framebuffer    Framebuffer configuration
    @param  ?antiAlias      If `true`, backbuffer scaling will be anti-aliased
**/
typedef GameConfig = {
    state : Class<State>,
    ?width : Int,
    ?height : Int,
    ?backbuffer : BufferConfig,
    ?framebuffer : BufferConfig,
    ?antiAlias : Bool
}

/**
    Buffer configuration options.
    @param  clear   If `true`, buffer is cleared
    @param  color   Buffer clear color
**/
typedef BufferConfig = {
    clear : Bool,
    color : Color
}
