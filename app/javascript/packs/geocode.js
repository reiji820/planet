function geocodeAddress(geocoder, map) {
    var address = document.getElementById('address').value; // 住所フィールドの値を取得
    geocoder.geocode({'address': address}, function(results, status) {
        if (status === 'OK') {
            // Geocodingが成功した場合、緯度と経度を取得
            var latitude = results[0].geometry.location.lat();
            var longitude = results[0].geometry.location.lng();

            // 緯度と経度をフォームの隠しフィールドにセット
            document.getElementById('latitude').value = latitude;
            document.getElementById('longitude').value = longitude;
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

document.addEventListener("DOMContentLoaded", function() {
    var geocoder = new google.maps.Geocoder();

    document.getElementById('address').addEventListener('change', function() {
        geocodeAddress(geocoder, null);
    });
});