// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require tether
//= require bootstrap-sprockets
//= require jquery_ujs
//= require select2/select2.full
//= require jquery-locationpicker-plugin/locationpicker.jquery
//= require jquery.autocomplete
//= require noty
//= require jsts
//= require_tree .

function getCurrentController() {
    return $("body").data("controller");
}

function getCurrentAction() {
    return $("body").data("action");
}


$(function() {
	function search() {
        const searchValue = $("#search_input").val();

        const newLocationOriginPathName = window.location.origin + window.location.pathname;
        const newLocationSearch = `?search=${searchValue}`;
        const newLocation = newLocationOriginPathName + newLocationSearch;

        window.location = newLocation;
    }

    function navigateToPoint(id) {
        window.location = `/points/${id}`;
    }

    $('button[data-href]').click(function() {
        window.location = $(this).data("href");
    });

    $("#search_input").devbridgeAutocomplete({
        serviceUrl: '/api/autocomplete/model/test/query',
        minChars: 3,
        autoSelectFirst: false,
        triggerSelectOnValidInput: false,
        onSelect: function(suggestion) {
            search();
        }
    });

    $("#search_form").on("submit", function(e) {
        e.preventDefault();
        search();
    });

    $("#search_button").click(function() {
        search();
    });

    $('select').select2({
        theme: "bootstrap",
        tags: true
    });

    function zoomMapToCloseLevel() {
        const mapElement = $('.map-component')[0];
        const map = window.locationPicker.data("locationpicker").map;

        map.setZoom(15);
    }

    $('.map-component').each(function() {
        const $element = $(this);

        var latitude, longitude;

        const latitudeInput = $($element.data("latitude-input"));
        const longitudeInput = $($element.data("longitude-input"));
        const locationNameInput = $($element.data("location-name-input"));

        locationNameInput.keypress(function(event) {
            if (event.keyCode == 13) {
                event.preventDefault();
            }
        });

        const latitudeInputValue = latitudeInput.val();
        const longitudeInputValue = longitudeInput.val();

        if (latitudeInputValue.length != 0) {
            latitude = latitudeInputValue;
        } else {
            latitude = 45.793636;
        }

        if (longitudeInputValue.length != 0) {
            longitude = longitudeInputValue;
        } else {
            longitude = 15.970199;
        }

        const locationPicker = $element.locationpicker({
            // Bind inputs given from element data.
            inputBinding: {
                latitudeInput: latitudeInput,
                longitudeInput: longitudeInput,
                locationNameInput: locationNameInput
            },
            radius: 0, // Disable radius, only select coordinates.
            enableAutocomplete: true, // Enable autocomplete search in location name input.
            location: {
                latitude: latitude,
                longitude: longitude
            },
            onchanged: function(currentLocation, radius, isMarkerDropped) {
            	if (!isMarkerDropped)
                	zoomMapToCloseLevel();
            }
        });

        window.locationPicker = locationPicker;
    });

    $('.nav-tabs a').click(function (e) {
        e.preventDefault()
        $(this).tab('show');
        $('.map-component').each(function() {
            const mapElement = $(this);
            const $mapElement = $(mapElement);
            const map = window.locationPicker.data("locationpicker").map;

            const latitudeInput = $($mapElement.data("latitude-input"));
            const longitudeInput = $($mapElement.data("longitude-input"));

            const latitudeInputValue = latitudeInput.val();
            const longitudeInputValue = longitudeInput.val();

            if (latitudeInputValue.length != 0) {
                latitude = latitudeInputValue;
                zoom = 16;
            } else {
                latitude = 45.793636;
                zoom = 8;
            }

            if (longitudeInputValue.length != 0) {
                longitude = longitudeInputValue;
            } else {
                longitude = 15.970199;
            }

            var center = new google.maps.LatLng(latitude, longitude);
            map.panTo(center);
            map.setZoom(zoom);
            google.maps.event.trigger(map, 'resize');
        });
    });

    $(window).ready(function() {
        const formElement = $(".new_rescue_action,.edit_rescue_action");
        if (formElement.offset() != undefined) {
            const topOffset = formElement.offset().top;
            formElement.height($(window).height() - topOffset);

            const mapElement = $('.map-component')[0];
            const $mapElement = $($('.map-component')[0]);
            const map = window.locationPicker.data("locationpicker").map;

            google.maps.event.trigger(mapElement, 'resize');

            var latitude, longitude, zoom;
            
            const latitudeInput = $($mapElement.data("latitude-input"));
            const longitudeInput = $($mapElement.data("longitude-input"));

            const latitudeInputValue = latitudeInput.val();
            const longitudeInputValue = longitudeInput.val();

            if (latitudeInputValue.length != 0) {
                latitude = latitudeInputValue;
                zoom = 16;
            } else {
                latitude = 45.793636;
                zoom = 8;
            }

            if (longitudeInputValue.length != 0) {
                longitude = longitudeInputValue;
            } else {
                longitude = 15.970199;
            }

            var center = new google.maps.LatLng(latitude, longitude);
            map.panTo(center);
            map.setZoom(zoom);

            window.locationPicker.data("locationpicker");
        }

        $(window).resize(function() {
            const formElement = $(".new_rescue_action,.edit_rescue_action");
            if (formElement.offset() != undefined) {
                const topOffset = formElement.offset().top;
                formElement.height($(window).height() - topOffset);

                const mapElement = $('.map-component')[0];
                const $mapElement = $($('.map-component')[0]);
                const map = window.locationPicker.data("locationpicker").map;

                google.maps.event.trigger(mapElement, 'resize');

                const latitudeInput = $($mapElement.data("latitude-input"));
                const longitudeInput = $($mapElement.data("longitude-input"));

                const latitude = latitudeInput.val();
                const longitude = longitudeInput.val();

                var center = new google.maps.LatLng(latitude, longitude);
                // using global variable:
                map.panTo(center);
                window.locationPicker.data("locationpicker");
            }
        });
    });
});