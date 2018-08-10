Employee.create!(id_number: "300000",
                 name:  "Fred")

Employee.create!(id_number: "300001",
                 name:  "Bob")

Ticket.create!(number: "300000", name: "Smith. J", details_attributes:
          [{amount: "1", location: "1A", search_id: "300000"},
           {amount: "2", location: "1B", search_id: "300001"},
           {amount: "4", location: "1C", search_id: "300000"}])

Ticket.create!(number: "300001", name: "Nguyen. K", details_attributes:
          [{amount: "7", location: "5C", search_id: "300000"},
           {amount: "1", location: "1A", search_id: "300001"}])

Ticket.create!(number: "300002", name: "O'Brien. T", details_attributes:
          [{amount: "1", location: "2B", search_id: "300000",
            retrieved_employee_id: "2"}])
