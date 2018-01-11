require_relative 'controllers/menu_controller.rb'
# creates a new menu when address bloc starts
menu = MenuController.new

# clears the comman line
system "clear"
puts "Welcome to Address Bloc!"

# displays the menu
menu.main_menu