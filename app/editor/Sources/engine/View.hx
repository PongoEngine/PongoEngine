package engine;

import towser.Html.*;
import towser.RenderFunction;
import engine.Model;
import engine.Update.GenMsg;
import perdita.Perdita.*;

class View
{
    public static function view(model:Model) : RenderFunction<Model, GenMsg>
	{
		var disableSelect = model.selectedFloater != null ? " disable-user-select" : "";
		return div([CLASS("full-screen" + disableSelect), MOUSE_DOWN(GlobalDown), MOUSE_UP(GlobalUp), MOUSE_MOVE(GlobalMove)], [
			div([CLASS("nav-bar color-container-darker border-bottom")], [
			]),
			div([CLASS("main-content flex-row")], [
				drawer(StretchColumn, ToggleColumn, model.columnLeft, [for (window in model.windows) accordianItem(ToggleWindow, window, [
					
				])]),
				div([CLASS("woah flex-column")], [
					div([CLASS("game-window")], [
						canvas([ID("khanvas"), WIDTH("1366"), HEIGHT("768"), TABINDEX("-1")])
					])
				]),
				drawer(StretchColumn, ToggleColumn, model.columnRight , [])
			]),
			div([], [for (f in model.floaters) window(SelectWindow, f, [
				div([STYLE({margin: "2px"})], [
					textfield(TextInput, model.text),
					textfield(TextInput, model.text2),
					div([], [
						p([], "Hello"),
						toggle(ToggleButton, model.button1)
					]),
					div([], [
						p([], "Goodbye"),
						toggle(ToggleButton, model.button2)
					])
				])
			])])
		]);
	}
}