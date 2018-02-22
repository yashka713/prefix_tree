require 'minitest/autorun'
require 'byebug'
load 'tree_node.rb'
load 'tree.rb'

def find_my_first_branch(node, str)
  str << node.char
  return str if node.leaf
  find_my_first_branch(node.children.first, str)
end
