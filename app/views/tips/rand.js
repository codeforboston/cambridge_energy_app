$(function() {
  $("#submit_button").on("click", function(event) {
    event.preventDefault();
    $.ajax({
      type: "POST",
      url: "tips_controller_url",
      data: "your_form_data"
      success: function(result) {
        // Append the result to a table or list, $("list").append(result)
      },
    });
  });
});
