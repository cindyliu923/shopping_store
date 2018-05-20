class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.integer :price
      t.timestamps
    end

    add_index :order_items, [:order_id, :product_id]
  end
end
