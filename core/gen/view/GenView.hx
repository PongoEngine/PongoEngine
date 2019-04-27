package gen.view;

import towser.Html.*;
import towser.RenderFunction;
import gen.view.UI.*;
import gen.update.GenMsg;
import gen.model.GenModel;

class GenView {
	public static function view(model:GenModel) : RenderFunction<GenModel, GenMsg>
	{
		return div([CLASS("full-screen"), MOUSE_DOWN(GlobalDown), MOUSE_UP(GlobalUp), MOUSE_MOVE(GlobalMove)], [
			div([CLASS("nav-bar color-container-darker border-bottom")], [
				pushButton(model.button1, [p([], "Hello")])
			]),
			div([CLASS("main-content flex-row")], [
				column(model.columnLeft ,[]),
				div([CLASS("woah flex-column")], [
					div([CLASS("game-window")], []),
					bottom(model.bottom, [
						pushButton(model.button2, [p([], "Hello")]),
						inputText(model.text)
					])
				]),
				column(model.columnRight ,[for (window in model.columnRight.windows) collapsingWindow(window, [

				])])
			]),
			floater(model.floater, [])
		]);
	}
}