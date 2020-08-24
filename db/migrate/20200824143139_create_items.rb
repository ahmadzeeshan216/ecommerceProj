class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :quantity
      t.integer :price
      t.references :product, foreign_key: true
      t.references :purchaseable, polymorphic: true
      t.timestamps
    end
  end
end
