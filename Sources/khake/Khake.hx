package khake;

/**
    Global variables.
**/
class Khake {
    /**
        Width in therms of window.
    **/
    @:allow(khake.Engine.init)
    public static var windowWidth(default, null) : Int;

    /**
        Height in terms of window.
    **/
    @:allow(khake.Engine.init)
    public static var windowHeight(default, null) : Int;
    
    /**
        Width in terms of rendering resolution.
    **/
    @:allow(khake.Game)
    public static var renderWidth(default, null) : Int;
    
    /**
        Height in terms of rendering resolution.
    **/
    @:allow(khake.Game)
    public static var renderHeight(default, null) : Int;

    /**
        Total time elapsed.
    **/
    @:allow(khake.Engine.update)
    public static var elapsed(default, null) : Float;

    /**
        Delta time between frames.
    **/
    @:allow(khake.Engine.update)
    public static var delta(default, null) : Float;
    
    /**
        Current game instance.
    **/
    @:allow(khake.Game)
    static var game(default, null) : Game;

    /**
        Switches between states.
        @param  state   State
    **/
    public static inline function switchState(state : Class<khake.State>) : Void {
        game.switchState(state);
    }
}
