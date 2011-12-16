
$(document).ready(function() {
  $(".log").append('<p>ready</p>');
  var my_id = "Me"
  var url = "/actor/" + my_id
  var source = new EventSource(url)
  source.onmessage = function() {
    var event_count = 0;
    return function(event){
      event_count += 1;
      var detail_id = "event_" + event_count;
      var new_detail = $("<li />", {
        id: detail_id
      });
      new_detail.html("event " + event.data);
      $("#eventslist").append(new_detail);
    };
  }();
});
