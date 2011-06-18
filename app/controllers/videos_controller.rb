class VideosController < ApplicationController
  # GET /videos
  # GET /videos.xml
  def index
    #    @videos = Video.all
    @videos = Video.search(params[:search])

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
    respond_to do |format|
      if @video.save
        #      @video.param_thumb = @video.movieclip.url[0,@video.movieclip.url.index(".")]+"_thumb.jpg";
        @video.param_thumb = @site_url+ "/movieclips/"+@video.param_title.split(' ').join('_')+"_thumb.jpg";
        @local_video_thumb_name = @video.param_title.split(' ').join('_')+"_thumb.jpg" ;
        @local_video_thumb = "/home/ubuntu/rails/webgarbagecollector/public/movieclips/"+@local_video_thumb_name;
        @local_video_thumb = "/home/synaptic/NetBeansProjects/webgarbagecollector/public/movieclips/"+@local_video_thumb_name;
        @local_video_path = @video.movieclip.url[0,@video.movieclip.url.index("?")];
        @local_video_path = @local_video_path[@local_video_path.index("/webgarbagecollector"),@video.movieclip.url.length ];
        @local_video_path = @local_video_path[0, @local_video_path.index("/original/")];
        @video.update_attributes(params[:video]);
        #system("ffmpeg -i public/"+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -s 100x100 -ss 10 -f image2 -vframes 1 public/"+ @video.param_thumb);
        #system("ffmpeg -i "+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -s 100x100 -ss 10 -f image2 -vframes 1 "+ @local_video_thumb);
        system("ffmpegthumbnailer -i '"+@video.movieclip.url[0,@video.movieclip.url.index("?")].gsub(' ','%20')+"' -o "+ @local_video_thumb);
        puts "ffmpegthumbnailer -i '"+@video.movieclip.url[0,@video.movieclip.url.index("?")].gsub(' ','%20')+"' -o "+ @local_video_thumb ;
        #copy the jpg thumb into the s3 bucket
        system("s3cmd put --acl-public "+@local_video_thumb+" s3:/"+@local_video_path+"/"+@local_video_thumb_name);
        @video.param_thumb = "http://s3.amazonaws.com"+@local_video_path+"/"+@local_video_thumb_name ;
        @video.update_attributes(params[:video]);
        format.html { redirect_to( videos_path , :notice => 'Your video was successfully uploaded, thank you' ) }
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
  



end
