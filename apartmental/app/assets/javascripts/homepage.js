$(document).on('ready', function(){
  // console.log('Derek said to console log something right here')
  // console.log(document.querySelector('.options-open'))

  // This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

$(".range-slider-handle:eq(1)").mousemove(function() {
  $(".max-price-js").val($(".range-slider-handle:eq(1)").attr("aria-valuenow"))
});

$(".range-slider-handle:eq(0)").mousemove(function() {
  $(".min-price-js").val($(".range-slider-handle:eq(0)").attr("aria-valuenow"))
});


})
