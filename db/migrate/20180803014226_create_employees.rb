class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :id_number
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :employees, :id_number, unique: true
  end
end
