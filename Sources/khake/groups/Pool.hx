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
        Creates new pool.
        @param  capacity    Maximum number of members allowed in pool
    **/
    public function new(capacity : Int) : Void {
        super();
        this.capacity = capacity;
    }
    
    /**
        Adds member to pool.
        @param  m   Member
        @return Member if pool is under capacity, null if pool is over capacity
    **/
    override public function add(m : T) : T {
        if (this.members.length >= this.capacity) return null;
        return super.add(m);
    }
}
