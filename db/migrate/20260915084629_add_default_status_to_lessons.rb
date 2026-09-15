class AddDefaultStatusToLessons < ActiveRecord::Migration[8.1]
  def change
    change_column_default :lessons, :status, "available"
  end
end
