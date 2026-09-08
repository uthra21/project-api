class CreateStudios < ActiveRecord::Migration[8.1]
  def change
    create_table :studios do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :studios, :slug, unique:true
  end
end
