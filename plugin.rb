# name: custom-webhook-with-email
# about: Adds user email to the webhook payload
# version: 0.1
# authors: TuanHA

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
  

#   # Modify the WebHookPostView to include the mentioned user's email in the payload
#   add_to_class(:web_hook_post_view, :payload) do
#     # Call the original payload method to get the default payload
#     data = super()

#     # Extract post content from the payload
#     if post = data[:post]
#       # Extract mentioned usernames from the post content
#       mentioned_usernames = post[:raw].scan(/@([\w\-]+)/).flatten

#       # For each mentioned username, find the user and add their info to the payload
#       mentioned_usernames.each do |username|
#         user = User.find_by(username: username)
        
#         if user
#           # Append the mentioned user's ID and email to the payload
#           data[:mentioned_users] ||= []
#           data[:mentioned_users] << {
#             user_id: user.id,
#             username: user.username,
#             email: user.email
#           }
#         end
#       end
#     end

#     # Return the modified payload
#     data
#   end  
end
