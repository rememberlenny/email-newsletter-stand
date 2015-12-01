class EmailProcessor
  def initialize(email)
    @email = email
    # pry
  end

  def process
    newsletter = Newsletter.find_by_email(@email.to[0][:token])
    if !newsletter.nil?
      Email.create(
        newsletter_id: newsletter.id,
        to: @email.to[0][:email],
        from: @email.from[:email],
        raw_text: @email.raw_text,
        raw_html: @email.raw_html,
        raw_body: @email.raw_body,
        body: @email.body
      )
    end
  end
end
