# frozen_string_literal: true

children = [
  { name: 'Coen', age: 6 },
  { name: 'Daphne', age: 4 },
  { name: 'Crosby', age: 2 }
]

expect(children).to match [
  { name: 'Coen', age: a_value > 5 },
  { name: 'Daphne', age: a_value_between(3, 5) },
  { name: 'Crosby', age: a_value < 3 }
]
