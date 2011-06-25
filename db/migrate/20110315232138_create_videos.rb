class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :param_title
      t.date :param_doc
      t.integer :param_size
      t.string :param_path
      t.integer :param_hits
      t.integer :param_mark
      t.string :param_desc
      t.string :param_video_url
      t.string :param_thumb
      t.integer :param_type
      t.date :param_wiki_date
      t.string :param_wiki_author
      t.string :param_wiki_country
      t.string :param_wiki_story
      t.string :param_wiki_links
      t.string :md5
      t.timestamps

    end
  end

  def self.down
    drop_table :videos
  end
end
