package mokha.collections;

import mokha.IDestroyable;

/**
    An object pool handles the instantiation and reuse of objects with
    short lifespans. The idea is to create a pool of a certain
    capacity, fill it with objects, and then take objects from the
    pool when necessary.
**/
class Pool<T : IDestroyable>  {
    /**
        The number of available pool objects.
    **/
    public var available(get, null) : Int;

    /**
        The array of objects forming the pool.
    **/
    var pool : Array<T>;

    /**
        Creates a new pool of a certain capacity.
        @param  capacity    Maximum number of pooled objects
    **/
    public function new() : Void {
        available = 0;

        pool = new Array<T>();
    }

    /**
        Adds object to pool. An object won't be added to the pool if
        it is null, the pool is at capacity, if it already exists in
        the pool, or if it's already in use.
        @param  object  Object
        @return `true` if object is successfully added to pool
    **/
    public function add(object : T) : Bool {
        if (object == null) return false;

        var i = pool.indexOf(object);
        if (i != -1 || i < available) return false;

        pool[available++] = object;

        return true
    }

    /**
        Empties the pool.
        @return An array of objects that were in the pool before emptying it
    **/
    public function empty() : Array<T> {
        available = 0;
        var old = pool;
        pool = [];
        return old;
    }

    /**
        Fills pool with a set number of objects, creating instances
        according to passed arguments. If the number of objects is
        greater than the capacity, the pool will be filled to
        capacity.
        @param  count   Number of objects to fill the pool with
        @param  args    Array of arguments to pass to the constructor
    **/
    public function fill(count : Int, ?args : Array<Dynamic> = []) : Void {
        while (count-- > 0)
            pool[available++] = Type.createInstance(Class<T>, args);
    }

    /**
        Gets an object from the pool if available, or creates a new
        instance with the provided arguments.
        @param  args    Array of arguments to pass to the constructor
        @return Object
    **/
    public function get(?args : Array<Dynamic> = []) : T {
        if (available == 0) return Type.createInstance(Class<T>, args);
        return pool[--available];
    }

    @:noCompletion inline function get_available() return available;
}
