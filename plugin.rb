# name: custom-webhook-with-email
# about: Adds user email to the webhook payload
# version: 0.1
# authors: TuanHA

#after_initialize do
  # Extend the WebHookPostView to include the user's email in the payload
#  module ::CustomWebHookExtension
#    def email
#      object.user.email
#    end
#  end

# Add the email field to the webhook post payload
add_to_serializer(:web_hook_post, :user_email) do
  object.user.email if object.user
end
after_initialize do
  # Add the email field to the notification webhook payload
  add_to_serializer(:notification, :user_email) do
    user = User.find_by(id: object.notification[:user_id])
    user.email if user
  end
end

