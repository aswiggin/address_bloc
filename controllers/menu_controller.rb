# connect to address_book to use variables
require_relative '../models/address_book.rb'

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
        puts "5 - View entry number n"
        puts "6 - Exit"
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
            when 5 
                system "clear"
                entry_n_submenu
                main_menu
            # end the program with no errors    
            when 6
                puts "Good-bye!"
                exit(0)
            #catches invalid user input
            else 
                system "clear"
                puts "Sorry, that is not a valid input"
                main_menu
        end
    end
    
        def entry_n_submenu
            puts "Entry number wanted: "
            selection = gets.chomp.to_i
            
            if selection < address_book.entries.count
                puts address_book.entries(selection)
                puts "Press enter to return to the main menu"
                gets.chomp
                system "clear"
            else 
                puts "#{selection} is not valid"
                entry_n_submenu
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
        end
        def read_CSV
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
                when "e"
                when "m"
                    system "clear"
                    main_menu
                else 
                    system "clear"
                    puts "#{selection} is not a valid input"
                    entry_submenu(entry)
            end
        end
end