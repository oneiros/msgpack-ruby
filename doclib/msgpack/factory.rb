module MessagePack
  #
  # MessagePack::Factory is a class to generate Packer and Unpacker which has
  # same set of ext types.
  #
  class Factory
    #
    # Creates a MessagePack::Factory instance
    #
    def initialize
    end

    #
    # Creates a MessagePack::Packer instance, which has ext types already registered.
    # Options are passed to MessagePack::Packer#initialized.
    #
    # See also Packer#initialize for options.
    #
    def packer(*args)
    end

    #
    # Serialize the passed value
    #
    # If it could not serialize the object, it raises
    # NoMethodError: undefined method `to_msgpack' for #<the_object>.
    #
    # @param obj [Object] object to serialize
    # @param options [Hash]
    # @return [String] serialized object
    #
    # See Packer#initialize for supported options.
    #
    def dump(obj, options=nil)
    end
    alias pack dump

    #
    # Creates a MessagePack::Unpacker instance, which has ext types already registered.
    # Options are passed to MessagePack::Unpacker#initialized.
    #
    # See also Unpacker#initialize for options.
    #
    def unpacker(*args)
    end

    #
    # Deserializes an object from the string or io and returns it.
    #
    # If there're not enough data to deserialize one object, this method raises EOFError.
    # If data format is invalid, this method raises MessagePack::MalformedFormatError.
    # If the object nests too deeply, this method raises MessagePack::StackError.
    #
    # @param data [String]
    # @param options [Hash]
    # @return [Object] deserialized object
    #
    # See Unpacker#initialize for supported options.
    #
    def load(data, options=nil)
    end
    alias unpack load

    #
    # Register a type and Class to be registered for packer and/or unpacker.
    # If options are not specified, factory will use :to_msgpack_ext for packer, and
    # :from_msgpack_ext for unpacker.
    #
    # @param type [Fixnum] type id of registered Class (0-127)
    # @param klass [Class] Class to be associated with type id
    # @param options [Hash] specify method name or Proc which are used by packer/unpacker
    # @return nil
    #
    # Supported options:
    #
    # * *:packer* specify symbol or proc object for packer
    # * *:unpacker* specify symbol or proc object for unpacker
    # * *:optimized_symbols_parsing* specify true to use the optimized symbols parsing (not supported on JRuby now)
    #
    def register_type(type, klass, options={})
    end

    #
    # Returns a list of registered types, ordered by type id.
    #
    # @param selector [Symbol] specify to list types registered for :packer, :unpacker or :both (default)
    # @return Array
    #
    def registered_types(selector=:both)
    end

    #
    # Returns true/false which indicate specified class or type id is registered or not.
    #
    # @param klass_or_type [Class or Fixnum] Class or type id (0-127) to be checked
    # @param selector [Symbol] specify to check for :packer, :unpacker or :both (default)
    # @return true or false
    #
    def type_registered?(klass_or_type, selector=:both)
    end

    #
    # Creates a MessagePack::PooledFactory instance of the given size.
    #
    # PooledFactory keeps Packer and Unpacker instance in a pool for improved performance.
    # Note that the size defines how many instances are kept in cache, not the maximum of instances
    # that can be created. If the pool limit is reached, a new instance is created anyway.
    #
    # @param size [Fixnum] specify how many Packer and Unpacker to keep in cache (default 1)
    # @param options [Hash] Combined options for Packer and Unpacker. See Packer#initialize and Unpacker#initialize
    #                       for supported options.
    def pool(size=1, **options)
    end

    class Pool
      #
      # Deserializes an object from the string or io and returns it.
      #
      # If there're not enough data to deserialize one object, this method raises EOFError.
      # If data format is invalid, this method raises MessagePack::MalformedFormatError.
      # If the object nests too deeply, this method raises MessagePack::StackError.
      #
      # @param data [String]
      # @return [Object] deserialized object
      #
      # See Unpacker#initialize for supported options.
      #
      def load(data)
      end

      #
      # Serialize the passed value
      #
      # If it could not serialize the object, it raises
      # NoMethodError: undefined method `to_msgpack' for #<the_object>.
      #
      # @param obj [Object] object to serialize
      # @return [String] serialized object
      #
      def dump(object)
      end
    end
  end
end
