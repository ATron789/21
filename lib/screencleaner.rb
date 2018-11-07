require 'pry'

class Screen
  def self.cleaner
    return if ENV["RUBY_ENV"] == "test"
    puts 'press any key to continue'
    system 'clear' if gets
  end

  def self.next
    return if ENV["RUBY_ENV"] == "test"
    puts 'press any key to continue'
    puts
    gets
  end
end
