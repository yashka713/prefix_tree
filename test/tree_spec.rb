require_relative 'spec_helper'

describe 'Tree' do
  let(:tree) { Tree.new }
  let(:words) { %w[cat cop cup can call chat chart clap cost let letter console content contract] }
  let(:filled_tree) do
    tree = Tree.new
    words.each { |word| tree.add(word) }
    tree
  end
  let(:first_branch) do
    mother_node = filled_tree.instance_variable_get(:@node).instance_variable_get(:@children).first
    find_first_word_in_tree(mother_node, '')
  end
  let(:file_spec) { File.join('test', 'words_spec.txt')}
  let(:file_spec_path) { File.join(TEST_FOLDER_PATH, 'words_spec.txt')}

  it 'create Tree' do
    tree.must_be_instance_of Tree
    tree.instance_variable_get(:@node).must_be_instance_of TreeNode
    assert_equal(tree.instance_variable_get(:@node).instance_variable_get(:@char), '*')
  end

  it 'should not create Tree' do
    err = -> { Tree.new('qwerty') }.must_raise ArgumentError
    err.message.must_match 'wrong number of arguments'
  end

  describe '#add' do
    let(:first_branch) do
      mother_node = tree.instance_variable_get(:@node).instance_variable_get(:@children).first
      find_first_word_in_tree(mother_node, '')
    end

    it 'when letter string' do
      assert_equal(tree.add('qwerty'), true)
      assert_equal('qwerty', first_branch)
    end

    it 'when digits present' do
      assert_equal(tree.add('213132qwe323212131rty1112131'), true)
      assert_equal('qwerty', first_branch)
    end

    it 'when whitespaces present' do
      assert_equal(tree.add(' q w er t y '), true)
      assert_equal('qwerty', first_branch)
    end

    it 'when special symbols present' do
      assert_equal(tree.add('/q*w-e+r[t}y&'), true)
      assert_equal('qwerty', first_branch)
    end
  end

  describe '#includes?' do
    it 'find word' do
      words.each { |word| filled_tree.includes?(word).must_equal true }
      assert_equal('cat', first_branch)
    end

    it 'doesn\'t find word' do
      %w[pop push fat group track].each { |word| filled_tree.includes?(word).must_equal false }
    end
  end

  describe '#list' do
    it 'when empty' do
      assert_equal(tree.list.class, Array)
      assert_equal(tree.list.size, 0)
    end

    it 'when filled' do
      assert_equal(tree.list.class, Array)
      assert_equal(filled_tree.list.size, words.size)
      filled_tree.list.each { |word| filled_tree.includes?(word).must_equal true }
      assert_equal('cat', first_branch)
    end
  end

  describe '#save_to_file' do

    it 'when list is empty' do
      assert_equal(true, tree.list.empty?)
      tree.save_to_file(file_spec).must_match ''
    end

    it 'when list is filled' do
      assert_equal(filled_tree.list.size, words.size)
      assert_equal(true, filled_tree.save_to_file(file_spec))
      assert_equal(true, File.exist?(file_spec_path))
      assert_equal(false, File.size(file_spec_path).to_f.zero?)
    end
  end

  describe '#load_from_file' do
    let(:unexisted_file) { File.join(TEST_FOLDER_PATH, '/unexisted_words_spec.txt') }
    let(:file_empty_spec) do
      File.new(File.join(TEST_FOLDER_PATH, 'file_empty_spec.txt'), 'w')
      File.join(TEST_FOLDER_PATH, 'file_empty_spec.txt')
    end

    it 'when file is absent' do
      assert_equal(false, File.exist?(unexisted_file))
      assert_equal(false, tree.load_from_file(unexisted_file))
    end

    it 'when file is empty' do
      assert_equal(true, File.exist?(file_empty_spec))
      assert_equal(false, tree.load_from_file(file_empty_spec))
    end

    it 'when file is exist' do
      filled_tree.save_to_file(file_spec)
      assert_equal(true, File.exist?(file_spec_path))
      assert_equal(true, tree.load_from_file(file_spec))
      tree.list.each { |word| tree.includes?(word).must_equal true }
      assert_equal('cat', first_branch)
    end
  end
end
