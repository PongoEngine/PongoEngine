package perdita;

import towser.Architecture;
import towser.RenderFunction;
import perdita.update.PerditaUpdate;
import perdita.update.PerditaMsg;
import perdita.model.PerditaModel;

class Perdita {
	public static function app<Msg, Model:PerditaModel>(element :String, update :Msg -> Model -> Bool, view :Model -> RenderFunction<Model, PerditaMsg<Msg>>, model :Model) {
		new Architecture(element, PerditaUpdate.update.bind(update), view, model);
	}
}
