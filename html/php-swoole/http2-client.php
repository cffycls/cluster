<?php

\Swoole\Coroutine::create(function (){
	$client = new Swoole\Coroutine\Http2\Client('127.0.0.1', 9501);
	if (!$client->connect()){
		_error:
		echo 'Error.' .PHP_EOL;
		return ;
	}
	//用于储存多个流的信息
	$streams = [];
	//构建10个请求
	$request = new \Swoole\Http2\Request();
	for ($i=1; $i<=10; $i++){
		$request->data = $i;
		$streamId = $client->send($request);
		if(!$streamId){
			goto _error;
		}
		$streams[$streamId] = $i;
	}
	//打印现有的流和数据内容
	echo var_export($streams, true). PHP_EOL;

	//置空，接收相应
	$streams = [];
	for ($i=1; $i<=10; $i++){
		$response = $client->recv();
		$streams[$response->streamId] = $response->data;
	}
	//打印流和数据内容
	echo var_export($streams, true). PHP_EOL;
});

/**

array (
1 => 1,
3 => 2,
5 => 3,
7 => 4,
9 => 5,
11 => 6,
13 => 7,
15 => 8,
17 => 9,
19 => 10,
)
array (
19 => '10',
9 => '5',
3 => '2',
7 => '4',
17 => '9',
5 => '3',
11 => '6',
1 => '1',
13 => '7',
15 => '8',
)

 */