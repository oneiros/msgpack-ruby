module MessagePack
  def load(src, param = nil)
    unpacker = nil

    if src.is_a? String
      unpacker = DefaultFactory.unpacker param
      unpacker.feed src
    else
      unpacker = DefaultFactory.unpacker src, param
    end

    unpacker.full_unpack
  end
  alias :unpack :load

  module_function :load
  module_function :unpack

  def pack(v, *rest)
    packer = DefaultFactory.packer(*rest)
    packer.write v
    packer.full_pack
  end
  alias :dump :pack

  module_function :pack
  module_function :dump
end

module MessagePack
  module CoreExt
    def to_msgpack(packer_or_io = nil)
      if packer_or_io
        if packer_or_io.is_a?(MessagePack::Packer)
          _to_msgpack packer_or_io
        else
          MessagePack.pack(self, packer_or_io)
        end
      else
        MessagePack.pack(self)
      end
    end
  end
end

class NilClass
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_nil
    packer
  end
end

class TrueClass
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_true
    packer
  end
end

class FalseClass
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_false
    packer
  end
end

class Float
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_float self
    packer
  end
end

class String
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_string self
    packer
  end
end

class Array
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_array self
    packer
  end
end

class Hash
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_hash self
    packer
  end
end

class Symbol
  include MessagePack::CoreExt

  def _to_msgpack(packer)
    packer.write_symbol self
    packer
  end
end

if 1.class.name == "Integer"
  class Integer
    include MessagePack::CoreExt

    def _to_msgpack(packer)
      packer.write_int self
      packer
    end
  end
else
  class Fixnum
    include MessagePack::CoreExt

    def _to_msgpack(packer)
      packer.write_int self
      packer
    end
  end

  class Bignum
    include MessagePack::CoreExt

    def _to_msgpack(packer)
      packer.write_int self
      packer
    end
  end
end

module MessagePack
  DefaultFactory = MessagePack::Factory.new

  class ExtensionValue
    include CoreExt

    def _to_msgpack(packer)
      packer.write_extension self
      packer
    end
  end
end
