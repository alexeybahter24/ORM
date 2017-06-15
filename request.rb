require_relative 'orm'

class User < ORM

end


User.create(first_name: 'John', last_name: 'Mad')
# User.delete(first_name: 'Jack', last_name: 'London')
# User.find("first_name = 'Alex'")
