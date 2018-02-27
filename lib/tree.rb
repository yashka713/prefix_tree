require_relative 'tree_node.rb'

class Tree
  FILE_PATH = 'data/'.freeze

  def initialize
    @node = TreeNode.new('*')
  end

  def add(word)
    word = word.delete('^a-zA-Z')
    return 'Fill line with word, please' if word.empty?
    branch = @node
    word.chars.each { |letter| branch = find_or_create_sprout(branch, letter) }
    branch.leaf = true
  end

  def includes?(word)
    branch = @node
    word.delete('^a-zA-Z').chars.all? { |letter| branch = find_sprout(branch, letter) } && branch.leaf
  end

  def list
    perform_list(@node, '', [])
  end

  def save_to_file(filename = 'words.txt')
    File.open(file_path(filename), 'w') { |f| list.each { |word| f.puts(word) } }
    check_file_size(filename)
  rescue IOError
    false
  end

  def load_from_file(filename = 'words.txt')
    File.open(file_path(filename), 'r').each_line { |word| add(word) }
    check_file_size(filename)
  rescue Errno::ENOENT
    false
  rescue IOError
    false
  end

  private

  def check_file_size(filename)
    File.size(file_path(filename)).to_f.zero? ? '' : true
  end

  def file_path(filename)
    Dir.mkdir('data') unless File.exist?(FILE_PATH)
    File.join(FILE_PATH, filename)
  end

  def perform_list(node, temp_str, tree)
    temp_str += node.char unless node == @node
    tree << temp_str if node.leaf
    node.children.each { |child_node| perform_list(child_node, temp_str, tree) }
    tree
  end

  def find_or_create_sprout(branch, letter)
    find_sprout(branch, letter) || create_sprout(branch, letter)
  end

  def find_sprout(branch, letter)
    branch.children.find { |node| node.char == letter }
  end

  def create_sprout(branch, letter)
    sprout = TreeNode.new(letter)
    branch.children << sprout
    sprout
  end
end
