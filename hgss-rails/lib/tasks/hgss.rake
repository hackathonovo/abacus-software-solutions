namespace :hgss do
	desc "TODO"
	task push_worker: :environment do
	  	require 'timeout'
		require 'queue_classic'

		FailedQueue = QC::Queue.new("failed_jobs")

		certificate = File.read("development.pem")
		passphrase = "testing1234567890"
		CONNECTION = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
		CONNECTION.open

		class MyWorker < QC::Worker
			def process(job)
				puts job

				#binding.pry

				arguments = job[1][:args]
				first_argument = arguments[0]
				device_token = first_argument["device_token"]
				alert = first_argument["alert"]

				notification = Houston::Notification.new(device: device_token)
				notification.alert = alert
				CONNECTION.write(notification.message)

				puts "Done"
			end

			def handle_failure(job, e)
		    	FailedQueue.enqueue(job[:method], *job[:args])
		  	end

		  	def stop
		  		CONNECTION.close
		  	end
		end

		worker = MyWorker.new

		trap('INT') {exit}
		trap('TERM') {worker.stop}

		puts "Loaded"

		loop do
		  job = worker.lock_job
		  Timeout::timeout(50) { worker.process(job) }
		end
	end
end
