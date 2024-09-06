# name: custom-webhook-with-email
# about: Adds user email to the webhook payload
# version: 0.1
# authors: TuanHA

# after_initialize do
#   # Custom webhook modification
#   DiscourseEvent.on(:post_created) do |event|
#     # Assuming event contains the user's ID
#     if event[:user_id]
#       user = User.find_by(id: event[:user_id])
#       if user
#         event[:user_email] = user.email
#       end
#     end
#   end
# end

after_initialize do
  # Extend the WebHookPostView to include the user's email in the payload
  module ::CustomWebHookExtension
    def email
      object.user.email
    end
  end

  # Add the email field to the webhook post payload
  add_to_serializer(:web_hook_post, :user_email) do
    object.user.email if object.user
  end
end
