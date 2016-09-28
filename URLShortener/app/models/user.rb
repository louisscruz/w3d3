class User < ActiveRecord::Base
  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visited_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  validates :email, presence: true, uniqueness: true
end
