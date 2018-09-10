$( document ).on('turbolinks:load', function() {
  $('.alert').delay(5000).fadeOut("slow", function () {
    $(this).remove();
  })
})
