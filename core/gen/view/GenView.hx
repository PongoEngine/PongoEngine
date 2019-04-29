package gen.view;

import towser.Html.*;
import towser.RenderFunction;
import gen.update.GenMsg;
import gen.model.GenModel;
import perdita.Perdita.*;

class GenView {
	public static function view(model:GenModel) : RenderFunction<GenModel, GenMsg>
	{
		return div([CLASS("full-screen"), MOUSE_DOWN(GlobalDown), MOUSE_UP(GlobalUp), MOUSE_MOVE(GlobalMove)], [
			div([CLASS("nav-bar color-container-darker border-bottom")], [
				pushButton(ToggleButton, model.button1, [p([], "Hello")])
			]),
			div([CLASS("main-content flex-row")], [
				column(StretchColumn, ToggleColumn, model.columnLeft ,[for (window in model.columnLeft.windows) collapsingWindow(ToggleWindow, window, [
					pushButton(ToggleButton, model.button2, [p([], "Hello")]),
					inputText(TextInput, model.text)
				])]),
				div([CLASS("woah flex-column")], [
					div([CLASS("game-window")], []),
					// bottom(model.bottom, [
					// 	pushButton(model.button2, [p([], "Hello")]),
					// 	inputText(model.text)
					// ])
				]),
				column(StretchColumn, ToggleColumn, model.columnRight ,[for (window in model.columnRight.windows) collapsingWindow(ToggleWindow, window, [

				])])
			]),
			div([], [for (f in model.floaters) floater(SelectWindow, f, [])])
		]);
	}
}