class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :level, default: 'free'
      t.string :stripe_customer
      t.references :user, index: true
      t.timestamps
    end
  end
end
