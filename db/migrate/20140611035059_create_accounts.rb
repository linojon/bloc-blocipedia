class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :level, default: 'free'
      t.references :user, index: true
      t.timestamps
    end
  end

  def up
    User.all.each {|u| u.create_account }
  end
  
end
