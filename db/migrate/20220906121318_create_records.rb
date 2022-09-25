class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.integer :user_id, null: false
      t.float :weight
      t.float :fat
      t.float :muscle
      t.float :waist
      t.date :input_date, null: false
      t.timestamps
    end
  end
end
