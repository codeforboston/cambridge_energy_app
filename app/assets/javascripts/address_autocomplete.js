$(document).ready(() => {
  if(document.getElementById("new-unit-address-input")) {
    let addressInput = $("#new-unit-address-input");

    $.ajax({
      url: '/api/v1/addresses',
      method: 'GET'
    })
    .success(responseData => {
      createAutocompleteList(addressInput, responseData);
    })
    .error((xhr, status, err) => {
      console.log("error in retrieving list of adrresses", err, status)
    });
  }
});

function createAutocompleteList(inputElement, addressData) {
  let hiddenField = $("#user-building-id")
  inputElement.autocomplete({
    source: addressData,

    select: (event, ui) => {
      event.preventDefault();
      inputElement.val(ui.item.label);
      hiddenField.val(ui.item.value);
    },

    focus: (event, ui) => {
      event.preventDefault();
      inputElement.val(ui.item.label);
    },

    change: (event, ui) => {
      let addresses = addressData.map(obj => obj.label)
      if(ui.item == null || addresses.indexOf(ui.item.label) < 0){
        hiddenField.val("")
      }
    }
  });
};
