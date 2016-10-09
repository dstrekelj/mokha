package mokha.utils.transformation;

import mokha.shapes.Rectangle;

import kha.math.FastMatrix3;

/**
    The transformer handles the transformation matrix of an object.
    The matrix is defined by the object's position and angle of
    rotation.
**/
class Transformer {
    /**
        Angle of rotation applied during the draw call.
    **/
    public var angle : Float;

    /**
        A reference object body, for translation.
    **/
    public var body : Rectangle;

    /**
        Transformation matrix.
    **/
    public var transformation(get, null) : FastMatrix3;

    /**
        Creates new transformer.
    **/
    public function new() : Void {
        body = new Rectangle(0, 0, 0, 0);
        transformation = FastMatrix3.identity();
        angle = 0;
    }

    /**
        Destroys transformer.
    **/
    public function destroy() : Void {
        body = null;
        transformation = null;
    }
    
    @:noCompletion inline function get_transformation() : FastMatrix3 {
        return FastMatrix3.translation(body.x, body.y).multmat(FastMatrix3.rotation(angle));
    }
}