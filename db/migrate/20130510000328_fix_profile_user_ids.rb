class FixProfileUserIds < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  class Profile < ActiveRecord::Base
  end

  def change
    User.find_each do |user|
      profile = Profile.find_by_email(user.email)
      if profile
        profile.user_id = user.id
        profile.save
      end
    end
  end
end
