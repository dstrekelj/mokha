package mokha;

import mokha.shapes.Rectangle;
import mokha.Object;

import kha.graphics2.Graphics;

/**
    A collection of static extensions for "painting" to the buffer.
**/
class Painter {
    /**
        Paints an instance of the `Rectangle` class.
        @param  g       Graphics
        @param  r       Rectangle instance
        @param  fill    If `true` rectangle is filled
    **/
    public static function paintRectangle(g : Graphics, r : Rectangle, fill : Bool = false) : Void {
        if (fill) g.fillRect(r.x, r.y, r.width, r.height)
        else g.drawRect(r.x, r.y, r.width, r.height);
    }

    /**
        Paints an instance of the `Object` class, taking into account
        the transformations applied to it.
        @param  g   Graphics
        @param  o   Object instance
    **/
    public static function paintObject(g : Graphics, o : Object) : Void {
        g.pushTransformation(o.transformer.transformation);
        o.draw(g);
        g.popTransformation();
    }
}
