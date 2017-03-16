class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.string :title
      t.boolean :isdone
      t.date :due
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
