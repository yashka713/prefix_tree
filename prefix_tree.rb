require_relative 'lib/tree.rb'
require 'byebug'

menu = [
  'Choose what to do:', '1. Add word.', '2. Check, is this word in the tree?',
  '3. Show list of words from Tree.', '4. Save to file', '5. Load from file', '6. Exit.'
]

tree = Tree.new
loop do
  print `clear`
  menu.each { |item| puts item }
  case gets.chomp
  when '1'
    puts 'Please, write the word(without whitespaces):'
    puts tree.add(gets.chomp)
  when '2'
    puts 'Please, write the word(without whitespaces):'
    puts tree.includes?(gets.chomp)
  when '3'
    puts 'List of words in tree:'
    puts tree.list
  when '4'
    puts tree.save_to_file
  when '5'
    puts tree.load_from_file
  when '6'
    puts 'Bye'
    break
  else
    puts 'That\'s not menu item'
  end
  sleep(5)
end
