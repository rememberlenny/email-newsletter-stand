opts = {
  :amqp => ENV['RABBITMQ_BIGWIG_TX_URL'],
  :exchange_type => :direct
}

Sneakers.configure(opts)

Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy
