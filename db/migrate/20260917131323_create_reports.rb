class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.references :studio, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
