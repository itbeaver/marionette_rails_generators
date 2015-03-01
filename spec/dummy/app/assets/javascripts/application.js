// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require jquery.spin
//= require underscore
//= require backbone
//= require backbone.marionette
//= require backbone-syphon

//= require ./backbone/before_backbone
//= require ./backbone/app
//= require_tree ./backbone/base
//= require_tree ./backbone/config
//= require_tree ./backbone/app/templates
//= require_tree ./backbone/app/views
//= require_tree ./backbone/app/models
//= require_tree ./backbone/app/controllers
//= require ./backbone/routes
//= require ./backbone/after_backbone

//= require_tree .
