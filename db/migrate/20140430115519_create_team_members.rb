class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :image_path
      t.integer :times_in_contests

      t.timestamps
    end
  end
end
