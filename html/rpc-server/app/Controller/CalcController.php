<?php


namespace App\Controller;

use App\Rpc\CalculatorService;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Annotation\AutoController;

/**
 * @AutoController()
 */
class CalcController
{
    /**
     * @Inject()
     * @var CalculatorService
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