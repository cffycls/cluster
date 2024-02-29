<?php


namespace App\Controller;

use App\Rpc\CalculatorServiceInterface;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Annotation\AutoController;

/**
 * //测试调用
 * @AutoController()
 */
class CalcController
{
    /**
     * @Inject()
     * @var CalculatorServiceInterface
     */
    public $calcService;

    public function add()
    {
        return $this->calcService->add(11, 22);
    }

    public function minus()
    {
        return $this->calcService->minus(11, 22);
    }

}