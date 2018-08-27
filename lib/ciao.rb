
class Message
  attr_accessor :name
  def initialize(name='hermano')
    @name = name
  end
  def cambia(arg)
    @name = arg
  end
end

def bet_inputv2
  $bet_usr_inp = Integer(gets.chomp) rescue false
  if $bet_usr_inp == false
    raise ArgumentError.new ('bet must be an integer, please try again')
    $bet_inputv2
  else
    puts 'correct'
  end
end
