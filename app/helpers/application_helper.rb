module ApplicationHelper
  def gravatar_for(email)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
  def twitter_url_for(username)
    "http://twitter.com/#{username}"
  end

  def github_url_for(username)
    "http://github.com/#{username}"
  end
end
