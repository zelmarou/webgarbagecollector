class VideosController < ApplicationController
  # GET /videos
  # GET /videos.xml
  def index
    #    @videos = Video.all
    @videos = Video.search(params[:search])
    #    puts "**********DEBUG*********"
    #    puts system("i=0;while [  $i -lt 10 ];do echo $(s3cmd ls \"s3://webgarbagecollector/home/synaptic/NetBeansProjects/webgarbagecollector/public/movieclips/zelmarou22/original/\") | cut -d \" \" -f3    ;done;");
    #    puts "**********END*********"

    #    respond_to do |format|
    #      format.html # index.html.erb
    #      format.xml  { render :xml => @videos }
    #    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])
    @wiki = Wiki.new(:video_id => @video.id)
    respond_to do |format|
      format.html   #show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  def show_wiki
    @video = Video.find(params[:id])
    @wiki = Wiki.new(:video_id => @video.id)
    respond_to do |format|
      format.html { render :layout => "show_wiki" }
      format.js
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])
    @site_url = "http://ec2-50-17-168-53.compute-1.amazonaws.com:3000"
    puts "**********DEBUG*********"
    puts request.headers["CONTENT_LENGTH"].to_s()
    puts @video.param_title
    puts "**********END*********"
    @predicted_url = "s3://webgarbagecollector/home/synaptic/NetBeansProjects/webgarbagecollector/public/movieclips/"+@video.md5+"/original/"
    #    system("for ((  i = 0 ;  i <= 100;  i++  )); do   echo $(s3cmd ls c"+@predicted_url+"\")  | cut -d \" \" -f6;sleep 2; done;");
    #    puts("for ((  i = 0 ;  i <= 100;  i++  )); do   echo $(s3cmd ls v"+@predicted_url+"\")  | cut -d \" \" -f6;sleep 2; done;");
    respond_to do |format|
      if @video.save
        puts "URL:"
        puts @video.movieclip.url
        puts "PATH:"
        puts @video.movieclip.path
        #        puts "Video ID is --> "+@video.id.to_s();
        #      @video.param_thumb = @video.movieclip.url[0,@video.movieclip.url.index(".")]+"_thumb.jpg";
        #        @video.param_thumb = @site_url+ "/movieclips/"+@video.param_title.split(' ').join('_')+"_thumb.jpg";
        @local_video_thumb_name = @video.movieclip_file_name.gsub(' ','%20')+"_thumb.jpg" ;
#        @local_video_thumb = "/home/ubuntu/rails/webgarbagecollector/public/movieclips/"+@local_video_thumb_name;
#        @local_video_thumb = "/home/synaptic/NetBeansProjects/webgarbagecollector/public/movieclips/"+@local_video_thumb_name;
#       @local_video_path = @video.movieclip.url[0,@video.movieclip.url.index("?")];
#       @local_video_path = @local_video_path[@local_video_path.index("/webgarbagecollector"),@video.movieclip.url.length ];
#       @local_video_path = @local_video_path[0, @local_video_path.index("/original/")];
#       @video.update_attributes(params[:video]);
        #system("ffmpeg -i public/"+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -s 100x100 -ss 10 -f image2 -vframes 1 public/"+ @video.param_thumb);
        #system("ffmpeg -i "+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -s 100x100 -ss 10 -f image2 -vframes 1 "+ @local_video_thumb);
        system("ffmpegthumbnailer -i '"+@video.movieclip.path.gsub(' ','%20')+"' -o "+ @video.movieclip.path.gsub(' ','%20')[0,@video.movieclip.path.index(@video.movieclip_file_name.gsub(' ','%20'))]+"../"+@local_video_thumb_name);
        #puts("ffmpegthumbnailer -i '"+@video.movieclip.path.gsub(' ','%20')+"' -o "+ @video.movieclip.path.gsub(' ','%20')[0,@video.movieclip.path.index(@video.movieclip_file_name)]+@local_video_thumb_name);
        #puts "ffmpegthumbnailer -i '"+@video.movieclip.url[0,@video.movieclip.url.index("?")].gsub(' ','%20')+"' -o "+ @local_video_thumb ;
        #copy the jpg thumb into the s3 bucket
        system("s3cmd put --acl-public --recursive "+@video.movieclip.path.gsub(' ','%20')[0,@video.movieclip.path.gsub(' ','%20').index("/original")]+" s3://webgarbagecollector");
        puts("s3cmd put --acl-public --recursive "+@video.movieclip.path.gsub(' ','%20')[0,@video.movieclip.path.gsub(' ','%20').index("/original")]+" s3://webgabagecollector");
        @video.param_thumb = "http://s3.amazonaws.com/webgarbagecollector/"+@video.movieclip.path.gsub(' ','%20')[0,@video.movieclip.path.index(@video.movieclip_file_name.gsub(' ','%20'))][@video.movieclip.path.gsub(' ','%20').index(@video.md5),@video.movieclip.path.gsub(' ','%20').length]+"../"+@local_video_thumb_name ;
        @video.param_video_url = "http://s3.amazonaws.com/webgarbagecollector/"+@video.movieclip.path.gsub(' ','%20')[@video.movieclip.path.gsub(' ','%20').index(@video.md5),@video.movieclip.path.gsub(' ','%20').length];
        @video.update_attributes(params[:video]);
        format.html { redirect_to( '/wikis/new?video_id='+@video.id.to_s() , :notice => 'Your video was successfully uploaded, thanks. You should now fill the wiki' ) }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])
    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to(videos_url, :notice => 'Video Wiki was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update_view_count
    @video = Video.find(params[:id])
    if !@video.param_hits
      @video.param_hits = 0
    end
    @video.param_hits += 1
    @video.update_attributes(params[:video])

    render :text => @video.param_hits
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def get_view_count
    @video = Video.find(params[:id])
    render :text => @video.param_hits
  end

  
  # PUT /videos/1
  # PUT /videos/1.xml
  def edit_wiki
    @video = Video.find(params[:id])

  end
  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end

  def find_by_id (id)
    @video = Video.find(params[:id => id])
  end

  def uploadprogress
   
    @url = "public/movieclips/"+params[:md5]+"/original/Sample_K_flv.flv";
    @command  = %x[ls -l #{@url}  | cut -d " " -f5] ;
    render :text => @command;
    #    respond_to do |format|
    #      format.html {render :layout => false}
    #    render :text => "AJAX OK"
    #    end
  end



end
