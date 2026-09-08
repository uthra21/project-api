class CreateCancellationPolicies < ActiveRecord::Migration[8.1]
  def change
    create_table :cancellation_policies do |t|
      t.integer :cancellation_time
      t.decimal :refund_percentage
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
