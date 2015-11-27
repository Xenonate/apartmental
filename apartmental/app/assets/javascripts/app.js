$( document ).ready(function() {

  $(".tile").on("click", function(e){
    e.preventDefault();
    $(".title").css('display', 'none')
    $(".image").css('display', 'none')
    $('.description').empty()
    var id = $(this).attr("id")
    var search_id = $(this).attr("data")
    console.log(id)
    var myData = {
      "address_id": id,
      "search_id": search_id
    }
    var info="";
    for(var prop in myData){
      if(info.length===0){
        info+=prop+"="+myData[prop]
      }else{
        info+="&"+prop+"="+myData[prop]
      }
    }

    $.ajax({
      url: "/charts",
      method: "GET",
      data: info,
      dataType: 'json'
    })
    .done(function(msg){
      var ctx = $("#myChart").get(0).getContext("2d");
      var data = {
        labels: ["R", "CT", "CR", "WS"],
        datasets: [
        {
          label: "perfect weight",
          fillColor: "rgba(44,62,80,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "#fff",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: [
          parseFloat(msg[0].price_weight).toFixed(2),
          parseFloat(msg[0].commute_weight).toFixed(2),
          parseFloat(msg[0].crime_weight).toFixed(2),
          parseFloat(msg[0].walkscore_weight).toFixed(2)
          ]
        },
        {
          label: "actual weight",
          fillColor: "rgba(227,111,103,0.6)",
          strokeColor: "rgba(151,187,205,1)",
          pointColor: "#fff",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(151,187,205,1)",
          data: [
          parseFloat(msg[0].pindex_price).toFixed(2),
          parseFloat(msg[0].pindex_commutescore).toFixed(2),
          parseFloat(msg[0].pindex_crimerate).toFixed(2),
          parseFloat(msg[0].pindex_walkscore).toFixed(2)
          ]
        }
        ]
      };

      var myRadarChart = new Chart(ctx).Radar(data,{ pointDot: false, pointLabelFontSize: 18});
      console.log(myRadarChart)
      $("#myChart").append(myRadarChart)
    })
    .fail(function(error){
      console.log(error.responseText);
    });

    $.ajax({
      url: "/charts/new",
      method: "GET",
      data: info,
      dataType: 'json'
    })
    .done(function(msg){

      $("#title"+id).css('display', 'inline')
      $("#image"+id).css('display', 'inline')
      $("#description"+id).append(msg.description)
    })
    .fail(function(error){
      console.log(error.responseText);
    });

});

   $(".tile").mouseover(function(){
    console.log($(this).attr('id'))
    var image = ".tile-image" + $(this).attr('id')
    var score = ".tile-score" + $(this).attr('id')
    $(image).css("opacity", "100")
    $(score).hide()
   }).mouseout(function(){
    console.log($(this).attr('id'))
    var image = ".tile-image" + $(this).attr('id')
    var score = ".tile-score" + $(this).attr('id')
    $(image).css("opacity", "0.1")
    $(score).show()
   })

});
