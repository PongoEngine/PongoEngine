
let project = new Project('Pongo Engine');


project.addSources("lib/Towser/src");
project.addSources('lib/Pongo/Sources');
project.addSources('lib/Perdita/src/haxe');
project.addAssets("app/editor/Assets/**");
project.addSources('app/editor/Sources');
project.addParameter("--cmd node ../app/web/index.js");
project.addParameter("--cmd npx browserify html5/kha.js > html5/kha_browserified.js");

resolve(project);

