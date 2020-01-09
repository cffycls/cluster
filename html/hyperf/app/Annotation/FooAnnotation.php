<?php
namespace App\Annotation; //bug 注意大小写 *2

use Hyperf\Di\Annotation\AbstractAnnotation as AbstractAnnotationAlias;

/**
 * <<4.>> 自定义注解
 * Class Foo
 * @Annotation
 * @Target({"CLASS","METHOD","PROPERTY"})
 */
class FooAnnotation extends AbstractAnnotationAlias
{
    /**
     * @var string
     */
    public $bar;
    /**
     * @var int
     */
    public $calc;

}