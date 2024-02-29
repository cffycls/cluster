docker pull rabbitmq
docker run --name rbt -p 5672:5672 \
	--network mybridge --ip=172.1.12.15 \
	-v /home/wwwroot/cluster/rabbitmq/rabbitmq.conf \
	-v /home/wwwroot/cluster/rabbitmq/data:/var/lib/rabbitmq/mnesia \
	-e RABBITMQ_ERLANG_COOKIE='123456' \
	-e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=123456 \
	-d rabbitmq 
