require 'pg'

class ORM

  class << self

    def create(option={})
      key, val = '', ''
      option.each {|k, v| key << "#{k}, "; val << "'#{v}', " }
      pg_conn.exec("INSERT INTO #{table_name} (#{key.chomp(', ')}) VALUES (#{val.chomp(', ')});")
      pg_conn.close
    end

    def find(option={})
      pg_conn.exec "SELECT * FROM #{table_name} WHERE (#{find_and_where(option)}) LIMIT 1;".each_line { |i| puts i }
      puts pg_conn.close
      puts pg_conn
    end

    def where(option={})
      con = pg_conn.exec "SELECT * FROM #{table_name} WHERE (#{find_and_where(option)});".each_line { |i| puts i }
      pg_conn.close
      puts con
    end

    def update(option={})
      val = ''
      option.each {|k, v| val << "#{k} = '#{v}', " }
      pg_conn.exec "UPDATE #{table_name} SET #{val.chomp(', ')};"
      pg_conn.close
    end

    def delete(option={})
      pg_conn.exec "DELETE FROM #{table_name} WHERE (#{find_and_where(option)});"
      pg_conn.close
    end

    def pg_close
      PG.close
    end

    private
    def pg_conn
      PG.connect :dbname => 'testdb', :user => 'alexey', :password => '1qazQAZ'
    end

    def table_name
      "#{self.name.downcase}s"
    end

    def find_and_where(option)
      if option.is_a? Hash
        where = ''
        option.each {|k, v|  where << "#{k} = '#{v}' and " }
        return where.chomp(' and ')
      else
        return option
      end
    end

  end

end


require_relative '../orm'

class User < ORM

end



# User.delete(first_name: 'Jack', last_name: 'London')
# User.find("first_name = 'Mad'")
User.where(first_name: 'Lesha', last_name: 'Mad')
# x = User.where(first_name: 'Alex', last_name: 'Mad')
# x.each {|i| puts i['first_name']}