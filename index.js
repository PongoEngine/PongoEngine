const path = require("path");

const carlo = require("carlo");
const Bundler = require("parcel-bundler");

const bootstrap = async () => {
  const outDir = path.join(__dirname, "dist");
  const entryFile = path.join(__dirname, "app", "index.html");
  const opts = {
    outDir,
    outFile: "index.html",
    sourceMaps: true,
    reload: true,
    hmr: true
  };

  const bundler = new Bundler(entryFile, opts);
  await bundler.serve();

  carlo.launch().then(async app => {
    app.on("exit", () => process.exit());
    app.serveOrigin("http://localhost:1234"); // <-- fetch from the local server
    await app.load("http://localhost:1234");
  });
};

bootstrap();
