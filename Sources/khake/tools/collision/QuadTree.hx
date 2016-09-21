package khake.tools.collision;

import khake.shapes.Rectangle;
import khake.Entity;

import haxe.ds.Vector;

using khake.utils.ArrayUtils;

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
        Maximum number of entities in a region before it is split.
    **/
    var maxEntities : Int;

    /**
        Region depth level.
    **/
    var depth : Int;

    /**
        Region entities.
    **/
    var entities : Array<Entity>;

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
        @param  maxEntities Maximum entity count
        @param  depth       Current depth level
    **/
    function new(x : Float, y : Float, width : Float, height : Float, maxDepth : Int, maxEntities : Int, depth : Int) : Void {
        super(x, y, width, height);
        this.depth = depth;
        this.maxDepth = maxDepth;
        this.maxEntities = maxEntities;
        clear();
    }

    /**
        Gets an existing QuadTree root or creates a new one.
        @param  x           Region X position
        @param  y           Region Y position
        @param  width       Region width
        @param  height      Region height
        @param  maxDepth    Maximum depth level
        @param  maxEntities Maximum entity count
    **/
    public static function create(x : Float, y : Float, width : Float, height : Float, maxDepth : Int, maxEntities : Int) : QuadTree {
        return new QuadTree(x, y, width, height, maxDepth, maxEntities, 0);
    }

    /**
        Clears QuadTree by removing all entities and nodes.
    **/
    public function clear() : Void {
        this.entities = new Array<Entity>();
        
        if (nodes != null) {
            for (node in nodes) {
                node.clear();
            }
            this.nodes = null;
        }
    }

    /**
        Inserts item into QuadTree.
        @param  entity    Entity item
    **/
    public function insert(entity : Entity) : Void {
        if (this.entities.length >= this.maxEntities && this.depth < this.maxDepth) {
            if (this.nodes == null) {
                split();
            }
            forward(entity);
        }
        
        this.entities.push(entity);
    }

    /**
        Fetches the environment surrounding an entity in the QuadTree.
        @param  environment An array which will contain the entities in the environment
        @param  entity      Entity item
    **/
    public function fetch(entity : Entity) : Array<Entity> {
        var environment = new Array<Entity>();

        trace('depth ${this.depth}, total: ${this.entities.length}');

        if (this.nodes != null) {
            for (node in this.nodes) {
                if (entity.hitbox.overlapsRectangle(node)) {
                    environment = environment.concat(node.fetch(entity));
                }
            }
        } else {
            environment = environment.concat(this.entities);
        }
        
        return environment;
    }

    /**
        Destroys QuadTree.
    **/
    public function destroy() : Void {
        this.entities = null;
        for (node in this.nodes) {
            node.destroy();
        }
        this.nodes = null;
    }

    public function draw(g : kha.graphics2.Graphics) : Void {
        g.color = kha.Color.Red;
        g.drawRect(this.x, this.y, this.width, this.height);
        if (this.nodes != null) {
            for (node in this.nodes) {
                node.draw(g);
            }
        }
        g.color = kha.Color.White;
    }

    /**
        Splits QuadTree region into four smaller QuadTrees.
    **/
    function split() : Void {
        this.nodes = new Vector<QuadTree>(4);

        var nodeWidth = this.width / 2;
        var nodeHeight = this.height / 2;

        this.nodes[0] = new QuadTree(x + nodeWidth, y             , nodeWidth, nodeHeight, maxDepth, maxEntities, depth + 1);
        this.nodes[1] = new QuadTree(x + nodeWidth, y + nodeHeight, nodeWidth, nodeHeight, maxDepth, maxEntities, depth + 1);
        this.nodes[2] = new QuadTree(x            , y + nodeHeight, nodeWidth, nodeHeight, maxDepth, maxEntities, depth + 1);
        this.nodes[3] = new QuadTree(x            , y             , nodeWidth, nodeHeight, maxDepth, maxEntities, depth + 1);
        
        for (entity in this.entities) {
            forward(entity);
        }
    }

    /**
        Forwards item into appropriate node.
    **/
    function forward(entity : Entity) : Void {
        for (node in this.nodes) {
            if (entity.hitbox.overlapsRectangle(node)) {
                node.insert(entity);
            }
        }
    }
}