require 'minitest/autorun'
require 'byebug'
load 'lib/tree_node.rb'
load 'lib/tree.rb'
require 'zip'

def find_first_word_in_tree(node, str)
  str << node.char
  return str if node.leaf
  find_first_word_in_tree(node.children.first, str)
end

TEST_FOLDER_PATH = File.join('test', 'support')

Dir.mkdir('data') unless File.exist?('data')
Dir.mkdir(TEST_FOLDER_PATH) unless File.exist?(TEST_FOLDER_PATH)
# redefine Tree::FILE_PATH
Tree.send(:remove_const, :FILE_PATH)
Tree.const_set(:FILE_PATH, TEST_FOLDER_PATH)
