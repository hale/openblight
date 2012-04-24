OpenBlight = {
  common: {
    init: function() {
      // application-wide code
    }
  },
  
  
  addresses: {
    init: function(){
      console.log("using addresses:init");
    },
   	search: function(){
      console.log("using addresses:search");
      wax.tilejson('http://a.tiles.mapbox.com/v3/cfaneworleans.NewOrleansPostGIS.jsonp',
        function(tilejson) {
          
          // this shoud be moved into a function
          json_path = window.location.toString().replace(/search\?/i, 'search.json\?');
          
          jQuery.getJSON( json_path, function(data) {
              var map = new L.Map('map').addLayer(new wax.leaf.connector(tilejson));
              for ( i = 0; i < data.length; i++ ){
                var point = data[i].point.substring(7, data[i].point.length -1).split(' ');
                map.addLayer(new L.Marker(new L.LatLng(point[1] , point[0])) );
                var y = point[1];
                var x= point[0];                
              }
              // we center the map on the last position
              map.setView(new L.LatLng(y, x), 14);
              

          });
            

            
      });
    },
    show: function(){
      console.log("using addresses:show");
      wax.tilejson('http://a.tiles.mapbox.com/v3/cfaneworleans.NewOrleansPostGIS.jsonp',
        function(tilejson) {

          // this should not be hard coded. do json request?
        var x = $("#address").attr("data-x");
        var y = $("#address").attr("data-y");
        
        var map = new L.Map('map')
          .addLayer(new wax.leaf.connector(tilejson))
          .addLayer(new L.Marker(new L.LatLng(y , x)) )
          .setView(new L.LatLng(y , x), 18);
      });
    }
  }
};

UTIL = {
  exec: function( controller, action ) {
    var ns = OpenBlight,
        action = ( action === undefined ) ? "init" : action;

    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {ns[controller][action]();}
  },

  init: function() {
    var body = document.body,
        controller = body.getAttribute( "data-controller" ),
        action = body.getAttribute( "data-action" );

    UTIL.exec( "common" );
    UTIL.exec( controller );
    UTIL.exec( controller, action );
  }
};
 
$( document ).ready( UTIL.init );
