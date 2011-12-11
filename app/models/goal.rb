class Goal < ActiveRecord::Base
  attr_accessible :title, :success_means

  belongs_to :user
  has_many :progresses, order: "created_at ASC"

  validates_presence_of :user

  def last_progress
    self.progresses.last
  end
end
