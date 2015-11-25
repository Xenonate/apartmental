$(document).ready(function() {
  $(".leaflet-control-attribution").css("display","none")
  
  if ($("#left_up").length > 0) {
    var searchId = $("#left_up").data("search")
    var addressId = $("#left_up").data("address")
    var myData = {
      "address_id": addressId,
      "search_id": searchId,
      "first_load": "true"
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
      dataType: 'json',
      data: info
    })
    .done(function(msg){
      console.log(msg)
      var ctx = $("#myChart").get(0).getContext("2d");
      var data = {
        labels: ["Rent", "Commute Time", "Crime Rate", "Walkscore"],
        datasets: [
        {
          label: "perfect weight",
          fillColor: "rgba(220,220,220,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "rgba(220,220,220,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: [
            parseFloat(msg[0].price_weight),
            parseFloat(msg[0].commute_weight),
            parseFloat(msg[0].crime_weight),
            parseFloat(msg[0].walkscore_weight)
          ]
        },
        {
          label: "actual weight",
          fillColor: "rgba(151,187,205,0.2)",
          strokeColor: "rgba(151,187,205,1)",
          pointColor: "rgba(151,187,205,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(151,187,205,1)",
          data: [
            parseFloat(msg[0].pindex_price),
            parseFloat(msg[0].pindex_commutescore),
            parseFloat(msg[0].pindex_crimerate),
            parseFloat(msg[0].pindex_walkscore)
          ]
        }
        ]
      };

      var myRadarChart = new Chart(ctx).Radar(data);
      console.log(myRadarChart)
      $("#myChart").append(myRadarChart)
    })
    .fail(function(error){
      console.log(error.responseText);
    })
  }

});
