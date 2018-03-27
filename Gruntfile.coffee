module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'
    name: 'simditor-video'

    sass:
      styles:
        options:
          style: 'expanded'
          bundleExec: true
          sourcemap: 'none'
        files:
          'styles/simditor-video.css': 'styles/simditor-video.scss'
    coffee:
      src:
        options:
          bare: true
        files:
          'lib/simditor-video.js': 'src/simditor-video.coffee'

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['sass', 'coffee']
