package engine.model;

import perdita.model.LineItem;
import perdita.model.Textfield;

class TreeItem extends LineItem
{
	public var content :TreeContent;
	public var id :Int;
	public var parentId :Int;

	public function new(isExpanded :Bool, id :Int) : Void
	{
		super(isExpanded);
		this.content = EMPTY;
		this.id = id;
		this.parentId = -1;
	}

	public static function getMatches(root :TreeItem, id :Int, ?matches :Array<TreeItem>) : Array<TreeItem>
	{
		if(matches == null) {
			matches = [];
		}

		if(root.id == id) {
			matches.push(root);
		}

		return switch root.content {
			case CHILDREN(children): {
				for(c in children) {
					getMatches(c, id, matches);
				}
				matches;
			}
			case _: matches;
		}
	}

	public static function addChild(parent :TreeItem, child :TreeItem) : TreeItem
	{
		child.parentId = parent.id;
		switch parent.content {
			case CHILDREN(children):
				children.push(child);
			case _:
				parent.content = CHILDREN([child]);
		}
		return parent;
	}

	public static function removeChild(parent :TreeItem, child :TreeItem) : TreeItem
	{
		switch parent.content {
			case CHILDREN(children):
				if(children.remove(child)) {
					child.parentId = -1;
				}
			case COMPONENT(text):
			case EMPTY:
		}
		return parent;
	}

	public static function setTextField(item :TreeItem, textField :Textfield) : TreeItem
	{
		item.content = COMPONENT(textField);
		return item;
	}

	public function clear() : TreeItem
	{
		this.content = EMPTY;
		return this;
	}
}