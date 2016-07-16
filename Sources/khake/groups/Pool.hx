package khake.groups;

import khake.Object;

/**
    An object pool is an extension of an object group which limits the
    number of members allowed inside the group by defining a capacity.
**/
class Pool<T : Object> extends Group<T> {
    /**
        Pool capacity. Read-only.
    **/
    public var capacity(get, null) : Int;
    inline function get_capacity() : Int { return this.capacity; }
    
    /**
        @param  capacity    Maximum number of members allowed in pool
    **/
    public function new(capacity : Int) {
        super();
        this.capacity = capacity;
    }
    
    /**
        Adds member to pool and returns it if pool is under capacity.
        If pool is over capacity, returns null.
    **/
    override public function add(m : T) : T {
        if (this.members.length >= this.capacity) return null;
        return super.add(m);
    }
}
