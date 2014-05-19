class AddDefaultsToTeamMember < ActiveRecord::Migration
  def up
    change_column :team_members, :times_in_contests, :integer, :default => 0
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
