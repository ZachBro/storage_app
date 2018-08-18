class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.integer :ticket_id
      t.integer :amount
      t.string  :location
      t.integer :room
      t.integer :stored_employee_id
      t.integer :retrieved_employee_id

      t.timestamps
    end
    add_index :details, :room
  end
end
