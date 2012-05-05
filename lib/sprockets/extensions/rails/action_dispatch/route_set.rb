module ActionDispatch
  module Routing
    class RouteSet #:nodoc:

      def initialize_with_prepends(*args)
        @append = []
        @prepend = []
        initialize_without_prepends(*args)
      end

      alias_method_chain :initialize, :prepends

      def append(&block)
        @append << block
      end

      def prepend(&block)
        @prepend << block
      end

      def finalize!
        return if @finalized
        @append.each { |blk| eval_block(blk) }
        @finalized = true
        @append = []
        @prepend = []
        @set.freeze
      end

      def clear_with_prepends!(*args)
        clear_without_prepends!(*args)
        @prepend.each { |blk| eval_block(blk) }
      end
      alias_method_chain :clear!, :prepends

      def eval_block(block)
        mapper = Mapper.new(self)
        if block.arity == 1
          mapper.instance_exec(DeprecatedMapper.new(self), &block)
        else
          mapper.instance_exec(&block)
        end
      end
    end
  end
end
