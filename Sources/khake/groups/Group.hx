package khake.groups;

import khake.Object;

import kha.graphics2.Graphics;

/**
    A group is a collection of objects.
**/
class Group<T : Object> extends Object {
    /**
        Called after an object in the group is updated.
    **/
    public var onUpdate : T->Void;
    
    /**
        Called after an object in the group is drawn.
    **/
    public var onDraw : T->Void;
    
    /**
        Called after an object in the group is destroyed.
    **/
    public var onDestroy : Void->Void;
    
    /**
        Called after an object is added to the group.
    **/
    public var onAdd : T->Void;
    
    /**
        Called after an object is removed from the group.
    **/
    public var onRemove : T->Void;

    /**
        Group members array.
    **/
    var members : Array<T>;
    
    /**
        Creates new group.
    **/
    public function new() : Void {
        super();
        this.members = new Array<T>();
    }
    
    /**
        Updates all members (if both group and group member are active).
    **/
    override public function update() : Void {
        if (this.isActive) {
            for (m in this.members) {
                if (m.isActive) {
                    m.update();
                    if (onUpdate != null) onUpdate(m);
                }
            }
        }
    }
    
    /**
        Draws all members (if both group and group member are visible).
        @param  g   G2 API access to framebuffer
    **/
    override public function draw(g : Graphics) : Void {
        if (this.isVisible) {
            for (m in this.members) {
                if (m.isVisible) {
                    m.draw(g);
                    if (onDraw != null) onDraw(m);
                }
            }
        }
    }
    
    /**
        Nulls references.
    **/
    override public function destroy() : Void {
        super.destroy();
        this.each(function (m : T) {
            m.destroy();
            if (onDestroy != null) onDestroy();
        });
        this.members = null;
    }
    
    /**
        Adds member to group.
        @param  m   Member to add
        @return Added group member
    **/
    public function add(m : T) : T {
        this.members.push(m);
        if (onAdd != null) onAdd(m);
        return m;
    } 
    
    /**
        Removes member from group.
        @param  m   Member to remove
        @return Removed group member
    **/
    public function remove(m : T) : T {
        var index = this.members.indexOf(m);
        if (index < 0) return null;
        this.members.splice(index, 1);
        if (onRemove != null) onRemove(m);
        return m;
    }
    
    /**
        Iterates over every member of group and executes function on it.
        @param  f   Callback function
    **/
    public function each(f : T->Void) : Void {
        for (m in this.members) f(m);
    }

    /**
        Exposes the iterator of the members array.
        @return Iterator over group members
    **/
    public function iterator() : Iterator<T> {
        return this.members.iterator();
    }
}
