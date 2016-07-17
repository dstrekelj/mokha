package khake.systems;

import khake.Engine;
import khake.Object;
import khake.Sprite;
import khake.shapes.Rectangle;

import kha.graphics2.Graphics;

class AnimationSystem extends Object {
    var sprite : Sprite;
    var frame : Rectangle;
    var timer : Float;
    var animations : Map<String, Animation>;
    var animation : Animation;
        
    public function new(sprite : Sprite, frameWidth : Float, frameHeight : Float) {
        super();
        this.sprite = sprite;
        this.frame = new Rectangle(0, 0, frameWidth, frameHeight);
        this.timer = 0;
        this.animations = new Map<String, Animation>();
        this.animation = null;
    }
    
    override public function update() : Void {
        if (this.animation != null) {
            this.timer += khake.Khake.delta;
            if (this.timer >= this.animation.frameRate) {
                this.animation.update();
                this.frame.x = this.animation.frameIndex * this.frame.width;
                this.timer = 0;
            }
        }
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
        g.drawSubImage(this.sprite.graphic, this.sprite.x, this.sprite.y, this.frame.x, this.frame.y, this.frame.width, this.frame.height);
    }
    
    public function add(label : String, frames : Array<Int>, frameRate : Float, repeat : Bool) : Void {
        animations.set(label, new Animation(frames, frameRate, repeat));
    }
    
    public function use(label : String) : Void {
        this.animation = this.animations.get(label);
        this.animation.reset();
        this.frame.x = this.frame.width * this.animation.frameIndex;
    }
}

private class Animation {
    public var frames : Array<Int>;
    public var frameRate : Float;
    public var repeat : Bool;
    public var frameIndex : Int;
    public var active : Bool;
    
    var index : Int;
    
    public function new(frames : Array<Int>, frameRate : Float, repeat : Bool) {
        this.frames = frames;
        this.frameRate = frameRate;
        this.repeat = repeat;
        this.active = true;
        this.index = 0;
        this.frameIndex = this.frames[this.index];
    }
    
    public function update() : Void {
        if (this.active) {
            this.index += 1;
            if (this.index >= this.frames.length) {
                if (this.repeat) {
                    this.index = 0;
                } else {
                    this.index = this.frames.length - 1;
                    this.active = false;
                }                
            }
            this.frameIndex = this.frames[this.index];
        }
    }
    
    public function reset() : Void {
        this.index = 0;
        this.frameIndex = this.frames[this.index];
        this.active = true;
    }
}
