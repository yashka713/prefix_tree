require 'minitest/autorun'
require 'byebug'
load 'lib/tree_node.rb'
load 'lib/tree.rb'

def find_first_word_in_tree(node, str)
  str << node.char
  return str if node.leaf
  find_first_word_in_tree(node.children.first, str)
end
