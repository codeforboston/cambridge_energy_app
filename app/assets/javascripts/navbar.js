document.addEventListener("turbolinks:load", function() {
  $("#dropdown-hover").hover(function() {
    $("#name-dropdown-list").toggleClass("display-none");
  });
});
