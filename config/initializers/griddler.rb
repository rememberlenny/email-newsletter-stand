Griddler.configure do |config|
  config.processor_class = EmailProcessor # CommentViaEmail
  config.processor_method = :process # :create_comment (A method on CommentViaEmail)
  config.reply_delimiter = '---Email Footer---'
  config.email_service = :mandrill #sendgrid # :cloudmailin, :postmark, :mandrill, :mailgun
end
