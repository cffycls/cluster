<?php


namespace App\Controller;

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
     */
    private $calcService;

    public function add()
    {
        return $this->calcService->add(12, 56);
    }

    public function minus()
    {
        return $this->calcService->minus(23, 78);
    }

}