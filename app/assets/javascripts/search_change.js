

$(function (){
flag=true;
  $(".radio  input[type=radio]").change(function() {
    // //値が変更されたとき
     flag=!flag;
    if (flag===true){
      $("#form1").show();
      $("#form2").hide();

   }else{
     $("#form2").show();
     $("#form1").hide();
   }
  });
});
