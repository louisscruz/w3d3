class ShortenedUrl < ActiveRecord::Base
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  validates :long_url, :short_url, presence: true, uniqueness: true

  def self.random_code
    begin
      random = SecureRandom::urlsafe_base64
    end while self.exists?(short_url: random)
    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(long_url: long_url, short_url: self.random_code, user_id: user.id)
  end
end
