package mokha;

/**
    Global variables.
**/
class Mokha {
    /**
        Draw window width.
    **/
    @:allow(mokha.Engine)
    public static var windowWidth(default, null) : Int;

    /**
        Draw window height.
    **/
    @:allow(mokha.Engine)
    public static var windowHeight(default, null) : Int;
    
    /**
        Rendering resolution width.
    **/
    @:allow(mokha.Game)
    public static var renderWidth(default, null) : Int;
    
    /**
        Rendering resolution height.
    **/
    @:allow(mokha.Game)
    public static var renderHeight(default, null) : Int;

    /**
        Total time elapsed.
    **/
    @:allow(mokha.Engine)
    public static var elapsed(default, null) : Float;

    /**
        Delta time between frames.
    **/
    @:allow(mokha.Engine)
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
