class User < ActiveRecord::Base
  rolify
  attr_accessible :provider, :uid, :name, :email, :role_ids
  has_one :profile

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
        profile.user_id = created_user.id
        if auth['info']
          profile.github = auth['info']['nickname']
        end
      end
    end

    created_user
  end

  #update the users mail if changed at github
  def update_email(email)
    if email != self.email
      self.update_attributes!(:email=>email)
      #ToDo can be ignored if using association b/w users and profiles
      self.profile.update_attributes!(:email=>email)
    end
  end

end
