package mokha.collections;

import mokha.Object;

/**
    An object pool is an extension of an object group which limits the
    number of members allowed inside the group by defining a capacity.
**/
class Pool<T : mokha.Object> extends mokha.Object {
    public var capacity(get, null) : Int;

    var objects : Array<T>;

    public function new(capacity : Int) : Void {
        super();

        this.capacity = capacity;

        objects = new Array<T>();
    }

    override public function update() : Void {
        super.update();

        for (object in objects) if (object.isActive) object.update();
    }

    override public function draw(g : kha.graphics2.Graphics) : Void {
        super.draw(g);

        for (object in objects) {
            if (object.isVisible) {
                g.pushTransformation(g.transformation.multmat(object.transformer.transformation));
                object.draw(g);
                g.popTransformation();
            }
        }
    }

    public function add(object : T) : Bool {
        if (objects.length >= capacity) return false;
        if (mokha.tools.ArrayTools.has(objects, object)) return false;

        objects.push(object);
        return true;
    }

    public function remove(object : T) : Bool {
        if (!mokha.tools.ArrayTools.has(objects, object)) return false;

        return objects.remove(object);
    }

    public function recycle() : T {
        for (object in objects) if (!object.isAlive) return object;
        return null;
    }

    public function iterator() : Iterator<T> {
        return objects.iterator();
    }

    @:noCompletion inline function get_capacity() return capacity;
}
