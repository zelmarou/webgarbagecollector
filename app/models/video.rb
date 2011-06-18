class Video < ActiveRecord::Base
  has_many :wikis
  # Paperclip Validations
  validates  :param_title, :param_desc, :presence => true
  validates_attachment_presence :movieclip
  validates_attachment_content_type :movieclip, 
    :content_type => [
      'application/x-shockwave-flash',
      'application/x-shockwave-flash',
      'application/flv',
      'video/x-flv',
      'video/mp4',
      'video/MP4V-ES',
      'video/MPV',
      'video/mpeg4',
      'video/mpeg4-generic',]
  

  # models/product.rb
  def self.search(search)
    if search
      find(:all, :conditions => ['param_title LIKE ? or param_desc LIKE ?', "%#{search}%","%#{search}%"])
    else
      find(:all)
    end
  end

  

  has_attached_file :movieclip,
    #    :url  => "/assets/products/:id/:style/:basename.:extension",
    :url  => "/:attachment/:id/:style/:basename.:extension",
    #  :path => "public/:attachment/:id/:style/:basename.:extension"
    :storage        => :s3,
    :s3_credentials => {
    :access_key_id     =>'AKIAJDCAFXWTGN5SQINQ',
    :secret_access_key => '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'
  },
    :bucket         => 'webgarbagecollector'


 



end
