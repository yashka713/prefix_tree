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
