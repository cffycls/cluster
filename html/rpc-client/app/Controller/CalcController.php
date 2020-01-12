<?php


namespace App\Controller;

use App\Rpc\CalculatorServiceConsumer;
use App\Rpc\CalculatorServiceInterface;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Annotation\AutoController;

/**
 * @AutoController()
 */
class CalcController extends AbstractController
{
    /**
     * @Inject()
     * @var CalculatorServiceInterface
     * 或者 @var CalculatorServiceConsumer
     */
    private $calcService;

    public function add()
    {
        return $this->calcService->add(11, 22);
    }

    public function minus()
    {
        return $this->calcService->minus(11, 22);
    }

}