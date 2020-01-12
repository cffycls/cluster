<?php

namespace App\Rpc;

use Hyperf\RpcClient\AbstractServiceClient;

/**
 * 可以对rpc接口按需二次处理
 * Class CalculatorServiceConsumer
 * @package App\Rpc
 */
class CalculatorServiceConsumer extends AbstractServiceClient implements CalculatorServiceInterface
{
	/**
	 * 定义对应服务提供者的服务名称
	 * @var string
	 */
	protected $serviceName = 'CalculatorService';

	/**
	 * 定义对应服务提供者的服务协议
	 * @var string
	 */
	protected $protocol = 'jsonrpc-http';

	public function add(int $a, int $b): int
	{
		$a *= 2;
		$b += 5;
		var_dump($a,$b);
		return $this->__request(__FUNCTION__, compact('a', 'b'));
	}
	public function minus(int $a, int $b): int
	{
		$a *= 2;
		$b += 5;
		var_dump($a,$b);
		return $this->__request(__FUNCTION__, compact('a', 'b'));
	}
}
