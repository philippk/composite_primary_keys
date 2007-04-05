require 'abstract_unit'
require 'fixtures/reference_type'
require 'fixtures/reference_code'

class CloneTest < Test::Unit::TestCase

  CLASSES = {
    :single => {
      :class => ReferenceType,
      :primary_keys => :reference_type_id,
    },
    :dual   => { 
      :class => ReferenceCode,
      :primary_keys => [:reference_type_id, :reference_code],
    },
  }
  
  def setup
    create_fixtures :reference_types, :reference_codes
    self.class.classes = CLASSES
  end
  
  def test_truth
    testing_with do
      clone = @first.clone
      assert_equal @first.attributes.block(@klass.primary_key), clone.attributes
      if composite?
        @klass.primary_key.each {|key| assert_nil clone[key], "Primary key '#{key}' should be nil"} 
      else
        assert_nil clone[@klass.primary_key], "Sole primary key should be nil"
      end
    end
  end
end