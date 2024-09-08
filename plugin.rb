# name: custom-webhook-with-email
# about: Adds user email to the webhook payload
# version: 0.1
# authors: TuanHA

after_initialize do
  # Add the email field to the webhook post payload
  add_to_serializer(:web_hook_post, :post_user_email) do
    object.user.email if object.user
  end

  # Add the email field to the notification webhook payload
  #add_to_serializer(:notification, :user_email) do
  #  user = User.find_by(id: object.notification[:user_id])
  #  user.email if user
  # end

  add_to_serializer(:notification, :notified_user_email) do
    #Rails.logger.info("Notification Object: #{object.inspect}")
    user = User.find_by(id: object[:user_id])
    if user
      #Rails.logger.info("User Object: #{user.inspect}")
      user.email
    else
      #Rails.logger.warn("No user found for Notification.")
      nil
    end
  end
  
  # Add the base URL to all webhook payloads, regardless of type
  add_to_serializer(:web_hook_event, :site_url) do
    Discourse.base_url
  end

end

