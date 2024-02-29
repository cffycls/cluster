<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/8
 * Time: 16:55
 */
//swoole官方：https://wiki.swoole.com/wiki/page/879.html
/*
 * SplHeap数据结构需要指定一个compare方法来进行元素的对比，从而实现自动排序。SplHeap类本身是abstract的，不能直接new。
 * 需要编写一个子类，并实现compare方法。
 *
 * 使用
 * 定义好子类后，可使用insert方法插入元素，插入的元素会使用compare方法与已有元素进行对比，自动排序。
 * SplHeap底层使用跳表数据结构，insert操作的时间复杂度为O(Log(n))
 * 注意这里只能插入数字，因为我们定义的compare不支持非数字对比。如果要支持插入数组或对象，可重新实现compare方法。
 */
//最大堆
class MaxHeap extends SplHeap
{
    protected function compare($a, $b)
    {
        return $a - $b;
    }
}

//最小堆
class MinHeap extends SplHeap
{
    protected function compare($a, $b)
    {
        return $b - $a;
    }
}


$list = new MaxHeap;
$list->insert(56);
$list->insert(22);
$list->insert(35);
$list->insert(11);
$list->insert(88);
$list->insert(36);
$list->insert(97);
$list->insert(98);
$list->insert(26);

class MyHeap extends SplHeap
{
    protected function compare($a, $b)
    {
        return $a->value - $b->value;
    }
}
class MyObject
{
    public $value;

    function __construct($value)
    {
        $this->value = $value;
    }
}

$list = new MyHeap;
$list->insert(new MyObject(56));
$list->insert(new MyObject(12));
//使用foreach遍历堆，可以发现是有序输出。

foreach($list as $li)
{
    echo $li."\n";
}