class RightInput
  YES_NO = ['y','n']
  def self.yes_or_no
    choice = gets.chomp.downcase
    unless YES_NO.include?(choice)
      puts 'press y to split, press n to keep your hand'
      return yes_or_no
    end
    choice
  end
end
