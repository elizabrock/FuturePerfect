class ChangeProgressFieldsToText < ActiveRecord::Migration
  def up
    change_column :progresses, :task_accomplished, :text
    change_column :progresses, :next_step, :text
  end

  def down
    change_column :progresses, :task_accomplished, :string
    change_column :progresses, :next_step, :string
  end
end
