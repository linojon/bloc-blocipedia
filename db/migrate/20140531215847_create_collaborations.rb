class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :user, index: true
      t.references :wiki, index: true
      t.string :role, default: 'owner'
      t.timestamps
    end
  end
end
