class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.integer :ticket_id
      t.integer :amount
      t.string  :location
      t.integer :room
      t.string  :aasm_state
      t.string  :comment
      t.integer :stored_employee_id
      t.integer :retrieved_employee_id

      t.timestamps
    end
    add_index :details, :room
    add_index :details, :aasm_state
    add_index :details, :location
    add_index :details, :created_at
    add_index :details, :updated_at
  end
end
