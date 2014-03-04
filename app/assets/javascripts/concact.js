$(this).ready(function($) {
    $.getScript("http://maps.google.com/maps/api/js?sensor=false&language=en&callback=map_init");
  });
  function map_init(){
    var geocoder;
    var map;
    var address = "天津 凯立天香家园";
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(39.13077,117.1577);
    var myOptions = {
      zoom: 16,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
      var marker = new google.maps.Marker({
      map: map,
      position: map.getCenter()
    });
    var infowindow = new google.maps.InfoWindow();
    infowindow.setContent('<b>HIGHTECH PRINTING INDUSTRIAL</b>');
    google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
    });
 }