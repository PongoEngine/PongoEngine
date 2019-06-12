package engine.model;

import perdita.model.Textfield;

enum TreeContent
{
	EMPTY;
	CHILDREN(children :Array<TreeItem>);
	COMPONENT(text :Textfield);
}