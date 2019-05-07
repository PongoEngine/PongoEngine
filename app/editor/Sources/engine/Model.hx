package engine;

import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.LineItem;
import perdita.model.util.PointerPosition;

class Model 
{
	public var drawerLeft :Drawer;
	public var drawerRight :Drawer;
	public var activePoint :PointerPosition;
	public var stretchableColumn :Drawer;
	public var selectedFloater :Window;
	public var floaters: Array<Window>;
	public var accordianItems: Array<AccordianItem>;
	public var lineItem :LineItem;

	public function new():Void 
	{
		this.drawerLeft = new Drawer(true);
		this.drawerRight = new Drawer(false);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;
		this.lineItem = new LineItem("Root", false);
		var c1 = new LineItem("child1", false);
		this.lineItem.children.push(c1);
		c1.children.push(new LineItem("gChild1", false));
		c1.children.push(new LineItem("gChild2", false));
		c1.children.push(new LineItem("gChild3", false));
		c1.children.push(new LineItem("gChild4", false));

		var c2 = new LineItem("child2", false);
		this.lineItem.children.push(c2);
		c2.children.push(new LineItem("gChild1", false));
		c2.children.push(new LineItem("gChild2", false));
		c2.children.push(new LineItem("gChild3", false));
		c2.children.push(new LineItem("gChild4", false));

		this.accordianItems = [
		];

		this.floaters = [
		];

		this.selectedFloater = null;
	}
}