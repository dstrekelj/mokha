package khake.tools.collision;

import khake.Entity;
import khake.shapes.Rectangle;

import haxe.ds.Vector;

class QuadTree extends Rectangle {
    private static inline var MAX_DEPTH : Int = 4;
    private static inline var MAX_ITEMS : Int = 4;

    private static var instance : QuadTree;

    private var depth : Int;
    private var items : Array<Entity>;
    private var nodes : Vector<QuadTree>;

    private function new(depth : Int, x : Float, y : Float, width : Float, height : Float) {
        super(x, y, width, height);
        this.depth = depth;
        this.items = new Array<Entity>();
        this.nodes = new Vector<QuadTree>(4);
    }

    public static function get(x : Float, y : Float, width : Float, height : Float) : QuadTree {
        if (instance == null) {
            instance = new QuadTree(0, x, y, width, height);
        }
        return instance;
    }

    public function clear() : Void {
    }

    public function add() : Void {
        if (this.items.length > MAX_ITEMS && this.depth < MAX_DEPTH) {
            split();
        }
    }

    private function split() : Void {
        var nodeWidth = this.width / 2;
        var nodeHeight = this.height / 2;

        nodes[0] = new QuadTree(depth + 1, x, y, nodeWidth, nodeHeight);
        nodes[1] = new QuadTree(depth + 1, x + nodeWidth, y, nodeWidth, nodeHeight);
        nodes[2] = new QuadTree(depth + 1, x + nodeWidth, y + nodeHeight, nodeWidth, nodeHeight);
        nodes[3] = new QuadTree(depth + 1, x, y + nodeHeight, nodeWidth, nodeHeight);
    }
}