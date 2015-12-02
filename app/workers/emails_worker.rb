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

    opt = {}
    @email["to"][0]["email"]  ? opt[:to]        = @email["to"][0]["email"] : ''
    @email["from"]["email"]   ? opt[:from]      = @email["from"]["email"] : ''
    @email["subject"]         ? opt[:subject]   = @email["subject"] : ''
    @email["raw_text"]        ? opt[:raw_text]  = @email["raw_text"] : ''
    @email["raw_html"]        ? opt[:raw_html]  = @email["raw_html"] : ''
    @email["raw_body"]        ? opt[:raw_body]  = @email["raw_body"] : ''
    @email["body"]            ? opt[:body]      = @email["body"] : ''

    newsletter = Newsletter.find_by_email(@email["to"][0]["token"])
    if !newsletter.nil?
      Email.create(opt)
    else
      UnknownEmail.create(opt)
    end
    ack! # we need to let queue know that message was received
  end
end
