class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types
  mount_uploader :local_image, ImageUploader
  before_validation :set_image
  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def venue_name
  	venue ? venue.name : nil
  end

  def self.search(search)
  	where("name ILIKE?", "%#{search}%")
  end

  def self.feature_events
  	 where("starts_at >= ?", DateTime.now)
  end

  def self.own_events(user)
    where("user_id = ?", user.id)
  end

  def related
    Event.upcoming.joins(:venue).where("category_id = ? AND region_id = ? AND events.id != ?",
                                       category_id, region_id, id)
  end

  def set_image
    self.image = local_image_url if local_image_url
  end

  def upcoming?
    start_at > Time.now
  end

  def make_publish
    if self.ticket_types.count >= 1
      self.publish = true
      self.save!
    end
  end
end
