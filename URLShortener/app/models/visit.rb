class Visit < ActiveRecord::Base
  belongs_to :shortened_urls,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :ShortenedUrl

  belongs_to :visitors,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def self.record_visit!(user, shortened_url)
    create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
end
