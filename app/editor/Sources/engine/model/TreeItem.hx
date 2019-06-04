package engine.model;

import perdita.model.LineItem;
import perdita.model.Textfield;

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
}