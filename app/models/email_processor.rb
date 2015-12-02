class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    EmailsWorker.perform_async(@email)
  end

  def self.create_email(email)
    newsletter = Newsletter.find_by_email(@email["to"][0]["token"])
    if @email["to"]
      if newsletter
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
        puts "Done"
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
        puts "Failed"
      end
    end
  end
end
