package khake.tools.collision;

import khake.shapes.Rectangle;
import khake.Entity;

import haxe.ds.Vector;

/**
    QuadTrees are a space partitioning data structure useful for
    collisions in 2D space. The screen is split into four regions,
    each of which can in itself be another QuadTree. Objects are
    added to the QuadTree and passed grouped in these regions.
    Afterwards, collision checks can be only on those objects in
    a specific region, instead of all of them. 
**/
class QuadTree extends Rectangle {
    /**
        Maximum number of QuadTree subdivisions.
    **/
    var maxDepth : Int;

    /**
        Maximum number of items in a region before it is split.
    **/
    var maxItems : Int;

    /**
        Region depth level.
    **/
    var depth : Int;

    /**
        Region items.
    **/
    var items : Array<Entity>;

    /**
        Region nodes (subdivisions).
    **/
    var nodes : Vector<QuadTree>;

    /**
        Creates a QuadTree.
        @param  x           Region X position
        @param  y           Region Y position
        @param  width       Region width
        @param  height      Region height
        @param  maxDepth    Maximum depth level
        @param  maxItems    Maximum item count
        @param  depth       Current depth level
    **/
    function new(x : Float, y : Float, width : Float, height : Float, maxDepth : Int, maxItems : Int, depth : Int) : Void {
        super(x, y, width, height);
        this.depth = depth;
        this.maxDepth = maxDepth;
        this.maxItems = maxItems;
        clear();
    }

    /**
        Gets an existing QuadTree root or creates a new one.
        @param  x           Region X position
        @param  y           Region Y position
        @param  width       Region width
        @param  height      Region height
        @param  maxDepth    Maximum depth level
        @param  maxItems    Maximum item count
    **/
    public static function create(x : Float, y : Float, width : Float, height : Float, maxDepth : Int, maxItems : Int) : QuadTree {
        return new QuadTree(x, y, width, height, maxDepth, maxItems, 0);
    }

    /**
        Clears QuadTree by removing all items and nodes.
    **/
    public function clear() : Void {
        this.items = new Array<Entity>();
        this.nodes = null;
    }

    /**
        Inserts item into QuadTree.
        @param  item    Entity item
    **/
    public function insert(item : Entity) : Void {
        if (this.items.length >= this.maxItems && this.depth < this.maxDepth) {
            if (this.nodes == null) {
                split();
            }
            forward(item);
        }
        
        this.items.push(item);
    }

    public function find(item : Entity) : Array<Entity> {
        
    }

    /**
        Destroys QuadTree.
    **/
    public function destroy() : Void {
        this.items = null;
        for (node in this.nodes) {
            node.destroy();
        }
        this.nodes = null;
    }

    /**
        Splits QuadTree region into four smaller QuadTrees.
    **/
    function split() : Void {
        this.nodes = new Vector<QuadTree>(4);

        var nodeWidth = this.width / 2;
        var nodeHeight = this.height / 2;

        this.nodes[0] = new QuadTree(x + nodeWidth, y             , nodeWidth, nodeHeight, maxDepth, maxItems, depth + 1);
        this.nodes[1] = new QuadTree(x + nodeWidth, y + nodeHeight, nodeWidth, nodeHeight, maxDepth, maxItems, depth + 1);
        this.nodes[2] = new QuadTree(x            , y + nodeHeight, nodeWidth, nodeHeight, maxDepth, maxItems, depth + 1);
        this.nodes[3] = new QuadTree(x            , y             , nodeWidth, nodeHeight, maxDepth, maxItems, depth + 1);
    }

    /**
        Forwards item into appropriate node.
    **/
    function forward(item : Entity) : Void {
        for (node in this.nodes) {
            if (item.hitbox.overlapsRectangle(node)) {
                node.insert(item);
            }
        }
    }
}