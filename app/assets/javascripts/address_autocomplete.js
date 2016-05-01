$(document).ready(function() {
  if(document.getElementById("new-unit-address-input")) {
    var addressInput = $("#new-unit-address-input");

    $.ajax({
      url: '/api/v1/addresses',
      method: 'GET'
    })
    .success(function(responseData) {
      createAutocompleteList(addressInput, responseData);
    })
    .error(function(xhr, status, err) {
      console.log("error in retrieving list of adrresses", err, status)
    });
  }
});

function createAutocompleteList(inputElement, addressData) {
  var hiddenField = $("#user-building-id");
  inputElement.autocomplete({
    source: addressData,

    select: function(event, ui) {
      event.preventDefault();
      inputElement.val(ui.item.label);
      hiddenField.val(ui.item.value);
    },

    focus: function(event, ui) {
      event.preventDefault();
      inputElement.val(ui.item.label);
    },

    change: function(event, ui) {
      var addresses = addressData.map(function(obj) { return obj.label; })
      if(ui.item == null || addresses.indexOf(ui.item.label) < 0){
        hiddenField.val("")
      }
    }
  });
};
