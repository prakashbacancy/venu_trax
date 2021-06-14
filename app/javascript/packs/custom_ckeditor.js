window.custom_ckeditor = function(ckeditor_textbox_id){
  CKEDITOR.plugins.addExternal('confighelper','/ckeditor/plugins/confighelper/');

  // CKEDITOR.plugins.addExternal( 'confighelper', 'https://martinezdelizarrondo.com/ckplugins/confighelper/' );
  CKEDITOR.on('instanceReady', function () {
    $('#' + ckeditor_textbox_id).attr('required', '');
    $.each(CKEDITOR.instances, function (instance) {
      CKEDITOR.instances[instance].on("change", function (e) {
        for (instance in CKEDITOR.instances) {
            CKEDITOR.instances[instance].updateElement();
            $('form').parsley().validate();
        }
      });
    });
  });
}
