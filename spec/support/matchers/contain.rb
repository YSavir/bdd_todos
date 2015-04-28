RSpec::Matchers.define :contain do |expected|
  match do |actual|
    @actual_length == expected
  end.length
  chain :complete_todos do
    @type = 'complete todos'
    @actual_length = subject.select do |el|
      el['class'].match(/(\s|^)complete/)
    end.length
  end

  chain :incomplete_todos do
    @type = 'incomplete todos'
    @actual_length = subject.select do |el|
      el['class'].match(/(\s|^)incomplete/)
    end.length
  end

  failure_message do |actual|
    "expected to find #{expected} #{@type} but found #{@actual_todos.length} #{@type} instead"
  end

  description do
    "have #{expected} #{@type}"
  end
end

