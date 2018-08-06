class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :number
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :tickets, :number, unique: true
    add_index :tickets, :name
  end
end
