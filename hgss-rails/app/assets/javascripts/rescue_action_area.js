$(function() {
    const currentController = getCurrentController();
    const currentAction = getCurrentAction();

    if (currentController == "rescue_action_areas") {
        loadRectangleMap();

        $("form").submit(function(e) {
            $("#rescue_action_area_points").text(JSON.stringify(getCoordinates()));
            $("#rescue_action_area_latitude").val(map.center.lat());
            $("#rescue_action_area_longitude").val(map.center.lng());
            $("#rescue_action_area_zoom_level").val(map.zoom);
        })
    }
});

var all_overlays = [];
var map;

function getCoordinates() {
    return all_overlays[0].getPath().getArray().map(function name(coord) {
        return {lat: coord.lat(), lng: coord.lng()};
    });
}

function loadRectangleMap() {
    var drawingManager;
    var selectedShape;

    function setSelection(shape) {
        clearSelection();
        selectedShape = shape;
        shape.setEditable(true);
    }

    function clearSelection() {
        if (selectedShape) {
            selectedShape.setEditable(false);
            selectedShape = null;
        }
    }

    function initialize() {
        var zoomInputValue = $("#rescue_action_area_zoom_level").val();
        var mapZoom = parseFloat(zoomInputValue);
        if (zoomInputValue.length == 0) {
            mapZoom = 16.0;
        }

        var latitudeInputValue = $("#rescue_action_area_latitude").val();
        var latitude = parseFloat(latitudeInputValue);
        if (latitudeInputValue.length == 0) {
            latitude = 45.793636;
        }

        var longitudeInputValue = $("#rescue_action_area_longitude").val();
        var longitude = parseFloat(longitudeInputValue);
        if (longitudeInputValue.length == 0) {
            longitude = 15.970199;
        }

        console.log(mapZoom, latitude, longitude);

        map = new google.maps.Map(document.getElementById('poly-map-component'), {
            zoom: mapZoom,
            center: new google.maps.LatLng(latitude, longitude),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true,
            zoomControl: true
        });

        const pointsText = $("#rescue_action_area_points").text();
        if (pointsText.length != 0) {
            const coordinates = JSON.parse(pointsText);
    
            var newPolygon = new google.maps.Polygon({
                paths: coordinates,
                fillColor: '#1581C4',
                fillOpacity: 0.7,
                strokeColor: '#AA2543',
                strokeWeight: 2,
                editable: true,
                draggable: true
            });
            newPolygon.setMap(map);
            all_overlays.push(newPolygon);
        }


    	var input = document.getElementById('map_search');
    	var autocomplete = new google.maps.places.Autocomplete(input);
    	google.maps.event.addListener(autocomplete, "place_changed", function() {
    	    var place = autocomplete.getPlace();
	
    	    map.panTo(place.geometry.location);
    	    map.setZoom(16);
    	});

        var polyOptions = {
            fillColor: '#1581C4',
            fillOpacity: 0.7,
            strokeColor: '#AA2543',
            strokeWeight: 2,
            editable: true,
            draggable: true
        };
        // Creates a drawing manager attached to the map that allows the user to draw Polygons
        drawingManager = new google.maps.drawing.DrawingManager({
            drawingControlOptions: {
                drawingModes: [
                    google.maps.drawing.OverlayType.POLYGON
                ]
            },
            polygonOptions: polyOptions,
            map: map
        });

        google.maps.event.addListener(drawingManager, 'overlaycomplete', function(e) {
            calcIntersection(e.overlay, all_overlays);
            all_overlays.push(e.overlay);
        });

    }

    function calcIntersection(newOverlay, allOverlays) {
        //ensure the polygon contains enought vertices 
        if (newOverlay.getPath().getLength() < 3) {
            alert("Not enought vertices. Draw a polygon that contains at least  3 vertices.");
            return;
        }

        var geometryFactory = new jsts.geom.GeometryFactory();
        var newPolygon = createJstsPolygon(geometryFactory, newOverlay);

        //iterate existing polygons and find if a new polygon intersects any of them
        var result = allOverlays.filter(function(currentOverlay) {
            var curPolygon = createJstsPolygon(geometryFactory, currentOverlay);
            var intersection = newPolygon.intersection(curPolygon);
            return intersection.isEmpty() == false;
        });

        //if new polygon intersects any of exiting ones, draw it with green color
        if (result.length > 0) {
            newOverlay.setOptions({ strokeWeight: 2.0, fillColor: 'green' });
        }
    }



    function createJstsPolygon(geometryFactory, overlay) {
        var path = overlay.getPath();
        var coordinates = path.getArray().map(function name(coord) {
            return new jsts.geom.Coordinate(coord.lat(), coord.lng());
        });
        coordinates.push(coordinates[0]);
        var shell = geometryFactory.createLinearRing(coordinates);
        return geometryFactory.createPolygon(shell);
    }


    google.maps.event.addDomListener(window, 'load', initialize);
}
