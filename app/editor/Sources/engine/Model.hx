package engine;

import haxe.Serializer;
import haxe.Unserializer;

import perdita.model.Textfield;
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
	public var lineItem :TreeItem;

	@:keep
	function hxSerialize(s:Serializer) {
		s.serialize(drawerLeft);
		s.serialize(drawerRight);
		s.serialize(activePoint);
		s.serialize(stretchableColumn);
		s.serialize(selectedFloater);
		s.serialize(floaters);
		s.serialize(accordianItems);
		s.serialize(lineItem);
	}

	@:keep
	function hxUnserialize(u:Unserializer) {
		drawerLeft = u.unserialize();
		drawerRight = u.unserialize();
		activePoint = u.unserialize();
		stretchableColumn = u.unserialize();
		selectedFloater = u.unserialize();
		floaters = u.unserialize();
		accordianItems = u.unserialize();
		lineItem = u.unserialize();
	}

	public function new():Void 
	{
		this.drawerLeft = new Drawer(true);
		this.drawerRight = new Drawer(false);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;
		this.lineItem = new TreeItem(false);
		var c1 = new TreeItem(false);
		this.lineItem.addChild(c1);
		c1
			.addChild(new TreeItem(false)
				.setTextField(new Textfield("Robot", "")))
			.addChild(new TreeItem(false)
				.setTextField(new Textfield("Clams", "")))
			.addChild(new TreeItem(false)
				.setTextField(new Textfield("Position", "")))
			.addChild(new TreeItem(false));

		var c2 = new TreeItem(false);
		this.lineItem.addChild(c2);
		c2
			.addChild(new TreeItem(false))
			.addChild(new TreeItem(false))
			.addChild(new TreeItem(false))
			.addChild(new TreeItem(false));

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

	public function new(isExpanded :Bool) : Void
	{
		super(isExpanded);
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

	@:keep
	override function hxSerialize(s:Serializer) {
		super.hxSerialize(s);
		s.serialize(content);
	}

	@:keep
	override function hxUnserialize(u:Unserializer) {
		super.hxUnserialize(u);
		content = u.unserialize();
	}
}

enum TreeContent
{
	EMPTY;
	CHILDREN(children :Array<TreeItem>);
	COMPONENT(text :Textfield);
}