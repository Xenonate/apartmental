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
//= require chart_configuration
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require homepage
//= require app
//= require apmapbox
//= require mapbox
//= require foundation
//= require bootstrap-sprockets
//= require_tree .

$(document).foundation();

$(document).on('ready', function(){
  $('.research').on('click', function(){
    $("#search-again").toggle()
  })
  $('.tile').on('click', function(){
    console.log('hello')
    $('#left_column').flip();
    $('.front').hide()
    $('#left_column').on('flip:done', function(){
      $('.front').show()
    })
  })
})

  // console.log('Derek said to console log something right here')
  // console.log(document.querySelector('.options-open'))
