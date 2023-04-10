
require 'readline'
require_relative "my_sqlite_request"

def readline_func
    request_stmt = Readline.readline('my_sqlite_cli> ', true)
    # return nil if line.nil?
    if request_stmt =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == request_stmt
        Readline::HISTORY.pop
    end
    request_stmt
end

def array_to_hash(arr)
    result = Hash.new
    i = 0
    while i < arr.length 
        left, right = arr[i].split("=")
        result[left] = right
        i += 1
    end
    return result
end

def process_action(action, args, request)
    case action
    when "from"
        request.from(*args)
    when "select"
        request.select(args)
    when "where"
        col, val = args[0].split("=")
        request.where(col, val)
    when "order"
        col_name = args[0]
        sort_type = args[1].downcase
        request.order(sort_type, col_name)
    when "join"
        table = args[0]
        col_a, col_b = args[2].split("=")
        request.join(col_a, table, col_b)
    when "insert"
        request.insert(*args)
    when "values"
        request.values(array_to_hash(args))
    when "update"
        request.update(*args)
    when "set"
        request.set(array_to_hash(args)) 
    when "delete"
        request.delete 
    else
        puts "Quit?"
    end
end

def execute_request(sql)
    valid_actions = ["SELECT", "FROM", "JOIN", "WHERE", "ORDER", "INSERT", "VALUES", "UPDATE", "SET", "DELETE"]
    command = nil
    args = []
    request = MySqliteRequest.new
    splited_command = sql.split(" ")
    
    0.upto splited_command.length - 1 do |arg|
        # p splited_command[arg]
        if valid_actions.include?(splited_command[arg].upcase())
            if (command != nil) 
                if command != "JOIN"
                    args = args.join(" ").split(", ")
                end
                process_action(command, args, request)
                command = nil
                args = []
            end
            command = splited_command[arg].downcase()
        else
            args << splited_command[arg]
        end
    end
    process_action(command, args, request)
    request.run
end

def run
    puts "MySQLite version 0.1 2023-03-25"
    while command = readline_func
        if command == "quit"
            break
        else
            execute_request(command)
        end
    end
end

run()







# require 'csv'

# class MySqliteCLI
#   def initialize(file_name, command)
#     @file_name = file_name
#     @command = command
#   end

#   def run
#     request = build_request(@command)

#     if request.nil?
#       puts 'Invalid query'
#     else
#       result = request.run
#       display_result(result)
#     end
#   end

#   private

#   def build_request(input)
#     request = MySqliteRequest.new

#     words = input.split(' ')

#     case words.first
#     when 'select'
#       request.select(*words[1..-1])
#     when 'from'
#       request.from(words[1])
#     when 'where'
#       if words[1].include?('=')
#         column_name, criteria = words[1].split('=')
#         request.where(column_name, criteria)
#       else
#         puts 'Invalid where condition'
#         return nil
#       end
#     when 'join'
#       request.join(words[1], words[2], words[3])
#     when 'insert'
#       table_name = words[2]
#       values = parse_values(words[3..-1])
#       request.insert(table_name).values(values)
#     when 'update'
#       table_name = words[1]
#       set_clause = input[/set\s(.+)/i, 1]
#       values = parse_values(set_clause.split(','), separator: '=')
#       request.update(table_name).set(values)
#     when 'delete'
#       request.delete
#     when 'order'
#       request.order(words[1], words[2].to_sym)
#     else
#       puts 'Invalid query'
#       return nil
#     end

#     request
#   end

#   def parse_values(values, separator: ',')
#     result = {}

#     values.each do |value|
#       key, value = value.split(separator)
#       result[key] = value
#     end

#     result
#   end

#   def display_result(result)
#     if result.any?
#       puts result.first.keys.join(', ')

#       result.each do |row|
#         puts row.values.join(', ')
#       end
#     else
#       puts 'No results'
#     end
#   end
# end

# app = MySqliteCLI.new
# app.run


