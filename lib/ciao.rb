
class Message
  attr_accessor :name
  def initialize(name='hermano')
    @name = name
  end
  def cambia(arg)
    @name = arg
  end
end
