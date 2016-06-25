package khake;

import kha.graphics2.Graphics;

class Group<T : Object> extends Object {
    var members : Array<T>;
    
    public function new() {
        super();
        this.members = new Array<T>();
    }
    
    override public function update() : Void {
        if (this.isActive) {
            for (m in this.members) {
                if (m.isActive) m.update();
            }
        }
    }
    
    override public function draw(g : Graphics) : Void {
        if (this.isVisible) {
            for (m in this.members) {
                if (m.isVisible) m.draw(g);
            }
        }
    }
    
    public function add(m : T) : T {
        this.members.push(m);
        return m;
    } 
    
    public function remove(m : T) : T {
        var index = this.members.indexOf(m);
        if (index < 0) return null;
        this.members.splice(index, 1);
        return m;
    }
    
    public function each(f : T->Void) : Void {
        for (m in this.members) f(m);
    }
}
