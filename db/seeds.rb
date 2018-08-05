Ticket.create!(number: "300000", name: "Smith. J")

Ticket.create!(number: "300001", name: "Nguyen. K")

Employee.create!(id_number: "300000",
                 name:  "Fred")

Employee.create!(id_number: "300001",
                 name:  "Bob")

Detail.create!(ticket_id: "1", amount: "1", location: "1A",
                stored_employee_id: "1", active: true)

Detail.create!(ticket_id: "1", amount: "2", location: "1B",
                stored_employee_id: "2", active: true)

Detail.create!(ticket_id: "1", amount: "4", location: "1C",
                stored_employee_id: "1", active: true)

Detail.create!(ticket_id: "2", amount: "7", location: "5C",
                stored_employee_id: "2", active: true)

Detail.create!(ticket_id: "2", amount: "1", location: "1A",
                stored_employee_id: "1", active: true)
