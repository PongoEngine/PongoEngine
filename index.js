const path = require("path");
const { exec } = require("child_process");

const carlo = require("carlo");
const Bundler = require("parcel-bundler");

const bootstrap = async () => {
  const outDir = path.join(__dirname, "dist");
  const entryFile = path.join(__dirname, "app", "index.html");
  const opts = {
    outDir,
    outFile: "index.html",
    sourceMaps: true,
    hmr: true
  };

  const bundler = new Bundler(entryFile, opts);
  await bundler.serve(4321);
  const cApp = await carlo.launch();
  await cApp.exposeFunction("compileGame", file => {
    var dir = path.dirname(file);
    var makePath = path.resolve("./lib/Kha/make.js");
    return cd(dir, makePath);
  });
  cApp.serveFolder(outDir);
  await cApp.load("localhost:4321");
};

function cd(dir, makePath) {
  return new Promise(function(resolve, reject) {
    exec(`cd ${dir}; node ${makePath} html5`, function(error, stdout, stderr) {
      if (stderr) {
        reject(stderr);
      } else {
        resolve(stdout);
      }
    });
  });
}

bootstrap();
