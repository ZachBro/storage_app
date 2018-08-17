Employee.create!(id_number: "300000",
                 name:  "Fred")

Employee.create!(id_number: "300001",
                 name:  "Bob")

Employee.create!(id_number: "300002",
                 name:  "Steve")

Employee.create!(id_number: "300003",
                 name:  "Nick")

Ticket.create!(number: "300000", name: "Smith. J", details_attributes:
          [{amount: "1", location: "1A", room: "1010", s_employee_id: "300000"},
           {amount: "2", location: "1B", room: "1010", s_employee_id: "300001"},
           {amount: "4", location: "1C", room: "1010", s_employee_id: "300000"}])

Ticket.create!(number: "300001", name: "Nguyen. K", details_attributes:
          [{amount: "7", location: "5C", room: "1710",  s_employee_id: "300000"},
           {amount: "1", location: "1A", room: "1810",  s_employee_id: "300001"}])

Ticket.create!(number: "300002", name: "O'Brien. T", active: false, details_attributes:
          [{amount: "1", location: "2B", room: "1515",  s_employee_id: "300000",
            retrieved_employee_id: "2"}])


time_one = Time.now
100000.times do |d|
  if (rand(1..1000) > 999)
    Ticket.create!(number: d.to_s.rjust(6, "100000"), name: Faker::Name.name, details_attributes:
          [{amount: rand(1..10), location: (rand(1..7).to_s + "B"), room: rand(1000..1480), s_employee_id: rand(300000..300003).to_s}])
  else
    Ticket.create!(number: d.to_s.rjust(6, "100000"), name: Faker::Name.name, active: false, details_attributes:
          [{amount: rand(1..10), location: (rand(1..7).to_s + "B"), room: rand(1000..1480), s_employee_id: rand(300000..300003).to_s, retrieved_employee_id: "1"}])
  end
end
time_two = Time.now
total_time = time_two - time_one
puts total_time
