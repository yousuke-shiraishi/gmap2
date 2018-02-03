function giomap() {

  if (navigator.geolocation) {
    // 現在地を取得
    navigator.geolocation.getCurrentPosition(

      // [第1引数] 取得に成功した場合の関数
      function(position) {
        // 取得したデータの整理
        var data = position.coords;


        // HTMLへの書き出し
        document.getElementById('gmap_latitude').value = data.latitude;
        document.getElementById('gmap_longitude').value = data.longitude;

      });
  }

  // 対応していない場合
  else {
    // エラーメッセージ
    var errorMessage = "お使いの端末は、GeoLacation APIに対応していません。";

    // アラート表示
    alert(errorMessage);

  }
}
