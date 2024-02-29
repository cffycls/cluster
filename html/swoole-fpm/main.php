<?php
use Swoole\Coroutine;
use Swoole\Coroutine\FastCGI\Client;
use Swoole\FastCGI\HttpRequest;

$s = microtime(true);
Coroutine\run(function () {
    for ($n = 0; $n < 20; $n++) {
	Coroutine::create(function () use ($n) {
            try {
                $client = new Client('127.0.0.1', 9000);
                $request = (new HttpRequest())
                    ->withScriptFilename('/home/wwwroot/cluster/html/swoole-fpm/blocking.php')
                    ->withMethod('POST')
                    ->withBody(['id' => $n]);
                $response = $client->execute($request);
                echo "Result: {$response->getBody()}\n";
            } catch (Client\Exception $exception) {
                echo "Error: {$exception->getMessage()}\n";
            }
        });
    }
});
$s = microtime(true) - $s;
echo 'use ' . $s . ' s' . "\n";
