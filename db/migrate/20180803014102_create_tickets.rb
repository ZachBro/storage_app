class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :number
      t.string :name
      t.string :aasm_state
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :tickets, :number, unique: true
    add_index :tickets, :name
    add_index :tickets, :aasm_state
    add_index :tickets, :created_at
    add_index :tickets, :updated_at
  end
end
