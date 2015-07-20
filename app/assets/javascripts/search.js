$('#org-search-link').click(function(event){
  event.preventDefault();
  $('#search-options').hide();
  $('#org-search').show();
});

$('#item-search-link').click(function(event){
  event.preventDefault();
  $('#search-options').hide();
  $('#item-search').show();
});

$('#close-form').click(function(){
  $('#search-options').show();
  $('#org-search').hide();
  $('#item-search').hide();
});



