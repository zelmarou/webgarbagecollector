var videoId = null;
$(function() {

  $("#videos_search input").keyup(function() {
        $.get($("#videos_search").attr("action"), $("#videos_search").serialize(), null, "script");
        $("#search").effect("highlight", {}, 1000);
    return false;
  });

 $("#video_param_title").keyup(function() {
      $('#video_md5').val(hex_md5($('#video_param_title').val())+new Date().getTime().toString());
    return false;
  });


$('[id^=wcc_video_]').click(function() {
    var beginFlag = "wcc_video_";
    var beginTag  = "_begin_tag";
    var posVideo= this.id.indexOf(beginTag)+beginTag.length + 1  ;
    var posBeginTag = this.id.indexOf(beginTag);
    videoId = this.id.substring(beginFlag.length,posBeginTag );
    var posEndTag = this.id.indexOf('_end_tag');
    $('#videoTitle').html("<h3 style='font-size: 20px'>"+this.id.substring(posBeginTag + beginTag.length + 1 ,posEndTag  )+"</h3>");
    $('#wgclink').html("<h3>WebGarbageCollector link: <a href='/videos/"+videoId+"' style='color: white' >http://www.webgarbagecollcetor.com/videos/"+videoId+"</a></h3>");
    $('#wikis').load("/videos/"+videoId+"/show_wiki");
  //Updating view counts
 $.ajax({
    url: "/videos/"+videoId+"/update_view_count",
    type: 'PUT',
   success: function(data){
   $("#viewscount").html("<h3>Views: "+data+"</h3>");
  },
  error: function(){
    //alert('failure');
  }
  });
});

/*A decommenter initialisation du titre
$(document).ready(function() {

    //var pos= $('[id$=number_1]').attr('id').indexOf('index')+6;
    //$('#videoTitle').html("<h3>"+$('[id$=number_1]').attr('id').substring(pos)+"<h3/>");

    var posVideo= $('[id$=number_1]').attr('id').indexOf('_begin_tag')+10 ;
    var posBeginTag = $('[id$=number_1]').attr('id').indexOf('_begin_tag');
    videoId = $('[id$=number_1]').attr('id').substring(6,posBeginTag );
    var posEndTag = $('[id$=number_1]').attr('id').indexOf('_end_tag');
    $('#videoTitle').html("<h3>"+ $('[id$=number_1]').attr('id').substring(posBeginTag + 11 ,posEndTag  )+"<h3/>");
    $('#wiki_video').("/videos/"+videoId+"/show_wiki");
    //Updating view counts
    $.ajax({
    url: "/videos/"+videoId+"/update_view_count",
    type: 'PUT',
    success: function(data){
    $("#viewscount").html("<h3>VIEWS: "+data+"</h3>");
    },
    error: function(){
        //alert('failure');
    }
    });
});
*/

});


 function get_view_count () {
    if (videoId != null)
     $.ajax({
        url: "/videos/"+videoId+"/get_view_count",
        type: 'PUT',
       success: function(data){
       var newVal = "<h3>VIEWS: "+data+"</h3>" ;

       // alert("change");
       if ( $("#viewscount").html().toString() !=  newVal.toString() )
       {
        $("#viewscount").html("<h3>VIEWS: "+data+"</h3>");
        $("#viewscount").effect("highlight", {}, 9000);
        }
        },
      error: function(){
        //alert('failure '+ videoId);
      }
     });
 };

 function get_upload_progress (md5) {
   // if (md5.toString().trim() != "" && md5.toString().trim() != null && md5.toString().trim() != " "  ){
    alert("Hello");
$.ajax({
        url: "/videos/uploadprogress/"+md5,
        type: 'GET',
       success: function(data){
       var datauploaded = data;
        alert(datauploaded);
        },
      error: function(){
        alert('failure');
      }
     });
    // }
 };

//Callback updating views
//setInterval("get_view_count("+videoId+")", 60000);
