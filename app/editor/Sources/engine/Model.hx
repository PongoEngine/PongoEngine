package engine;

import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
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
		this.lineItem.children.push(new LineItem("child1", false));
		this.lineItem.children.push(new LineItem("child2", false));

		this.accordianItems = [
		];

		this.floaters = [
		];

		this.selectedFloater = null;
	}
}

class LineItem
{
	public var title :String;
	public var isExpanded :Bool;
	public var children (default, null) :Array<LineItem>;

	public function new(title :String, isExpanded :Bool) : Void
	{
		this.title = title;
		this.isExpanded = isExpanded;
		this.children = [];
	}
}