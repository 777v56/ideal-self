class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.integer :user_id, null: false
      t.string :weight
      t.string :fat
      t.string :muscle
      t.string :waist
      t.datetime :input_date, null: false
      t.timestamps
    end
  end
end
