module Mastermind
  class Resource
    include Mixin::Attributes
    include Mixin::Resources

    attr_accessor :provider
    attr_reader :not_if_args
    attr_reader :only_if_args
    
    attribute :action, Symbol
    attribute :name, String, :required => true
    
    default_action :nothing
        
    def initialize(args={})
      @not_if = nil
      @not_if_args = {}
      @only_if = nil
      @only_if_args = {}
      super(args)
    end
    
    def execute(action)
      if self.valid?
        begin
          if only_if
            unless execute_only_if(only_if, only_if_args)
              Mastermind::Log.info "Skipping #{self} due to only_if"
              return
            end
          end
          
          if not_if
            unless execute_not_if(not_if, not_if_args)
              Mastermind::Log.info "Skipping #{self} due to not_if"
              return
            end
          end
          
          provider = self.class.provider.new(self)
          provider.send(action)
          if success
            success.call
          end
          @successful = true
        rescue => e
          Mastermind::Log.error e.inspect
          if failure
            failure.call
          end
          @successful = false
        end
        
      else
        Mastermind::Log.error self.errors.full_messages.join(", ")
        raise ValidationError, self.errors.full_messages.join(", ")
      end
    end
    
    def success(&block)
      @success = block if block_given?
      return @success
    end
    
    def failure(&block)
      @failure = block if block_given?
      return @failure
    end

    # not_if / only_if lovingly stolen from Chef. <3 Opscode cowboys.
    def not_if(arg=nil, args={}, &block)
      if block_given?
        @not_if = block
        @not_if_args = args
      else
        @not_if = arg if arg
        @not_if_args = args
      end
      return @not_if
    end
    
    def only_if(arg=nil, args={}, &block)
      if block_given?
        @only_if = block
        @only_if_args = args
      else
        @only_if = arg if arg
        @only_if_args = args
      end
      return @only_if
    end
    
    def to_s
      "#{resource_name}[#{name}]"
    end
  end
end

class Mastermind::Resource::ValidationError < StandardError; end