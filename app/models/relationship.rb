class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower, presence: true
  validates :followed, presence: true

  before_save :follow_activity
  before_destroy :unfollow_activity

  private
  def follow_activity
    Activity.create user_id: self.follower_id, action:
      "follow(s) #{self.followed.name}"
  end

  def unfollow_activity
    Activity.create user_id: self.follower_id, action:
      "unfollow(s) #{self.followed.name}"
  end
end
