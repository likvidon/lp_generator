def create_rabbitmq_connect(config) 
  connect = Bunny.new("amqp://guest:guest@" + config["mq"]["host"])
  connect.start

  channel = connect.create_channel
  queue = channel.queue(config["mq"]["queue"], :auto_delete => true)
  x = channel.default_exchange

  return x, queue
end


def login_generation
  len = rand(5..10)
  return [*('A'..'Z'), *('a'..'z')].sample(len).join
end


def password_generation(len, compl)
  return case compl
           when 'low'
  	     [*('0'..'9')].sample(len).join
 	   when 'middle'
     	     [*('A'..'Z'), *('a'..'z')].sample(len).join
	   when 'hard'
	     [*('A'..'Z'), *('a'..'z'), *('0'..'9')].sample(len).join
	   end
end
