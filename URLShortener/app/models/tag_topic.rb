class TagTopic < ActiveRecord::Base
  before_create :downcase_title
  validates :title, presence: true, uniqueness: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: :Tagging

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

  def self.handle_tag_creation!(short_url, tag_title)
    tag_topic = find_by(title: tag_title)
    unless tag_topic
      tag_topic = TagTopic.create!(title: tag_title)
    end
    Tagging.create!(shortened_url_id: short_url.id, tag_topic_id: tag_topic.id)
  end

  def downcase_title
    self.title.downcase!
  end
end
