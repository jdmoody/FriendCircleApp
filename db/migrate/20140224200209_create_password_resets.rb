class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.integer :user_id
      t.string :reset_token

      t.timestamps
    end
    add_index :password_resets, :user_id
    add_index :password_resets, :reset_token, unique: true
  end
end
