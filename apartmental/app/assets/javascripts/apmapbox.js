$(document).ready(function() {
  if ($("#map").length > 0) {
    L.mapbox.accessToken = 'pk.eyJ1IjoicmljZWI1MyIsImEiOiJjaWg2aHRxcXAwYzYxdWpseHUwemloZ3gyIn0.wmQAtxnSiqgcwz1-66cypQ';
    var map = L.mapbox.map('map', 'mapbox.streets')
    .setView([37.7570841,-122.45], 12);
    var myLayer = L.mapbox.featureLayer().addTo(map);
    var geoJson = []
    var searchId = $("#map").attr("name")
    var myData = {
      "search_id": searchId
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
      url: "/mapboxplayground",
      method: "GET",
      dataType: 'json',
      data: info
    })
    .done(function(msg){
      console.log(typeof msg[0][0][0] === 'number')

      for (var i = 0; i < msg.length; i++){
        geoJson.push({
          type: 'Feature',
          "geometry": { "type": "Point", "coordinates": [ msg[i][0][0], msg[i][0][1] ] },
          "properties": {
            "icon": {
              "className": "dot",
              "iconSize": [600,100]
            },
            "marker-symbol": "",
            "marker-color": "#ff8888",
            "marker-size": "medium",
          }
        });
      }
      myLayer.setGeoJSON(geoJson);
    })
    .fail(function(error){
      console.log(error.responseText);
    })


    // Add features to the map
    $(".tile").click(function() {
      var index = $(".tile").index(this)
      console.log("Row Index: " + index)
      var long_lat = (geoJson[index].geometry.coordinates)
      console.log("Marker LatLong: " + long_lat)
      // map.panTo(long_lat, 5)
      map.setView(long_lat.reverse(), 14)
      long_lat.reverse()
    });
    // Hovering mapbox marker hilights appropriate row on results table
    $(".leaflet-marker-icon").mouseover(function(){
      var index = $(".leaflet-marker-icon").index(this)
      console.log("Marker Inex: " +  index)
      $(".tile:eq(" + (index + 1) + ")").css({ "background-color": "#2A363B", "color": "#E84A5F" })
    }).mouseout(function() {
      var index = $(".leaflet-marker-icon").index(this)
      $(".tile:eq(" + (index + 1) + ")").css({ "background-color": "", "color": "" })
    });
    // Hovering on results row hilights mapbox marker
    $(".tile").mouseover(function(){
      var index = $(".tile").index(this)
      // console.log(geoJson[index]["properties"]["marker-symbol"])
      // $(".leaflet-marker-icon:eq(" + index + ")").css("z-index", 500)
      // console.log(poo)
      geoJson[index].properties["marker-symbol"] = "heart"
      geoJson[index].properties["marker-size"] = "large"
      myLayer.setGeoJSON(geoJson);
    }).mouseout(function() {
      var index = $(".tile").index(this)
      geoJson[index].properties["marker-symbol"] = ""
      geoJson[index].properties["marker-size"] = "medium"
      myLayer.setGeoJSON(geoJson);
    });

  };

})
