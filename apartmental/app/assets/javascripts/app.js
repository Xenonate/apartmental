$( document ).ready(function() {
  $(".search_form").on("submit", function(){
    $(this).serialize();

  });

  $(".tile").on("click", function(e){
    e.preventDefault();
    var id = $(this).attr("id")
    var search_id = $(this).attr("data")
    console.log(id)
    var myData = {
      "address_id": id,
      "search_id": search_id
    }
    var s="";
    for(var prop in myData){
      if(s.length===0){
        s+=prop+"="+myData[prop]
      }else{
        s+="&"+prop+"="+myData[prop]
      }
    }

    $.ajax({
      url: "/charts",
      method: "GET",
      data: s,
      dataType: 'json'
    })
    .done(function(msg){
      // console.log(msg)
      // console.log(msg)
      console.log([
            parseFloat(msg[0].pindex_price),
            parseFloat(msg[0].pindex_commutescore),
            parseFloat(msg[0].pindex_crimerate),
            parseFloat(msg[0].pindex_walkscore)
          ])
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

      console.log(data.datasets)

      var myRadarChart = new Chart(ctx).Radar(data);
      console.log(myRadarChart)
      $("#myChart").append(myRadarChart)
    })
    .fail(function(error){
      console.log(error.responseText);
    })
});

});
