$(function() {
  $('#location').autoGeocoder();
  $('#location').keypress(function(event) {
   if (event.which == 13) {
     return false;
   }
  });
});
(function($) {
  var geocoder = new google.maps.Geocoder();

  $.fn.autoGeocoder = function(options) {
    options = $.extend(true, {}, $.fn.autoGeocoder.defaults, options || {});
		options.success.zoom = 13
		options.className = "grid_12 alpha";
		options.idName = "map";
    return this.setupExtras(options.setup || $.fn.autoGeocoder.base, options)
               .trigger('auto-geocoder.initialize');
  };

  $.fn.autoGeocoder.base = {
    initialize: [function(options) {
      options.initial.center = new google.maps.LatLng(
        options.initial.center[0],
        options.initial.center[1]
      );

      this.bind('auto-geocoder.initialize', function() {
        $(this)
          .trigger('auto-geocoder.createMap')
          .trigger('auto-geocoder.onKeyUp');
      });
    }],

    createMap: [function(options) {
      this.bind('auto-geocoder.createMap', function() {
        var element = $('<div id="' + options.idName + '" class="' + options.className + '" />');

        if (options.position == 'before' || options.position == 'after') {
          $(this)[options.position](element);
        } else {
          $(options.position).append(element);
        }

        $(this).bind('keyup.auto-geocoder', function() {
          $(this).trigger('auto-geocoder.onKeyUp');
        });

        this.map = new google.maps.Map(element[0], options.initial);
      });
    }],

    onKeyUp: [function(options) {
      this.bind('auto-geocoder.onKeyUp', function() {
        var self    = this;
        var element = $(this);
        var address = $.trim(element.val()).replace(/\s+/g, ' ').toLowerCase();

        if (this.timeout) {
          clearTimeout(this.timeout);
        }

        if (this.previousAddress &&
            this.previousAddress == address) {
            return;
        }

        if (address == '') {
          element.trigger('auto-geocoder.onGeocodeResult', [[], '']);

          return;
        }

        this.timeout = setTimeout(function() {
          self.previousAddress = address;

          geocoder.geocode({ address: address }, function(results, status) {
            element.trigger('auto-geocoder.onGeocodeResult', [results, status]);
          });
        }, options.delay);
      });
    }],

    onGeocodeResult: [function(options) {
      this.bind('auto-geocoder.onGeocodeResult', function(e, results, status) {
        if (status == google.maps.GeocoderStatus.OK &&
            status != google.maps.GeocoderStatus.ZERO_RESULTS) {
          if (options.success.zoom == 'auto') {
            this.map.fitBounds(results[0].geometry.viewport);
          } else {
            this.map.setZoom(options.success.zoom);
            this.map.setCenter(results[0].geometry.location);
          }

          this.marker = this.marker || new google.maps.Marker();
          this.marker.setPosition(results[0].geometry.location);

					//Set the hidden form fields with the lat and long
					$("#latitude").val(results[0].geometry.location.lat())
					$("#longitude").val(results[0].geometry.location.lng())
          this.marker.setMap(this.map);

					//Reverse geo-code it for storage
					var latlng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
			    geocoder.geocode({'latLng': latlng}, function(results, status) {
			      if (status == google.maps.GeocoderStatus.OK) {
			        if (results[0]) {
			          $("#listing_reverse_geocode").attr("value", results[0].formatted_address);
				        $("#user_reverse_geocode").attr("value", results[0].formatted_address);
			        }
			      }
					});

          $(this).trigger('auto-geocoder.onGeocodeSuccess', [results, status]);
        } else {
          if (this.marker) {
            this.marker.setMap(null);
            delete this.marker;
          }

          this.map.setZoom(options.initial.zoom);
          this.map.setCenter(options.initial.center);

          $(this).trigger('auto-geocoder.onGeocodeFailure', [results, status]);
        }
      });
    }],

    onGeocodeSuccess: [],
    onGeocodeFailure: []
  };

  $.fn.autoGeocoder.defaults = {
    className : 'jquery-auto-geocoder-map',
    position  : 'after',
    delay     : 500,
    success   : {
      zoom : 'auto'
    },
    initial  : {
      zoom           : 1,
      center         : [34, 0],
      draggable      : false,
      mapTypeId      : google.maps.MapTypeId.ROADMAP,
      mapTypeControl : false
    }
  };

  // From:
  // http://yehudakatz.com/2009/04/20/evented-programming-with-jquery/
  $.fn.setupExtras = $.fn.setupExtras || function(setup, options) {
    for (property in setup) {
      if (setup[property] instanceof Array) {
        var length = setup[property].length;

        for (var i = 0; i < length; i++) {
          setup[property][i].call(this, options);
        }
      } else {
        setup[property].call(this, options);
      }
    }

    return this;
  };
})(jQuery);