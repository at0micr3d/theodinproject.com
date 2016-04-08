module UsersHelper

	# Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase.strip)
    gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.jpg"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: "50")
  end

  def authorized?
  	@user.id == current_user.id
  end
end
