package gen.view;

import iqua.Html.*;
import iqua.RenderFunction;
import gen.view.UI.*;
import gen.update.GenMsg;
import gen.model.GenModel;
import iqua.Lazy;

class GenView {
	// public static function view(model:GenModel) : RenderFunction<GenModel, GenMsg>
	// {
	// 	return Lazy.lazy1("hello", cool)(model);
	// }

	public static function view(model:GenModel) : RenderFunction<GenModel, GenMsg>
	{
		return div([CLASS("full-screen"), MOUSE_DOWN(null,GlobalDown), MOUSE_UP(null,GlobalUp), MOUSE_MOVE(null,GlobalMove)], [
			div([CLASS("nav-bar border-bottom")], [
				pushButton(model.button1, [p([], "Hello")])
			]),
			div([CLASS("main-content flex-row")], [
				column(model.columnLeft ,[for (window in model.columnLeft.windows) collapsingWindow(window, [
					
				])]),
				div([CLASS("woah flex-column")], [
					div([CLASS("game-window")], []),
					bottom(model.bottom, [
						pushButton(model.button2, [p([], "Hello")]),
						inputText(model.text)
					])
				]),
				column(model.columnRight ,[for (window in model.columnRight.windows) collapsingWindow(window, [

				])])
			])
		]);
	}
}