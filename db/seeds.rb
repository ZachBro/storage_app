Ticket.create!(number: "300000", name: "Smith. J", active: true)

Ticket.create!(number: "300001", name: "Nguyen. K", active: true)

Ticket.create!(number: "300002", name: "O'Brien. T", active: false)

Employee.create!(id_number: "300000",
                 name:  "Fred")

Employee.create!(id_number: "300001",
                 name:  "Bob")

Detail.create!(ticket_id: "1", amount: "1", location: "1A",
                stored_employee_id: "1")

Detail.create!(ticket_id: "1", amount: "2", location: "1B",
                stored_employee_id: "2")

Detail.create!(ticket_id: "1", amount: "4", location: "1C",
                stored_employee_id: "1")

Detail.create!(ticket_id: "2", amount: "7", location: "5C",
                stored_employee_id: "2")

Detail.create!(ticket_id: "2", amount: "1", location: "1A",
                stored_employee_id: "1")

Detail.create!(ticket_id: "3", amount: "1", location: "2B",
                stored_employee_id: "1", retrieved_employee_id: "2")
