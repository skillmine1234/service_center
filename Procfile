web: bundle exec passenger start -p $PORT --max-pool-size 3
worker: bundle exec bin/delayed_job --queue=emails -i 1 start