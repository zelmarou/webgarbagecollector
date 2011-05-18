#zelmaroumarou
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

    respond_to do |format|
      format.html   #show.html.erb
      format.xml  { render :xml => @video }
    end
  end

    def show_wiki
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show_wiki.html.erb
      format.xml  { render :xml => @video }
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
    respond_to do |format|
      if @video.save
        #      @video.param_thumb = @video.movieclip.url[0,@video.movieclip.url.index(".")]+"_thumb.jpg";
        @video.param_thumb ="http://ec2-50-19-71-69.compute-1.amazonaws.com:3000/movieclips/"+@video.param_title.split(' ').join('_')+"_thumb.jpg";
        @local_video_thumb = "/home/ubuntu/rails/webgarbagecollector/public/movieclips/"+@video.param_title.split(' ').join('_')+"_thumb.jpg";

        @video.update_attributes(params[:video]);
        #system("ffmpeg -i public/"+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -s 100x100 -ss 10 -f image2 -vframes 1 public/"+ @video.param_thumb);
        #system("ffmpeg -i "+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -s 100x100 -ss 10 -f image2 -vframes 1 "+ @local_video_thumb);
        system("ffmpegthumbnailer -i "+@video.movieclip.url[0,@video.movieclip.url.index("?")]+" -o "+ @local_video_thumb);
      
        format.html { redirect_to( videos_path , :notice => 'Video was successfully created-->'+@video.param_thumb ) }
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
        format.html { redirect_to(@video, :notice => 'Video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
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
