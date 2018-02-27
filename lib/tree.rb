require_relative 'tree_node.rb'

class Tree
  FILE_PATH = 'data'.freeze
  FILE_NAME = 'words.txt'.freeze
  ARCHIVE_NAME = 'words.zip'.freeze

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

  def save_to_file(filename = FILE_NAME)
    File.open(file_path(filename), 'w') { |f| list.each { |word| f.puts(word) } }
    check_file_size(filename)
  rescue IOError
    false
  end

  def load_from_file(filename = FILE_NAME)
    File.open(file_path(filename), 'r').each_line { |word| add(word) }
    check_file_size(filename)
  rescue Errno::ENOENT
    false
  rescue IOError
    false
  end

  def save_to_zip_file(archive = ARCHIVE_NAME)
    delete_file(archive)
    pack_file(archive)
  end

  def load_from_zip_file(archive = ARCHIVE_NAME)
    unpack_and_load(archive)
  end

  private

  def unpack_and_load(archive)
    temp_file = "temp_#{FILE_NAME}"
    Zip::File.open(full_path_to_file(archive)) { |file| file.extract(FILE_NAME, full_path_to_file(temp_file)) }
    load_from_file(temp_file)
    !delete_file(temp_file).nil?
  rescue Zip::Error
    false
  end

  def delete_file(file)
    File.delete(full_path_to_file(file)) if File.exist?(full_path_to_file(file))
  end

  def pack_file(archive)
    temp_file = "temp_#{FILE_NAME}"
    save_to_file(temp_file)
    Zip::File.open(full_path_to_file(archive), Zip::File::CREATE) do |file|
      file.add(temp_file.gsub(/temp_/, ''), full_path_to_file(temp_file))
    end
    !delete_file(temp_file).nil?
  rescue Zip::DestinationFileExistsError
    false
  end

  def full_path_to_file(filename)
    File.join(FILE_PATH, filename)
  end

  def check_file_size(filename)
    File.size(file_path(filename)).to_f.zero? ? '' : true
  end

  def file_path(filename)
    Dir.mkdir('data') unless File.exist?(FILE_PATH)
    full_path_to_file(filename)
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
