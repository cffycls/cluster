<?php

/**
 * http 1.0
 */
$http = new \Swoole\Http\Server('127.0.0.1', 9501, SWOOLE_BASE);
$http->set([
	'log_file' => '/dev/null',
	'worker' => 1,
	'open_http2_protocol' => true
]);
$http->on('request', function (\Swoole\Http\Request $request, \Swoole\Http\Response $response){
	\Swoole\Coroutine::sleep(mt_rand(10, 500) / 1000);
	$response->end($request->rawContent());
});
$http->start();

