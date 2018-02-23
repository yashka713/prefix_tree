require_relative 'spec_helper'

describe 'Tree' do
  let(:tree) { Tree.new }

  it 'create Tree' do
    tree.must_be_instance_of Tree
    tree.instance_variable_get(:@node).must_be_instance_of TreeNode
    assert_equal(tree.instance_variable_get(:@node).instance_variable_get(:@char), '*')
  end

  it 'should not create Tree' do
    err = -> { Tree.new('qwerty') }.must_raise ArgumentError
    err.message.must_match 'wrong number of arguments'
  end
end

describe '#add' do
  let(:tree) { Tree.new }
  let(:first_branch) do
    mother_node = tree.instance_variable_get(:@node).instance_variable_get(:@children).first
    find_my_first_branch(mother_node, '')
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

describe '#list' do
  let(:empty_tree) { Tree.new }
  let(:full_tree) do
    tree = Tree.new
    words.each { |word| tree.add(word) }
    tree
  end
  let(:words) { %w[let letter console content contract produce progress cot cop pain get set] }
  let(:first_branch) do
    mother_node = full_tree.instance_variable_get(:@node).instance_variable_get(:@children).first
    find_my_first_branch(mother_node, '')
  end

  it 'when empty' do
    empty_tree.list.must_match 'Tree is empty'
  end

  it 'when fulled' do
    assert_equal(full_tree.list.size, words.size)
    # full_tree.list.each { |word| full_tree.includes?(word).must_equal true }
    assert_equal('let', first_branch)
  end
end
