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
      var map = new L.Map("map", {
          center: new L.LatLng(29.95464, -90.07507),
          zoom: 12
      });
      map.addLayer(layer);
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
