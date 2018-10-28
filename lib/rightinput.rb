class RightInput
  YES_NO = ['y','n']
  def self.yes_or_no
    choice = gets.chomp.downcase
    return choice if YES_NO.include?(choice)
    puts 'press y to split, press n to keep your hand'
    yes_or_no
  end
end
