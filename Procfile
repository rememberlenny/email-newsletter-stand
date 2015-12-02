web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

# See config/unicorn.rb for disabling spawing of workers in web dyno
worker: WORKERS=EmailsWorker bundle exec rake sneakers:run
