class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :cart, foreign_key: true
      t.float :total
      t.string :status
      t.timestamps
    end
  end
end
