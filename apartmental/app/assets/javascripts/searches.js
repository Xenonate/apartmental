$(document).ready(function() {
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
        labels: ["R", "CT", "CR", "WS"],
        datasets: [
        {
          label: "perfect weight",
          fillColor: "rgba(44,62,80,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "rgba(220,220,220,1)",
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
          pointColor: "rgba(151,187,205,1)",
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
    })
  }

});
