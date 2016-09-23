package mokha;

/**
    Global variables.
**/
class Mokha {
    /**
        Width in therms of window.
    **/
    @:allow(mokha.Engine.init)
    public static var windowWidth(default, null) : Int;

    /**
        Height in terms of window.
    **/
    @:allow(mokha.Engine.init)
    public static var windowHeight(default, null) : Int;
    
    /**
        Width in terms of rendering resolution.
    **/
    @:allow(mokha.Game)
    public static var renderWidth(default, null) : Int;
    
    /**
        Height in terms of rendering resolution.
    **/
    @:allow(mokha.Game)
    public static var renderHeight(default, null) : Int;

    /**
        Total time elapsed.
    **/
    @:allow(mokha.Engine.update)
    public static var elapsed(default, null) : Float;

    /**
        Delta time between frames.
    **/
    @:allow(mokha.Engine.update)
    public static var delta(default, null) : Float;
    
    /**
        Current game instance.
    **/
    @:allow(mokha.Game)
    static var game(default, null) : Game;

    /**
        Switches between states.
        @param  state   State
    **/
    public static inline function switchState(state : Class<mokha.State>) : Void {
        game.switchState(state);
    }
}
