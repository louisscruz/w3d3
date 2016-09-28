class Visit < ActiveRecord::Base

  def self.record_visit!(user, shortened_url)
    create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
end
