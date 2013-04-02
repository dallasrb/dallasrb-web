class User < ActiveRecord::Base
  rolify
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :uid, :name, :email

  def self.create_with_omniauth(auth)
    created_user = create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end

    unless Profile.find_by_email(created_user.email)
      Profile.create! do |profile|
        profile.name = created_user.name
        profile.email = created_user.email
        if auth['info']
          profile.github = auth['info']['nickname']
        end
      end
    end

    created_user
  end

end
