var events = {
  init_map: function(content, index) {
    google_map = Gmaps["map_" + index];
    if(google_map == undefined) {
      google_map = Gmaps.map;
    }
    google_map.callback = function() {
      map = this.map;
      var infoWindow = new google.maps.InfoWindow();
      infoWindow.setContent(content);
      for (var i = 0; i < this.markers.length; ++i) {
        marker = this.markers[i];
        that = this;
        google.maps.event.addListener(marker, 'click', function() {
          infoWindow.open(that.map.serviceObject, marker.serviceObject);
        });
        google.maps.event.trigger(marker, 'click');
        that.map.serviceObject.panBy(0,-130);
      }
    }
  }
}
