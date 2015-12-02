require 'hutch'


class EmailsWorker
  include Hutch::Consumer
  consume 'stand.emails'

  # work method receives message payload in raw format
  # in our case it is JSON encoded string
  # which we can pass to RecentPosts service without
  # changes
  def work(raw_post)
    puts "TestConsumer got a message: #{message}"
    puts "Processing..."
    @email = JSON.parse(email)
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
    end
    puts "Done"
  end
end
