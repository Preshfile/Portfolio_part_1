require 'csv'

class MySqliteRequest
    def initialize
        @table_name = nil
        @query = nil
    end

    def from(table_name)
        if !table_name.empty?
            @table_name = table_name
        end
        return self
    end
    
    def select(columns)
       if !columns.empty?
            @query = 'select'
            @columns = columns.is_a?(String) ? [columns] : columns
        end
        return self
    end

    def where(column, value)
        @where = {column: column, value: value}
        return self
    end

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        @join = {column_a: column_on_db_a, column_b: column_on_db_b}
        @table_name_join = filename_db_b
        return self
    end

    def order(order, column_name)
        @order_query = {order: order, column_name: column_name}
        return self
    end

    def insert(table_name)
        @query = 'insert'
        @table_name = table_name
        return self
    end

    def values(data)
        @data = data
        return self
    end

    def update(table_name)
        @query = 'update'
        @table_name = table_name
        return self
    end

    def set(data)
        @data = data
        return self
    end

    def delete
        @query = 'delete'
        return self
    end

    def run_join
        parsed_csv_a = load_csv_hash(@table_name)
        parsed_csv_b = load_csv_hash(@table_name_join)
        parsed_csv_b.each do |row|
            criteria = {@join[:column_a] => row[@join[:column_b]]}
            row.delete(@join[:column_b]) 
            update_operation(parsed_csv_a, criteria, row) 
        end
        return parsed_csv_a
    end

    def print_selection(result)
        if !result
            return
          end
          if result.length == 0
            puts "There is no result for this request."
          else
            columns = result.first.keys
            formatted_columns = columns.map { |c| "\"#{c}\"" }.join(' | ')
            len = formatted_columns.length
            puts formatted_columns
            puts "*" * len
            result.each do |line|
              formatted_line = columns.map { |c| "\"#{line[c]}\"" }.join(' | ')
              puts formatted_line
            end
            puts "*" * len
          end
    end

    # run executes the request.
    def run
        if @table_name != nil
            parsed_csv = load_csv_hash(@table_name)
        else
            puts "Valid request contains table"
            return
        end
        if @query == 'select'
            if @join != nil
                parsed_csv = run_join
            end
            if @order_query != nil
                parsed_csv = order_operation(parsed_csv, @order_request[:order], @order_request[:column_name])
            end
            if @where != nil
                parsed_csv = where_operation(parsed_csv, {@where[:column]=> @where[:value]})
            end
            if @columns != nil && @table_name != nil
                result = get_columns(parsed_csv, @columns)
                print_selection(result)
            else
                puts "No Columns Provided on the SELECT statement"
                return
            end
        end

        if @query == 'insert'
            if @data != nil
                parsed_csv = insert_operation(parsed_csv, @data)
            end
            write_to_file(parsed_csv, @table_name)
            #puts "Data Inserted Successfully"
        end

        if @query == 'update'
            if @where != nil
                @where = {@where[:column] => @where[:value]}
            end
            parsed_csv = update_operation(parsed_csv, @where, @data)
            write_to_file(parsed_csv, @table_name)
            #puts "Data Updated Successfully"
        end

        if @query == 'delete'
            if @where != nil
                @where = {@where[:column]=> @where[:value]}
            end
            parsed_csv = delete_operation(parsed_csv, @where)
            write_to_file(parsed_csv, @table_name)
            #puts "Data Deleted successfully"
        end

        @query = nil
        @where = nil
        @table_name = nil
        @data = nil
        @join = nil
    end
    private
    def load_csv_hash(db_name)
        if(!File.exist?(db_name))
            puts 'File does not exist'
            return
        else
            list_of_hashes = CSV.open(db_name, headers: true).map(&:to_hash)
            return list_of_hashes
        end
    end
    def write_to_file(list_of_hashes, db_name)
        CSV.open(db_name, "w", :headers => true) do |csv|
            if list_of_hashes.length == 0
                return
            end 
            csv << list_of_hashes[0].keys # how to fix this???
            list_of_hashes.each do |hash|
                csv << CSV::Row.new(hash.keys, hash.values)
            end
        end
    end
    def get_columns(list_of_hashes, list_of_columns)
        if !list_of_hashes
            return
        else
            result = []
            list_of_hashes.each do |hash|
                new_hash = {}
                if list_of_columns[0] == "*"
                    result << hash
                else 
                    list_of_columns.each do |column|
                        new_hash[column] = hash[column]
                    end
                    result << new_hash
                end
            end
            return result
        end
    end
    def order_operation(list_of_hashes, order_type, column)
        0.upto list_of_hashes.length - 1 do |i|
            i.upto list_of_hashes.length - 1 do |j|
                line_i = list_of_hashes[i] 
                line_j = list_of_hashes[j]
    
                val_i = line_i[column] 
                val_j = line_j[column]
    
                if order_type == "asc"
                    if val_i > val_j
                        temp = list_of_hashes[i]
                        list_of_hashes[i] = list_of_hashes[j]
                        list_of_hashes[j] = temp
                    end
                elsif order_type == "desc"
                    if val_i < val_j
                        temp = list_of_hashes[i]
                        list_of_hashes[i] = list_of_hashes[j]
                        list_of_hashes[j] = temp
                    end
                end
            end
        end
        return list_of_hashes
    end
    def insert_operation(list_of_hashes, new_hash)
        result = []
        list_of_hashes.each do |row|
            result.push(row)
        end
        result.push(new_hash)
        return result
    end
    def check_criteria(line_from_list, criteria_hash)
        if criteria_hash == nil
            return true
        end
        criteria_hash.each do |key, value|
            if value != line_from_list[key]
                return false
            end 
        end
        return true
    end
    def merge_lines(line_from_list, update_hash)
        update_hash.each do |key, value|
            line_from_list[key] = value
        end
        return line_from_list
    end

    def update_operation(list_of_hashes, criteria_hash, update_hash)
        result = []
        list_of_hashes.each do |row|
            if check_criteria(row, criteria_hash)
                updated_row = merge_lines(row, update_hash)
                result << updated_row
            else
                result << row
            end
        end
        return result
    end
    def load_csv_hash(table_name)
        file_name = "#{table_name}"
        csv_contents = File.read(file_name)
        csv_data = CSV.parse(csv_contents, headers: true)
        csv_data.map(&:to_h)
    end
    def where_operation(list_of_hashes, criteria_hash)
        result = []
        list_of_hashes.each do |row|
            if check_criteria(row, criteria_hash)
                result << row
            end
        end
        return result
    end
    def delete_operation(list_of_hashes, criteria_hash)
        result = []
        if criteria_hash != nil
            list_of_hashes.each do |row|
                if check_criteria(row, criteria_hash)
                    next
                else
                    result << row
                end
            end
        end
        return result
    end
end

# request = MySqliteRequest.new
# request = request.from('data.csv')
# request = request.select('Player')
# # request.run
# request = MySqliteRequest.new
#   request = request.from('students.csv')
#   request = request.select('name')
#   request = request.where('email', 'kitukujosphat@gmail.com')
#   request.run
#my_request = MySqliteRequest.new
#players_data = my_request.load_csv_hash("players")
# request = MySqliteRequest.new
# request = request.from('data2.csv')
# request = request.select('name')
# request = request.where('college', "University of California, Los Angeles")
# request.run
# request = MySqliteRequest.new
# request = request.insert('data2.csv')
# request = request.values('name' => 'Precious Oranye', 'year_start' => '2023', 'year_end' => '2025', 'position' => 'F-C', 'height' => '6-10', 'weight' => '70', 'birth_date' => "June 24, 1993", 'college' => 'University of Lagos')
# request.run
# request = MySqliteRequest.new
# request = request.update('data2.csv')
# request = request.values('name' => 'Precious O')
# request = request.where('name', 'Precious Oranye')
# request.run
# request = MySqliteRequest.new
# request = request.delete()
# request = request.from('data2.csv')
# request = request.where('name', 'Kituku Josphat')
# request.run

