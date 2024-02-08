window.initGeocoder = function() {
    // 'address'要素が存在することを確認
    var addressInput = document.getElementById('address');
    if (addressInput) {
        var geocoder = new google.maps.Geocoder();
        addressInput.addEventListener('change', function() {
            geocodeAddress(geocoder, null);
        });
    } else {
        console.log("'address' element is not present on this page.");
    }
}

function geocodeAddress(geocoder, map) {
    var address = document.getElementById('address').value;
    geocoder.geocode({'address': address}, function(results, status) {
        if (status === 'OK') {
            var latitude = results[0].geometry.location.lat();
            var longitude = results[0].geometry.location.lng();

            document.getElementById('latitude').value = latitude;
            document.getElementById('longitude').value = longitude;
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}