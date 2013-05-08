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

  def is_active_admin_menu_link?(menu_link, controller_name)
    "active" if controller_name == "admin/#{menu_link}"
  end

  def kramdown(text)
    sanitize(Kramdown::Document.new(text).to_html)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
