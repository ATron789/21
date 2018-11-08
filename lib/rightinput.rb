class RightInput
  YES_NO = ['y','n']
  HIT_STAND = ['h', 's']
  CONFIG = {YES_NO: ['y','n'], HIT_STAND: ['h', 's'] }
  def self.yes_or_no
    choice = gets.chomp.downcase
    return choice if CONFIG[:YES_NO].include?(choice)
    puts 'Wrong input. Please press y to split or n to keep your hand'
    yes_or_no
  end
  def self.hit_stand
    choice = gets.chomp.downcase
    return choice if CONFIG[:HIT_STAND].include?(choice)
    puts 'Wrong input. Please press h to hit or s to stand'
    hit_stand
  end
end
#do it for hit and stands
#check the press to continue, some times is double
