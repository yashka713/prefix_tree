load 'tree.rb'
require 'byebug'

menu = [
  'Choose what to do:', '1. Add word.', '2. Check, is this word in the tree?',
  '3. Show list of words from Tree.', '4. Exit.'
]

trie = Trie.new
loop do
  menu.each { |item| puts item }
  case gets.chomp
  when '1'
    puts 'Please, write the word(without whitespaces):'

  when '2'
    puts 'Please, write the word(without whitespaces):'

  when '3'
    trie.list
  when '4'
    puts 'Bye'
    break
  else
    puts 'That\'s not menu item'
  end
end
