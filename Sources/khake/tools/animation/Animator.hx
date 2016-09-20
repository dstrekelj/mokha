package khake.tools.animation;

import khake.tools.animation.Animation;
import khake.tools.animation.AnimationFrame;
import khake.Khake;
import khake.Sprite;

import kha.graphics2.Graphics;

class Animator {
    /**
        Frame rectangle.
    **/
    var frame : AnimationFrame;

    /**
        Time accumulator.
    **/
    var timeAccumulator : Float;

    /**
        Animation map.
    **/
    var animations : Map<String, Animation>;

    /**
        Current animation.
    **/
    var animation : Animation;

    /**
        Number of frames horizontally along the spritesheet.
    **/
    var frameColumns : Int;

    /**
        Number of frames vertically along the spritesheet.
    **/
    var frameRows : Int;
    
    /**
        Creates new animator.
        @param  frameWidth  Animation frame width
        @param  frameHeight Animation frame height
        @param  sheetWidth  Sprite sheet width
        @param  sheetHeight Sprite sheet height
    **/
    public function new(frameWidth : Float, frameHeight : Float, sheetWidth : Float, sheetHeight : Float) {
        this.frame = new AnimationFrame(frameWidth, frameHeight);
        
        this.frameColumns = Std.int(sheetWidth / frameWidth);
        this.frameRows = Std.int(sheetHeight / frameHeight);
        this.timeAccumulator = 0;
        this.animations = new Map<String, Animation>();
        this.animation = null;
    }
    
    /**
        Updates animator.
    **/
    public function update() : Void {
        if (this.animation == null) return;

        this.timeAccumulator += Khake.delta;

        if (this.timeAccumulator < this.animation.frameRate) return;

        this.animation.update();
        this.frame.update(this.animation.frameIndex, frameRows, frameColumns);
        this.timeAccumulator = 0;
    }
    
    /**
        Draws current animation frame.
    **/
    public function draw(g : Graphics, sprite : Sprite) : Void {
        g.drawSubImage(sprite.graphic, sprite.x, sprite.y, this.frame.x, this.frame.y, this.frame.width, this.frame.height);
    }

    /**
        Destroys animator.
    **/
    public function destroy() : Void {
        this.animation = null;
        this.animations = null;
        this.frame = null;
    }
    
    /**
        Adds new animation.
        @param  label       Animation label
        @param  frames      Array of animation frame indices
        @param  frameRate   Animation frame rate
        @param  repeat      If `true`, animation restarts when done
    **/
    public function add(label : String, frames : Array<Int>, frameRate : Float, repeat : Bool) : Void {
        this.animations.set(label, new Animation(frames, frameRate, repeat));
    }
    
    /**
        Uses animation.
        @param  label   Animation label
    **/
    public function use(label : String) : Void {
        this.animation = this.animations.get(label);
        this.animation.reset();
        this.frame.update(this.animation.frameIndex, frameRows, frameColumns);
    }
}
