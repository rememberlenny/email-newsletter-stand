class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    newsletter = Newsletter.find_by_email(@email.to[0][:token])
    if !newsletter.nil?
      # @email.pry
      Email.create(
        newsletter_id: newsletter.id,
        to: @email.to[0][:email],
        from: @email.from[:email],
        subject: @email.subject,
        body: @email.body
      )
    end
  end
end
