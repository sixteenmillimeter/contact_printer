'use strict';

const gulp = require('gulp');
const concat = require('gulp-concat');
const minify = require('gulp-minify');
const files = [
	'./index.js'
];
const targetDir = './dist/';
const targetFile = 'app.js';
const minified = 'app.min.js';

gulp.task('default', () => {});

gulp.task('scripts', () => {
  return gulp.src(files)
    .pipe(concat(targetFile))
    .pipe(gulp.dest(targetDir));
});

gulp.task('compress', ['scripts'], () => {
	gulp.src(targetDir + targetFile)
		.pipe(minify())
		.pipe(gulp.dest(targetDir));
});

gulp.task('default', ['scripts']);