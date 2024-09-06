# name: custom-webhook-with-email
# about: Adds user email to the webhook payload
# version: 0.1
# authors: TuanHA

after_initialize do
  # Custom webhook modification
  DiscourseEvent.on(:post_created) do |event|
    # Assuming event contains the user's ID
    if event[:user_id]
      user = User.find_by(id: event[:user_id])
      if user
        event[:user_email] = user.email
      end
    end
  end
end
