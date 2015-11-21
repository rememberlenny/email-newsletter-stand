class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    newsletter = Newsletter.find_by_email(@email.to[0][:token])
    Email.create(
      newsletter_id: newsletter.id,
      to: to,
      from: from,
      subject: subject,
      body: body,
      raw_text: raw_text,
      raw_html: raw_html,
      raw_body: raw_body,
      attachments: attachments,
      headers: headers,
      raw_headers: raw_headers
    )
  end
end
