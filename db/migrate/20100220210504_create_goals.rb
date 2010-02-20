class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.string :description
      t.datetime :completed_at
      t.references :parent_goal

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
