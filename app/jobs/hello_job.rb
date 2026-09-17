class HelloJob < ApplicationJob
  queue_as :default

  def perform(name)
    puts "Hello from the background job! #{name}"
  end
end
