package mokha.collections;

import mokha.Object;

import kha.graphics2.Graphics;

using mokha.tools.ArrayTools;

/**
    A layer wraps around a collection of objects and allows for
    objects to be moved back and forth between layers.
**/
class Layer extends Object {
    /**
        Layer items.
    **/
    var items : Array<Object>;

    /**
        Creates a new layer.
    **/
    public function new() : Void {
        super();
        
        items = new Array<Object>();
    }

    /**
        Handles layer items pre-update call for all active items.
    **/
    override public function preUpdate() : Void {
        super.preUpdate();

        for (item in items) if (item.isActive) item.preUpdate();
    }

    /**
        Handles layer items update call for all active items.
    **/
    override public function update() : Void {
        super.update();

        for (item in items) if (item.isActive) item.update();
    }

    /**
        Handles layer items post-update call for all active items.
    **/
    override public function postUpdate() : Void {
        super.postUpdate();

        for (item in items) if (item.isActive) item.postUpdate();
    }

    /**
        Handles layer items draw call for all visible items.
        @param  g   Graphics
    **/
    override public function draw(g : Graphics) : Void {
        super.draw(g);

        for (item in items) if (item.isVisible) item.draw(g);
    }

    /**
        Adds layer item to front of layer.
        @param  item    Item
        @return `true` if item did not exist in layer before and was now added
    **/
    public inline function addToFront(item : Object) : Bool {
        if (!items.has(item)) {
            items.insert(0, item);
            return true;
        }
        return false;
    }

    /**
        Adds layer item to back of layer.
        @param  item    Item
        @return `true` if item did not exist in layer before and was now added
    **/
    public inline function addToBack(item : Object) : Bool {
        if (!items.has(item)) {
            items.push(item);
            return true;
        }
        return false;
    }

    /**
        Removes layer item.
        @param  item    Item
        @return `true` if item exists in layer and was now removed
    **/
    public function remove(item : Object) : Bool {
        if (items.has(item)) {
            items.remove(item);
            return true;
        }
        return false;
    }

    /**
        Sends item to front of layer.
        @param  item    Item
        @return `true` if item exists in layer and was moved to front
    **/
    public function sendToFront(item : Object) : Bool {
        if (items.has(item)) {
            items.remove(item);
            items.insert(0, item);
            return true;
        }
        return false;
    }

    /**
        Sends item to back of layer.
        @param  item    Item
        @return `true` if item exists in layer and was moveed to back
    **/
    public function sendToBack(item : Object) : Bool {
        if (items.has(item)) {
            items.remove(item);
            items.push(item);
            return true;
        }
        return false;
    }
}