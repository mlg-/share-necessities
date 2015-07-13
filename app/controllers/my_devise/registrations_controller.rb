# class MyDevise::RegistrationsController < Devise::RegistrationsController
#   def create
#     super
#     if resource.organizer?
#       @organizer = Organizer.new(user_id: resource.id)
#       @organizer.save
#     end
# end