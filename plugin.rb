# name: custom-webhook-with-email-and-username
# about: Adds user email and username to the webhook payload
# version: 0.2
# authors: TuanHA

after_initialize do
  # Add the email and username fields to the webhook post payload
  add_to_serializer(:web_hook_post, :post_user_email) do
    object.user.email if object.user
  end
  
  add_to_serializer(:web_hook_post, :post_user_username) do
    object.user.username if object.user
  end

  # Add the email and username fields to the notification webhook payload
  add_to_serializer(:notification, :notified_user_email) do
    user = User.find_by(id: object[:user_id])
    user&.email
  end

  add_to_serializer(:notification, :notified_user_username) do
    user = User.find_by(id: object[:user_id])
    user&.username
  end

  # Add the base URL to all webhook payloads, regardless of type
  add_to_serializer(:application, :site_url) do
    Discourse.base_url
  end
end
