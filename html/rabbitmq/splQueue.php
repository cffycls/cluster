<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/8
 * Time: 16:45
 */
//swoole官方：https://wiki.swoole.com/wiki/page/507.html
$splq = new SplQueue;
for ($i = 1; $i <= 1000000; $i++) {
    $data = "hello $i\n";
    $splq->push($data);

    if ($i % 100 == 99 and count($splq) > 100) {
        $popN = rand(10, 99);
        for ($j = 0; $j < $popN; $j++) {
            $splq->shift();
        }
    }
}

$popN = count($splq);
for ($j = 0; $j < $popN; $j++) {
    $splq->pop();
}