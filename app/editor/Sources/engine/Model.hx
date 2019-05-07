package engine;

import perdita.model.Textfield;
import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.LineItem;
import perdita.model.Textfield;
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
	public var lineItem :TreeItem;

	public function new():Void 
	{
		this.drawerLeft = new Drawer(true);
		this.drawerRight = new Drawer(false);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;
		this.lineItem = new TreeItem("Root", false);
		var c1 = new TreeItem("child1", false);
		this.lineItem.addChild(c1);
		c1
			.addChild(new TreeItem("gChild1", false)
				.setTextField(new Textfield("Robot", "")))
			.addChild(new TreeItem("gChild2", false)
				.setTextField(new Textfield("Clams", "")))
			.addChild(new TreeItem("gChild3", false)
				.setTextField(new Textfield("Position", "")))
			.addChild(new TreeItem("gChild4", false));

		var c2 = new TreeItem("child2", false);
		this.lineItem.addChild(c2);
		c2
			.addChild(new TreeItem("gChild1", false))
			.addChild(new TreeItem("gChild2", false))
			.addChild(new TreeItem("gChild3", false))
			.addChild(new TreeItem("gChild4", false));

		this.accordianItems = [
		];

		this.floaters = [
		];

		this.selectedFloater = null;
	}
}

class TreeItem extends LineItem
{
	public var content :TreeContent;

	public function new(title :String, isExpanded :Bool) : Void
	{
		super(title, isExpanded);
		this.content = EMPTY;
	}

	public function addChild(item :TreeItem) : TreeItem
	{
		switch this.content {
			case CHILDREN(children):
				children.push(item);
			case _:
				this.content = CHILDREN([item]);
		}
		return this;
	}

	public function setTextField(textField :Textfield) : TreeItem
	{
		this.content = COMPONENT(textField);
		return this;
	}

	public function clear() : TreeItem
	{
		this.content = EMPTY;
		return this;
	}
}

enum TreeContent
{
	EMPTY;
	CHILDREN(children :Array<TreeItem>);
	COMPONENT(text :Textfield);
}