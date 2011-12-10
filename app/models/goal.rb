class Goal < ActiveRecord::Base
  attr_accessible :title, :success_means

  belongs_to :user

  validates_presence_of :user
end
