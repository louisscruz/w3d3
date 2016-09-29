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

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :long_url, length: { maximum: 1024 }

  validate :limit_urls
  validate :premium_limit

  def limit_urls
    if self.submitter.num_recent_url_creations >= 5
      self.errors[:submitter] << "over the limit"
    end
  end

  def premium_limit
    if !self.submitter.premium && self.submitter.submitted_urls.count > 5
      self.errors[:submitter] << "non-premium users have a limit of 5"
    end
  end

  def self.random_code
    begin
      random = SecureRandom::urlsafe_base64
    end while self.exists?(short_url: random)
    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(long_url: long_url, short_url: self.random_code, user_id: user.id)
  end

  def self.prune
    self.where("created_at < ?", 2.hours.ago).destroy
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
