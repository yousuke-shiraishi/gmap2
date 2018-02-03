function toggle(className, obj) {
    var $input = $(obj);
    if ($input.prop('checked')) {$(className).hide();
      document.getElementById('magic_word').value = null;
    }else{$(className).show();}
}
