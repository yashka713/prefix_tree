class Tree
  def initialize
    @node = TreeNode.new('*')
  end

  def add(word)
    word = word.delete('^a-zA-Z')
    return msg_for_empty_word if word.empty?
    branch = @node
    word.chars.each { |letter| branch = find_or_create_sprout(branch, letter) }
    branch.leaf = true
    "#{word} added to Tree"
  end

  private

  def msg_for_empty_word
    'Fill line with word, please'
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
