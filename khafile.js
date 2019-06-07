
let project = new Project('Pongo Engine');


project.addParameter('--macro pongo.platform.asset.ManifestBuilder.use("../app/editor/Assets")');
project.addParameter('--macro include("game", true)');

project.addSources("lib/Towser/src");
project.addSources('lib/Pongo/Sources');
project.addSources('lib/Perdita/src/haxe');
project.addSources('lib/Typer/src');
project.addAssets("app/editor/Assets/**");
project.addSources('app/editor/Sources');
project.addSources('app/editor/Sources');
// project.addParameter("--connect 6000");
// project.addParameter("--cmd npx browserify html5/kha.js | npx terser --compress --mangle > html5/kha_browserified.js");
project.addParameter("--cmd npx browserify html5/kha.js > html5/kha_browserified.js");

resolve(project);