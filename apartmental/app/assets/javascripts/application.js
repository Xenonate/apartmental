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
//= require foundation
//= require turbolinks
//= require mapbox
//= require foundation
//= require_tree .

 // $(function() {
 //   $( "#slider" ).slider({
 //     min: 400,
 //     max: 2400,
 //     value: 1500,
 //     animate: "slow",
 //     orientation: "horizontal",
 //     slide: function(event, ui) {
 //       $("#price").val(ui.value);
 //     }
 //   });
 // });

$(document).foundation();
$(document).on('ready', function(){
  $('#options').hide()
  $('#options-button').on('click', function(e){
    e.preventDefault();
    $('#options').toggle()
  })
  // console.log('Derek said to console log something right here')
  // console.log(document.querySelector('.options-open'))

})
