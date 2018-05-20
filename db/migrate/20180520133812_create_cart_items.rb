class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 1
      t.integer :product_id
      t.integer :cart_id
      t.timestamps
    end

    add_index :cart_items, [:product_id, :cart_id]
  end
end
