class ActivityFuMigration < ActiveRecord::Migration
  def self.up
    create_table :activities, :force => true do |t|
      t.references :doer, :polymorphic => true # , :null => false
      t.references :target,    :polymorphic => true
      t.boolean    :visibility, :default => true
      t.string     :text
      t.timestamps      
    end

    # add indexes for the polymorphic foreign keys
    add_index :activities, ["doer_id", "doer_type"],       :name => "fk_doer"
    add_index :activities, ["target_id", "target_type"], :name => "fk_target"

  end

  def self.down
    drop_table :activities
  end

end
