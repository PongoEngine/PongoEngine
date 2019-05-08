var gulp = require('gulp');
var browsersync = require('browser-sync').create();
var gulpSass = require('gulp-sass');
var fs = require("fs-extra");

function copyAssets() {
    fs.copy("app/web/assets", "build/html5/assets");
}

function browserSyncReload(done) {
    browsersync.reload();
    done();
}

function browserSync(done) {
    browsersync.init({
        server: {
            baseDir: "./build/html5",
        },
        port: 3000,
        open: false,
        notify: false
    });
    done();
}

function sass() {
    return gulp
        .src("app/web/scss/*.scss")
        .pipe(gulpSass())
        .pipe(gulp.dest("build/html5/"))
        .pipe(browsersync.stream());
}

function watchFiles() {
    gulp.watch("app/web/scss/*.scss", sass);
    gulp.watch("build/html5/kha_browserified.js", gulp.series(copyAssets, browserSyncReload));
}

sass();
gulp.parallel(watchFiles, browserSync)();