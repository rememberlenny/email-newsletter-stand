class EmailProcessor

  def process(email)
    @email = email
    newsletter = Newsletter.find_by_email(@email.to[0][:token])
    if !newsletter.nil?
    # pry
      Email.create(
        newsletter_id: newsletter.id,
        to: @email.to[0][:email],
        from: @email.from[:email],
        subject: @email.subject,
        raw_text: @email.raw_text,
        raw_html: @email.raw_html,
        raw_body: @email.raw_body,
        body: @email.body
      )
    # pry
      ack! # we need to let queue know that message was received
    end
    # pry
  end
end
