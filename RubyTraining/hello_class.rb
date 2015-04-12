class Hello
  attr_reader :name
#  attr_writer :name # allows write
#  attr_accessor :name # allows read, write

  def initialize ( myname = "Ruby" )
    @name = myname
  end

  # instance method
  def hello
    puts @name
  end

  # class method
  def Hello.classHello
    puts "CLASS HELLO!!!"
  end
end

test = Hello.new( "Hoge" )
test.hello()
# test.name = "aaa" # error

Hello.classHello()
