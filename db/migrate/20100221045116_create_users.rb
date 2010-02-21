class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.authenticatable :encryptor => :bcrypt
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
    end
    
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
