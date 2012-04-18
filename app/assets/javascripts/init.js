OpenBlight = {
  common: {
    init: function() {
      // application-wide code
    }
  },
  
  
  addresses: {
    init: function(){
      console.log("using addresses");
    },
    show: function(){
      var layer = new L.StamenTileLayer("watercolor");
      var x = $("#address").attr("data-x");
      var y = $("#address").attr("data-y");
      var map = new L.Map("map", {
          center: new L.LatLng(y, x),
          zoom: 12
      });
      map.addLayer(layer);
      var addr = new L.LatLng(y, x);
      map.addLayer(new L.Marker(addr));
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
