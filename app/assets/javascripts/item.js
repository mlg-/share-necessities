$("#item_url").change(function(){
  var url = $("#item_url").val();
  $.ajax({
    type: "GET",
    url: "/thumbnails/new",
    data: { url: url },
    dataType: "json",
    success: function(data){
      if (data.images.length > 1) {
        var i = 1
        addThumbnailsToPage(data, i)
      } else {
        var i = 0
        addThumbnailsToPage(data, i)
      }
    }
  });
});

function addThumbnailsToPage(data, i){
  var imageUrl = (data.images[1].src);
  $("#item-thumbnail").prepend("<img src=\"" + imageUrl + "\"/>" );
  $("#item_thumbnail_url").val(imageUrl);
};