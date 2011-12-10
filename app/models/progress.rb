class Progress < ActiveRecord::Base
  belongs_to :goal

  validates_presence_of :goal, :task_accomplished, :next_step
end
