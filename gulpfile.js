const gulp = require("gulp");
const del = require("filedel");
const less = require("gulp-less");
const pug = require("gulp-pug");
const coffee = require("gulp-coffee");
const rename = require("gulp-rename");
const cleanCSS = require("gulp-clean-css");
const babel = require("gulp-babel");
const uglify = require("gulp-uglify");
const concat = require("gulp-concat");
const sourcemaps = require("gulp-sourcemaps");
const autoprefixer = require("gulp-autoprefixer");
const htmlmin = require("gulp-htmlmin");
const browserSync = require("browser-sync").create();

const paths = {
    pug: {
        src: "src/**/*.pug",
        dest: "dist/",
    },
    styles: {
        src: "src/styles/styles.less",
        dest: "dist/styles/",
    },
    scripts: {
        src: "src/scripts/**/*.coffee",
        dest: "dist/scripts/",
    },
    img: {
        src: "src/img/**/*.*",
        dest: "dist/img/",
    },
    fonts: {
        src: "src/fonts/**/*.*",
        dest: "dist/fonts/",
    },
};

function clean() {
    return del([
        "dist/*.*",
        paths.styles.dest + "*.*",
        paths.scripts.dest + "*.*",
    ]);
}

function img() {
    return gulp.src(paths.img.src).pipe(gulp.dest(paths.img.dest));
}

function fonts() {
    return gulp.src(paths.fonts.src).pipe(gulp.dest(paths.fonts.dest));
}

function html() {
    return gulp
        .src(paths.pug.src)
        .pipe(pug())
        .pipe(
            htmlmin({
                collapseWhitespace: true,
            })
        )
        .pipe(gulp.dest(paths.pug.dest))
        .pipe(browserSync.stream());
}

function styles() {
    return gulp
        .src(paths.styles.src)
        .pipe(sourcemaps.init())
        .pipe(less())
        .pipe(
            autoprefixer({
                cascade: false,
            })
        )
        .pipe(cleanCSS())
        .pipe(
            rename({
                basename: "styles",
                suffix: ".min",
            })
        )
        .pipe(sourcemaps.write("./"))
        .pipe(gulp.dest(paths.styles.dest))
        .pipe(browserSync.stream());
}

function stylesRelease() {
    return gulp
        .src(paths.styles.src)
        .pipe(less())
        .pipe(
            autoprefixer({
                cascade: false,
            })
        )
        .pipe(cleanCSS())
        .pipe(
            rename({
                basename: "styles",
                suffix: ".min",
            })
        )
        .pipe(gulp.dest(paths.styles.dest))
        .pipe(browserSync.stream());
}

function watch() {
    browserSync.init({
        server: {
            baseDir: "./dist",
        },
    });
    gulp.watch(paths.pug.src, html).on("change", browserSync.reload);
    gulp.watch(paths.styles.src, styles);
    gulp.watch(paths.scripts.src, scripts);
    gulp.watch(paths.img.src, img);
    gulp.watch(paths.fonts.src, fonts);
}

function scripts() {
    return gulp
        .src(paths.scripts.src)
        .pipe(sourcemaps.init())
        .pipe(coffee())
        .pipe(
            babel({
                presets: ["@babel/env"],
            })
        )
        .pipe(uglify())
        .pipe(concat("scripts.min.js"))
        .pipe(sourcemaps.write("./"))
        .pipe(gulp.dest(paths.scripts.dest))
        .pipe(browserSync.stream());
}

function scriptsRelease() {
    return gulp
        .src(paths.scripts.src)
        .pipe(coffee())
        .pipe(
            babel({
                presets: ["@babel/env"],
            })
        )
        .pipe(uglify())
        .pipe(concat("scripts.min.js"))
        .pipe(gulp.dest(paths.scripts.dest))
        .pipe(browserSync.stream());
}

const build = gulp.series(
    gulp.parallel(styles, scripts, html, img, fonts),
    watch
);
const release = gulp.series(
    clean,
    gulp.parallel(stylesRelease, scriptsRelease, html, img, fonts)
);

exports.default = build;
exports.clean = clean;
exports.html = html;
exports.styles = styles;
exports.scripts = scripts;
exports.watch = watch;
exports.build = build;
exports.release = release;
exports.img = img;
exports.fonts = fonts;