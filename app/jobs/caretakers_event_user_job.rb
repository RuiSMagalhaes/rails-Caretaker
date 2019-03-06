class CaretakersEventUserJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    puts "lalalla"
    puts id
  end
end
