class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :goal_id
      t.string :task_accomplished
      t.string :next_step

      t.timestamps
    end
  end
end
