require 'test_helper'

class MetaTagTest < ActiveSupport::TestCase
  # called before every single test
  def setup
    @tag = MetaTag.new(:name => 'somename')
    @tag.taggable_type = 'Category'
    @tag.taggable_id = 1
  end
  
  test "truth" do
    assert_kind_of Class, MetaTag
  end
  
  test 'should create new record with valid attributes' do
    @tag.save!
  end
  
  test 'should not be valid with empty name' do
    @tag.name = nil
    assert !@tag.valid?
  end
  
  test 'should not be valid with not uniq name' do
    @tag.update_attribute(:name, 'test')
    
    @next_tag = MetaTag.new(:name => 'test')
    @next_tag.taggable_type = 'Category'
    @next_tag.taggable_id = 1
    
    assert !@next_tag.valid?
  end
  
  test 'should be valid with not uniq name in other parent record' do
    @tag.update_attribute(:name, 'test')
    
    @next_tag = MetaTag.new(:name => 'test')
    @next_tag.taggable_type = 'Category'
    @next_tag.taggable_id = 2
    
    assert @next_tag.valid?
  end
end