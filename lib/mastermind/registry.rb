module Mastermind
  module Registry
    @providers = Hash.new
    @resources = Hash.new
    
    class << self
      attr_accessor :providers, :resources
    end
    
  end
end