class CreateInstructors < ActiveRecord::Migration[8.1]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.references :studio, null:false, foreign_key:true

      t.timestamps
    end
    add_index :instructors, [:email,:studio_id], unique:true
  end
end
