require_relative 'spec_helper'

describe 'TreeNode' do
  let(:tree_node) { TreeNode.new('a') }

  it 'create TreeNode' do
    tree_node.must_be_instance_of TreeNode
    assert_equal(tree_node.instance_variable_get(:@char), 'a')
  end

  it 'should not create TreeNode for digit letter' do
    err = -> { TreeNode.new }.must_raise ArgumentError
    err.message.must_match 'wrong number of arguments'
  end
end

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

describe 'Adding new word to Tree' do
  let(:tree) { Tree.new }
  let(:first_branch) do
    mother_node = tree.instance_variable_get(:@node).instance_variable_get(:@children).first
    find_my_first_branch(mother_node, '')
  end

  it 'should add new word to Tree' do
    assert_equal(tree.add('qwerty'), 'qwerty added to Tree')
    assert_equal('qwerty', first_branch)
  end

  it 'should remove all digits and add new word to Tree' do
    assert_equal(tree.add('213132qwe323212131rty1112131'), 'qwerty added to Tree')
    assert_equal('qwerty', first_branch)
  end

  it 'should remove all whitespaces and add new word to Tree' do
    assert_equal(tree.add(' q w er t y '), 'qwerty added to Tree')
    assert_equal('qwerty', first_branch)
  end

  it 'should remove all special symbols and add new word to Tree' do
    assert_equal(tree.add('/q*w-e+r[t}y&'), 'qwerty added to Tree')
    assert_equal('qwerty', first_branch)
  end
end
