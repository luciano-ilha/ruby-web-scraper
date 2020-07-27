require 'spec_helper'
require './lib/choice'

describe Choice do
  it 'Defines the user choice' do
    choice_test = Choice.new(200)
    expect(choice_test.choice).to eql 200
  end
end
