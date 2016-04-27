$(document).ready(function(){
  $('#edit_user_form').submit(concatPhone);
});

var concatPhone = function() {
  var $areaCode = $('#area_code').val();
  var $exchange = $('#exchange').val();
  var $line = $('#line').val();
  $('#user_phone').val($areaCode + $exchange + $line);
};
