function initMap() {

  let markers = [];
  let m;
  let map;
  let largeInfowindow = [];
  let marker;
  map = new google.maps.Map(document.getElementById('gmaps'), {
    zoom: 4
  });
  let bounds = new google.maps.LatLngBounds();

  let n = addresses.length;
  for (let i = 0; i < n; i++) {

    marker = new google.maps.Marker({
      position: {
        lat: parseFloat(addresses[i].latitude),
        lng: parseFloat(addresses[i].longitude)
      },
      map: map,
      title: addresses[i].title,
      id: addresses[i].id
    });
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
      largeInfowindow[i].setContent('<a href="'+address.image["url"]+'"target = "_blank" data-lightbox = "image-' + largeInfowindow[i].marker.id + '"> <img class = "picture" src =' + address.image["url"] + ' alt = "" width = "150px" height = "auto"/></a>' + '<div><p>' + largeInfowindow[i].marker.title + '</p></div>' +
      '<div><p>' + largeInfowindow[i].content + '</p></div>' + '<div><input type = "button" value = "マーカーを削除する" id = "btn'+ largeInfowindow[i].marker.id +'"/></div>');
      largeInfowindow[i].open(map, marker); // 吹き出しの表示
      const target = document.getElementById('btn' + largeInfowindow[i].marker.id + '');
      target.addEventListener('click',function(e){
      if (!!confirm('本当に削除しますか?削除すると戻せません。')) {
          let CSRF_TOKEN = $('meta[name = "csrf-token"]').attr('content');
          $.ajax({
            url: '/gmaps/destroy/?q=' +largeInfowindow[i].marker.id,
            type: 'DELETE',
            data:
            {
            _token: CSRF_TOKEN
            },
            processData: false,
            contentType: false,
            dataType: 'json'
          }).then(
            function(data) {
              alert('削除に成功しました。');
              marker.setMap(null);
              marker = null;
            },
            function() {
              alert('他の人のマーカー情報は消せません。');
            });
         }
       });
    }
  });


}
