# opts = {
#   :amqp => ENV['RABBITMQ_BIGWIG_TX_URL'],
#   :exchange_type => :direct
# }
opts = {
  :amqp => 'amqp://dmXvIki1:MuALRXJSl15D_Bntwu2foLsT7aHHln88@curious-coltsfoot-59.bigwig.lshift.net:10718/Neqiygep2LG9',
  :exchange_type => :direct
}

Sneakers.configure(opts)

Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy
