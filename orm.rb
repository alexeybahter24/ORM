require 'pg'

class ORM

  class << self

    def create(option={})
      key, val = '', ''
      option.each {|k, v| key << "#{k}, "; val << "'#{v}', " }
      pg_conn.exec("INSERT INTO #{table_name} (#{key.chomp(', ')}) VALUES (#{val.chomp(', ')});")
    end

    def find(option={})
      pg_conn.exec "SELECT * FROM #{table_name} WHERE (#{find_and_where(option)}) LIMIT 1;"
    end

    def where(option={})
      pg_conn.exec "SELECT * FROM #{table_name} WHERE (#{find_and_where(option)});"
    end

    def update(option={})
      val = ''
      option.each {|k, v| val << "#{k} = '#{v}', " }
      pg_conn.exec "UPDATE #{table_name} SET #{val.chomp(', ')};"
    end

    def delete(option={})
      pg_conn.exec "DELETE FROM #{table_name} WHERE (#{find_and_where(option)});"
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