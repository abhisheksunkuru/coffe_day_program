class ChangeColumnCustomerMobileToText < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :customers do |t|
        dir.up   { t.change :mobile, :string }
        dir.down { t.change :mobile, :integer }
      end
    end
  end
end
