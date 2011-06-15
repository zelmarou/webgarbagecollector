$(function() {
  $("#videos_search input").keyup(function() {
        $.get($("#videos_search").attr("action"), $("#videos_search").serialize(), null, "script");
    //alert(12);
    return false;
  });

$('[id^=video_]').click(function() {
var pos= this.id.indexOf('index')+6 ;
  $('#videoTitle').html("<h3>"+this.id.substring(pos)+"<h3/>");
  $('#wiki_video').load("/videos/"+this.id.substring(6,pos - ( 6+1 ) )+"/show_wiki");
//$('#wiki_video').load('<%= url_for(:controller => 'Videos', :action => 'show_wiki' %>')});
// alert();
});

$(document).ready(function() {
    var pos= $('[id^=video_1_index]').attr('id').indexOf('index')+6;
  $('#videoTitle').html("<h3>"+$('[id^=video_1_index]').attr('id').substring(pos)+"<h3/>");
});

});

