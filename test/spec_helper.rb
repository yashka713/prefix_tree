require 'minitest/autorun'
require 'byebug'
load 'lib/tree_node.rb'
load 'lib/tree.rb'

def find_first_word_in_tree(node, str)
  str << node.char
  return str if node.leaf
  find_first_word_in_tree(node.children.first, str)
end

TEST_FOLDER_PATH = File.join('data', 'test')

Dir.mkdir('data') unless File.exist?('data')
Dir.mkdir(TEST_FOLDER_PATH) unless File.exist?(TEST_FOLDER_PATH)
