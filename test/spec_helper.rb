require 'minitest/autorun'
require 'byebug'
load 'tree_node.rb'
load 'tree.rb'

WORDS = %w[cat cop cup can call chat chart clap cost].freeze

def feel_tree(tree)
  WORDS.each { |word| tree.add(word) }
  tree
end

def find_my_first_branch(node, str)
  str << node.char
  return str if node.leaf
  find_my_first_branch(node.children.first, str)
end
