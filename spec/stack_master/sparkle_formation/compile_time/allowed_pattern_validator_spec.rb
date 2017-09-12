RSpec.describe StackMaster::SparkleFormation::CompileTime::AllowedPatternValidator do

  describe '#validate' do
    let(:name) { 'name' }
    let(:error_message) { -> (error, definition) { "#{name}:#{error} does not match allowed_pattern:#{definition[:allowed_pattern]}" } }

    context 'string validation' do
      let(:definition) { {type: :string, allowed_pattern: '^a'} }

      include_examples 'validate valid parameter', 'a'
      include_examples 'validate valid parameter', ['a']
      include_examples 'validate invalid parameter', 'b', ['b']
    end

    context 'numerical validation' do
      let(:definition) { {type: :number, allowed_pattern: '^1'} }

      include_examples 'validate valid parameter', 1
      include_examples 'validate valid parameter', '1'
      include_examples 'validate valid parameter', [1]
      include_examples 'validate valid parameter', ['1']

      include_examples 'validate invalid parameter', 2, [2]
      include_examples 'validate invalid parameter', '2', ['2']
      include_examples 'validate invalid parameter', '2', ['2']
    end

    context 'validation with default value' do
      let(:definition) { {type: :number, allowed_pattern: '^1', default: '1'} }
      include_examples 'validate valid parameter', nil
    end
  end
end