$(document).on('ready', function(){
  $('#options').hide()
  $('#options-button').on('click', function(e){
    e.preventDefault();
    $('#options').toggle()
  })
  // console.log('Derek said to console log something right here')
  // console.log(document.querySelector('.options-open'))

})
