require 'flickraw'

module FlickrHelper  
  def user_photos(user_id, photo_count = 12)
    FlickRaw.api_key= ENV['Flickr_key']
    FlickRaw.shared_secret = ENV['Flickr_secret']


    #flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
    flickr.photos.search(:user_id => user_id).to_a.values_at(0..(photo_count - 1))
  end
  
  def render_flickr_sidebar_widget(user_id, photo_count = 12, columns = 2)
    begin
      photos = user_photos(user_id, photo_count).in_groups_of(2)
      render :partial => "flickr/sidebar_widget", :locals => { :photos => photos }
    rescue Exception
      render :partial => '/flickr/unavailable'
    end
  end
end