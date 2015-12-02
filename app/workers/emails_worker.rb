class EmailsWorker
  include Sidekiq::Worker

  def perform(email)
    EmailProcessor.create_email(email)
    logger.info 'Running EmailCheck ' + Time.now.utc.to_s
  end
end
