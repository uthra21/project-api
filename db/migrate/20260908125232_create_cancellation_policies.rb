class CreateCancellationPolicies < ActiveRecord::Migration[8.1]
  def change
    create_table :cancellation_policies do |t|
      t.integer :cancellation_time, default: 24
      t.decimal :refund_percentage, precision:5, scale:2, default: 100.00
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
    add_index :cancellation_policies,[:id,:studio_id], unique:true
  end
end
