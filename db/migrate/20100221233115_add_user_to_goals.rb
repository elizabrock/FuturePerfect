class AddUserToGoals < ActiveRecord::Migration
  def self.up
    change_table :goals do |t|
      t.references :user
    end
  end

  def self.down
    change_table :goals do |t|
      t.remove_references :user
    end
  end
end
