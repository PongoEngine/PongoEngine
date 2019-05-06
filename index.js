var browserSync = require('browser-sync');

/**
 * Run Browsersync with server config
 */
browserSync({
    server: "build/html5",
    files: ["build/html5/style.css", "build/html5/kha_browserified.js"]
});