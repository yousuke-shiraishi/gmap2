function initMap() {

  var markers = [];
  var m;
  var map;
  var largeInfowindow = [];
  var marker;
  map = new google.maps.Map(document.getElementById('gmaps'), {
    zoom: 4
  });
  var bounds = new google.maps.LatLngBounds();

  var n = addresses.length;
  for (var i = 0; i < n; i++) {

    marker = new google.maps.Marker({
      position: {
        lat: parseFloat(addresses[i].latitude),
        lng: parseFloat(addresses[i].longitude)
      },
      map: map,
      title: addresses[i].title,
      id: addresses[i].id
    });
    //    marker.image = addresses[i].image;
    largeInfowindow[i] = new google.maps.InfoWindow({
      content: addresses[i].coment
    });

    m = marker;
    markerEvent(i, largeInfowindow, m, addresses[i],map);

    markers.push(m);
    bounds.extend(markers[i].position);
  }

  map.fitBounds(bounds);
  markers;
}


function markerEvent(i, largeInfowindow, marker, address,map) {
  marker.addListener('click', function() { // マーカーをクリックしたと
    if (largeInfowindow[i].marker != marker) {
      largeInfowindow[i].marker = marker;
      largeInfowindow[i].setContent('<img class="picture" src=' + address.image["url"] + ' width="300px" height="300px" alt=""/>' + '<div><p>' + marker.title + '</p></div>' + '<div><p>' + largeInfowindow[i].content + '</p></div>');
      largeInfowindow[i].open(map, marker); // 吹き出しの表示
      largeInfowindow[i].addListener('closeclick', function() {
        if (!!confirm('本当に削除しますか?削除すると戻せません。')) {
          $.ajax({
            url: '/gmaps/destroy_images/?q=' + marker.id,
            type: 'POST',
            data: //{
            {
              marker: marker.id
            },
            //_method: 'DELETE'
            processData: false, //おまじない
            contentType: false, //おまじない
            dataType: 'json' //データ形式を指定
            //  },datatype: "html"
          }).then(
            function(data) {
              alert('削除に成功しました。');
              marker.setMap(null);
              // marker = null;
            //  initMap();
            },
            function() {
              alert('他の人のマーカー情報は消せません。');
            });

          // initMap();
        }
        //  google.maps.event.trigger(map, "closeclick");
        //marker.setMap(null);
        //marker = null;
        //initMap();
      });
    }
  });


}
