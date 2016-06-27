package khake;

import khake.groups.Group;

class State extends Group<Object> {
    /**
            Called when states are switched after the previous state has been
            destroyed.
    **/
    public function onCreate() : Void {
    }
    
    /**
            Called when states are switched before the next state is created.
    **/
    public function onDestroy() : Void {
        this.destroy();
    }
}
