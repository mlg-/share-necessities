$("#item_url").change(function(){
  var url = $("#item_url").val();
  $.ajax({
    type: "GET",
    url: "/thumbnails/new",
    data: { url: url },
    dataType: "json",
    success: function(data){
      console.log(data.images[1].src);
    }
  });
});