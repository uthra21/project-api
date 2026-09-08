class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.time :booking_time
      t.string :status

      t.timestamps
    end
  end
end
