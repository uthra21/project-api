class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.datetime :start_time
      t.integer :capacity
      t.string :status, default: "available"
      t.string :code
      t.string :slug
      t.time :cancelled_at, default: nil
      t.references :studio, null: false, foreign_key: true
      t.references :instructor, foreign_key:true
      t.timestamps
    end
    add_index :lessons,[:studio_id,:slug], unique:true
    add_index :lessons,[:studio_id,:code], unique:true
  end
end
