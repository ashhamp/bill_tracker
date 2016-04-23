// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .
//= blur
//= require jquery-ui/datepicker

$(function(){ $(document).foundation();

    $("#sign-up-hover").hover( function() {
      // highlight the mouseover target
      $(this).css("-webkit-filter", "blur(0px)");
    }, function() {
      $(this).css("-webkit-filter", "blur(6px)");
    });
    $("#logo").hover( function() {
      // highlight the mouseover target
      $(".circle-header").css("-webkit-filter", "blur(0px)");
    }, function() {
      $(".circle-header").css("-webkit-filter", "blur(15px)");
    });

    $('#sign-up-hover').click(function(){
      $('#signup-form').foundation('open');
    });
 });
