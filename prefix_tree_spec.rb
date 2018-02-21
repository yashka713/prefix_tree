require 'minitest/autorun'
load 'tree_node.rb'
load 'tree.rb'

describe 'TreeNode' do
  it 'create TreeNode' do
    tree_node = TreeNode.new('a')
    tree_node.must_be_instance_of TreeNode
    assert_equal(tree_node.instance_variable_get(:@char), 'a')
  end

  it 'should not create TreeNode for digit letter' do
    err = -> { TreeNode.new }.must_raise ArgumentError
    err.message.must_match 'wrong number of arguments'
  end
end

describe 'Tree' do
  before do
    @tree = Tree.new
  end

  it 'create Tree' do
    @tree.must_be_instance_of Tree
    assert_equal(@tree.instance_variable_get(:@node).instance_variable_get(:@char), '*')
  end

  it 'should not create Tree' do
    err = -> { Tree.new('qwerty') }.must_raise ArgumentError
    err.message.must_match 'wrong number of arguments'
  end

  it 'should add new word to Tree' do
    assert_equal(@tree.add('qwerty'), 'qwerty')
    assert_equal(@tree.add('qwerty1'), 'qwerty')
    assert_equal(@tree.add('213132qwe323212131rty1112131'), 'qwerty')
    assert_equal(@tree.add('    2131    32q   we3232   12131rty111  2131'), 'qwerty')
    @tree.instance_variable_get(:@node).must_be_instance_of TreeNode
    assert_equal(@tree.instance_variable_get(:@node).instance_variable_get(:@char), '*')
  end
end
