class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.integer :id_number
      t.string :name

      t.timestamps
    end
  end
end
