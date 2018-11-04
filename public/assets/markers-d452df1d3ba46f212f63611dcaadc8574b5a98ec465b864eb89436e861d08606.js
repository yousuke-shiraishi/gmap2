
function initMap() {
  var addresses = window.addresses;
  var markers = [];
  var m = void 0;
  var map = void 0;
  var largeInfowindow = [];
  var marker = void 0;
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
    largeInfowindow[i] = new google.maps.InfoWindow({
      content: addresses[i].coment
    });

    m = marker;
    markerEvent(i, largeInfowindow, m, addresses[i], map);

    markers.push(m);
    bounds.extend(markers[i].position);
  }

  map.fitBounds(bounds);
  markers;
}
function rebuildcomment(str, length) {
  var resultArr = [];
  if (!str || !length || length < 1) {
    return resultArr;
  }
  var index = 0;
  var start = index;
  var end = start + length;
  while (start < str.length) {
    resultArr[index] = str.substring(start, end);
    index++;
    start = end;
    end = start + length;
  }
  resultArr = resultArr.join('<br>');
  return resultArr;
}

function markerEvent(i, largeInfowindow, marker, address, map) {

  marker.addListener('click', function () {
    // マーカーをクリックしたと
    if (largeInfowindow[i].marker != marker) {
      largeInfowindow[i].marker = marker;
      largeInfowindow[i].content = rebuildcomment(largeInfowindow[i].content, 30);
      largeInfowindow[i].setContent('<a href="' + address.image["url"] + '"target = "_blank" data-lightbox = "image-'
       + largeInfowindow[i].marker.id + '"><img class = "picture" src =' + address.image["url"] + ' alt = "" width = "150px" height = "auto"/></a>'
       + '<div><p>' + largeInfowindow[i].marker.title + '</p></div>' + '<div><p>' + largeInfowindow[i].content +
      '</p></div>' + '<div><input type = "button" value = "マーカーを削除する" id = "btn' + largeInfowindow[i].marker.id + '"/></div>');
      largeInfowindow[i].open(map, marker); // 吹き出しの表示

      // var target = document.getElementById('btn' + largeInfowindow[i].marker.id + '');
      target = `#btn${largeInfowindow[i].marker.id}`;
      $(document).on("click", target, function (){
      // target.addEventListener('click', function (e) {
        if (!!confirm('本当に削除しますか?削除すると戻せません。')) {
          var CSRF_TOKEN = $('meta[name = "csrf-token"]').attr('content');
          $.ajax({
            url: '/gmaps/destroy/?q=' + largeInfowindow[i].marker.id,
            type: 'DELETE',
            data: {
              _token: CSRF_TOKEN
            },
            processData: false,
            contentType: false,
            dataType: 'json'
          }).then(function (data) {
            alert('削除に成功しました。');
            marker.setMap(null);
            marker = null;
          }, function () {
            alert('他の人のマーカー情報は消せません。');
          });
        }
      });
    }
  });
  }
;
