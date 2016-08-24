// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-select.min
//= require jquery.validate.min
//= require jquery.mask.min
//= require js.cookie.js

$(document).ready(function () {
  // Plugin: Bootstrap Select
  $('select').selectpicker({
    width: 'auto'
  });

  // Plugin: jQuery Validate
  $('.form-validate').each(function() {
    $(this).validate();
  });

  // Plugin: jQuery Mask
  $('.mask-input').each(function(){
    $(this).mask($(this).data('mask'));
  });

  // Check Cookie - Lat and Long
  var coordinates = Cookies.get('coordinates');
  if (coordinates === undefined) {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setUserCoordinates);
    } else {
        //x.innerHTML = "Geolocation is not supported by this browser.";
    }
  }
});

function setUserCoordinates(position) {
  latitude = position.coords.latitude;
  longitude = position.coords.longitude;
	Cookies.set('coordinates', {'lat': latitude, 'long': longitude});

  if ($('#map-canvas-dir').length > 0) {
    location.reload();
  }
}
