# connect to address_book to use variables
require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    def initialize 
        @address_book = AddressBook.new
    end
# display main menu options    
    def main_menu
        puts "Main menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - Create an entry"
        puts "3 - Search for an entry"
        puts "4 - Import entries from a CSV"
        puts "5 - Exit"
        print "Enter your selection"
        
# retrieve user input from the command line
        selection = gets.to_i
        
        # determines proper response to user's input
        case selection
            when 1
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                create_entry
                main_menu
            when 3
                system "clear"
                search_entries
                main_menu
            when 4
                system "clear"
                read_CSV
                main_menu
            # end the program with no errors    
            when 5
                puts "Good-bye!"
                exit(0)
            #catches invalid user input
            else 
                system "clear"
                puts "Sorry, that is not a valid input"
                main_menu
        end
    end
        
        def view_all_entries
            address_book.entries.each do |entry|
                system "clear"
                puts entry.to_s
                
                # display a submenu for each entry
                entry_submenu(entry)
            end
            system "clear"
            puts "End of entry"
        end
        def create_entry
            # clear screen before displaying prompt
            system "clear"
            puts "New AddressBloc entry"
            
            # prompt user for each entry attribute
            print "Name: "
            name = gets.chomp
            print "Phone number: "
            phone = gets.chomp
            print "Email: "
            email = gets.chomp
            
            # adds a new entry to address_book
            address_book.add_entry(name, phone, email)
            system "clear"
            puts "New entry created"
        end
        def search_entries
            print "Search by name: "
            name = gets.chomp
            match = address_book.binary_search(name)
            system "clear"
            if match 
                puts match.to_s
                search_submenu(match)
            else
                puts "No match found for #{name}"
            end
        end
        def read_CSV
            print "Enter CSV file to import: "
            file_name = gets.chomp
            if file_name.empty?
                system "clear"
                puts "No CSV file read"
                main_menu
            end
            # import the specified file. then print screen and print the number of entries that were read
            begin 
                entry_count = address_book.import_from_csv(file_name).count
                system "clear"
                puts "#{entry_count} new entries added from #{file_name}"
            rescue
                puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
                read_CSV
            end
        end
        def entry_submenu(entry)
            # displays submenu options
            puts "n - next entry"
            puts "d - delete entry"
            puts "e - edit this entry"
            puts "m - return to main menu"
            
            selection = gets.chomp
            
            case selection
                when "n"
                when "d"
                    delete_entry(entry)
                when "e"
                    edit_entry(entry)
                    entry_submenu(entry)
                when "m"
                    system "clear"
                    main_menu
                else 
                    system "clear"
                    puts "#{selection} is not a valid input"
                    entry_submenu(entry)
            end
        end
        def delete_entry(entry)
            address_book.entries.delete(entry)
            puts "#{entry.name} has been deleted"
        end
        def edit_entry(entry)
            print "Updated name: "
            name = gets.chomp
            print "Updated phone number: "
            phone_number = gets.chomp
            print "Updated email: "
            email = gets.chomp
            # sets attributes to entry only if the attribute read is valid 
            entry.name = name if !name.empty?
            entry.phone_number = phone_number if !phone_number.empty?
            entry.email = email if !email.empty?
            system "clear"
            puts "Updated entry:"
            puts entry
        end
        def search_submenu(entry)
            # #12
            puts "\nd - delete entry"
            puts "e - edit this entry"
            puts "m - return to main menu"
            # #13
            selection = gets.chomp
 
            # #14
            case selection
                when "d"
                    system "clear"
                    delete_entry(entry)
                    main_menu
                when "e"
                    edit_entry(entry)
                    system "clear"
                    main_menu
                when "m"
                    system "clear"
                    main_menu
                else
                    system "clear"
                    puts "#{selection} is not a valid input"
                    puts entry.to_s
                    search_submenu(entry)
            end
        end
end