class ShortenedUrl < ActiveRecord::Base
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
      -> { distinct },
    through: :visits,
    source: :visitors

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

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where("created_at > ?", 10.minutes.ago).count
  end
end
