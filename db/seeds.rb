Employee.create!(id_number: "300000",
                 name:  "Fred")

Employee.create!(id_number: "300001",
                 name:  "Bob")

Ticket.create!(number: "300000", name: "Smith. J", details_attributes:
          [{amount: "1", location: "1A", room: "1010", search_id: "300000"},
           {amount: "2", location: "1B", room: "1010", search_id: "300001"},
           {amount: "4", location: "1C", room: "1010", search_id: "300000"}])

Ticket.create!(number: "300001", name: "Nguyen. K", details_attributes:
          [{amount: "7", location: "5C", room: "1710",  search_id: "300000"},
           {amount: "1", location: "1A", room: "1810",  search_id: "300001"}])

Ticket.create!(number: "300002", name: "O'Brien. T", details_attributes:
          [{amount: "1", location: "2B", room: "1515",  search_id: "300000",
            retrieved_employee_id: "2"}])
