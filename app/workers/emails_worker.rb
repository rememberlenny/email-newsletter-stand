class EmailsWorker
  include Sneakers::Worker
  # This worker will connect to "dashboard.posts" queue
  # env is set to nil since by default the actuall queue name would be
  # "dashboard.posts_development"
  from_queue "stand.emails", env: nil

  # work method receives message payload in raw format
  # in our case it is JSON encoded string
  # which we can pass to RecentPosts service without
  # changes
  def work(raw_post)
    @email = JSON.parse(email)
    newsletter = Newsletter.find_by_email(@email["to"][0]["token"])
    if !newsletter.nil?
    # pry
      Email.create(
        newsletter_id: newsletter.id,
        to: @email["to"][0]["email"],
        from: @email["from"]["email"],
        subject: @email["subject"],
        raw_text: @email["raw_text"],
        raw_html: @email["raw_html"],
        raw_body: @email["raw_body"],
        body: @email["body"]
      )
    # pry
    else
      UnknownEmail.create(
        to: @email["to"][0]["email"],
        from: @email["from"]["email"],
        subject: @email["subject"],
        raw_text: @email["raw_text"],
        raw_html: @email["raw_html"],
        raw_body: @email["raw_body"],
        body: @email["body"]
      )
    end
    ack! # we need to let queue know that message was received
  end
end
