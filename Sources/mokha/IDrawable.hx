package mokha;

interface IDrawable {
	var body : mokha.shapes.Rectangle;
	var transformer : mokha.utils.transformation.Transformer;
	function draw(g : kha.graphics2.Graphics) : Void;
}
