# name: custom-webhook-with-email
# about: Adds user email to the webhook payload
# version: 0.1
# authors: TuanHA

after_initialize do
    # Custom webhook modification
    DiscourseEvent.on(:webhook_event_type) do |event|
      # Modify payload to include user's email
      if event[:user_id]
        user = User.find(event[:user_id])
        event[:user_email] = user.email if user
      end
    end
  end