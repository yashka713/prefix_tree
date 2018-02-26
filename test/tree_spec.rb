require_relative 'spec_helper'

describe 'Tree' do
  let(:tree) { Tree.new }
  let(:words) { %w[cat cop cup can call chat chart clap cost let letter console content contract] }

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
    let(:fill_tree) do
      tree = Tree.new
      words.each { |word| tree.add(word) }
      tree
    end
    let(:first_branch) do
      mother_node = fill_tree.instance_variable_get(:@node).instance_variable_get(:@children).first
      find_first_word_in_tree(mother_node, '')
    end

    it 'find word' do
      words.each { |word| fill_tree.includes?(word).must_equal true }
      assert_equal('cat', first_branch)
    end

    it 'doesn\'t find word' do
      %w[pop push fat group track].each { |word| fill_tree.includes?(word).must_equal false }
    end
  end

  describe '#list' do
    let(:fill_tree) do
      tree = Tree.new
      words.each { |word| tree.add(word) }
      tree
    end
    let(:first_branch) do
      mother_node = fill_tree.instance_variable_get(:@node).instance_variable_get(:@children).first
      find_first_word_in_tree(mother_node, '')
    end

    it 'when empty' do
      tree.list.must_match 'Tree is empty'
    end

    it 'when filled v_1' do
      assert_equal(fill_tree.list.size, words.size)
      fill_tree.list.each { |word| fill_tree.includes?(word).must_equal true }
      assert_equal('cat', first_branch)
    end

    it 'when filled v_2' do
      assert_equal(fill_tree.list.size, words.size)
      fill_tree.list_v_2.each { |word| fill_tree.includes?(word).must_equal true }
      assert_equal('cat', first_branch)
    end
  end
end
