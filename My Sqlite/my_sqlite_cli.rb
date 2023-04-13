
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

