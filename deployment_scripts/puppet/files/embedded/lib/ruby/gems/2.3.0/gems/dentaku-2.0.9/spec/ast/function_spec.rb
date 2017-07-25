require 'spec_helper'
require 'dentaku/ast/function'

describe Dentaku::AST::Function do
  it 'maintains a function registry' do
    expect(described_class).to respond_to(:get)
  end

  it 'raises an exception when trying to access an undefined function' do
    expect {
      described_class.get("flarble")
    }.to raise_error(Dentaku::ParseError, /undefined function/i)
  end

  it 'registers a custom function' do
    described_class.register("flarble", :string, -> { "flarble" })
    expect { described_class.get("flarble") }.not_to raise_error
    function = described_class.get("flarble").new
    expect(function.value).to eq "flarble"
  end
end
