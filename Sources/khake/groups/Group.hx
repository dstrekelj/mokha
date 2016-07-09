package khake.groups;

import khake.Object;

import kha.graphics2.Graphics;

/**
        A group is a collection of objects.
**/
class Group<T : Object> extends Object {
    /**
            Group members array.
    **/
    var members : Array<T>;
    
    public function new() {
        super();
        this.members = new Array<T>();
    }
    
    /**
            Updates all members (if both group and group member are active).
    **/
    override public function update() : Void {
        if (this.isActive) {
            for (m in this.members) {
                if (m.isActive) m.update();
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
                if (m.isVisible) m.draw(g);
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
        });
        this.members = null;
    }
    
    /**
            Adds member to group.
            
            @param  m   Member to add
    **/
    public function add(m : T) : T {
        this.members.push(m);
        return m;
    } 
    
    /**
            Removes member from group.
            
            @param  m   Member to remove
    **/
    public function remove(m : T) : T {
        var index = this.members.indexOf(m);
        if (index < 0) return null;
        this.members.splice(index, 1);
        return m;
    }
    
    /**
            Iterates over every member of group and executes function on it.
            
            @param  f   Callback function
    **/
    public function each(f : T->Void) : Void {
        for (m in this.members) f(m);
    }
}
