class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total_price
      t.float :discount
      t.integer :payable_amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
