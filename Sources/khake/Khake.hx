package khake;

/**
    Global variables.
**/
class Khake {
    @:allow(khake.Engine.init)
    public static var windowWidth(default, null) : Int;
    @:allow(khake.Engine.init)
    public static var windowHeight(default, null) : Int;
    @:allow(khake.Game)
    public static var renderWidth(default, null) : Int;
    @:allow(khake.Game)
    public static var renderHeight(default, null) : Int;
    @:allow(khake.Game)
    public static var game(default, null) : Game;
    @:allow(khake.Engine.update)
    public static var elapsed(default, null) : Float;
    @:allow(khake.Engine.update)
    public static var delta(default, null) : Float;
}
