package mokha.utils.animation;

/**
    An animation consists of frame indices, a frame rate, and
    behavioural flags.
**/
class Animation {
    /**
        Animation frame indices.
    **/
    public var frameIndices : Array<Int>;

    /**
        Animation frame rate.
    **/
    public var frameRate : Float;

    /**
        If `true`, the animation is currently active.
    **/
    public var isActive : Bool;

    /**
        If `true`, the animation repeats when done.
    **/
    public var isRepeating : Bool;
    
    /**
        Current frame index number.
    **/
    public var frameIndex : Int;

    /**
        Position in frame indices array.
    **/
    var index : Int;
    
    /**
        Creates new animation.
        @param  frameIndices    Array of animation frame indices
        @param  frameRate       Animation frame rate
        @param  isRepeating     If `true`, the animation repeats when done.
    **/
    public function new(frameIndices : Array<Int>, frameRate : Float, isRepeating : Bool) : Void {
        this.frameIndices = frameIndices;
        this.frameRate = frameRate;
        this.isRepeating = isRepeating;
        
        this.isActive = true;
        this.index = 0;
        this.frameIndex = this.frameIndices[this.index];
    }
    
    /**
        Updates animation.
    **/
    public function update() : Void {
        if (!this.isActive) return;

        this.frameIndex = this.frameIndices[this.index];
        this.index += 1;

        if (this.index >= this.frameIndices.length) {
            this.index = 0;
            this.isActive = this.isRepeating;
        }
    }
    
    /**
        Resets animation to the first frame and makes it active again.
    **/
    public function reset() : Void {
        this.index = 0;
        this.frameIndex = this.frameIndices[this.index];
        this.isActive = true;
    }
}