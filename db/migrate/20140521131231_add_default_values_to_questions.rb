class AddDefaultValuesToQuestions < ActiveRecord::Migration
  def up 
    change_column :questions, :count, :integer, :default => 0
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
