<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/13
 * Time: 11:28
 */

$counter = function (){
    static $c = 1;
    return function () use (&$c) { return $c++; };
};
function counter() {
    $counter = 1;
    return function() use(&$counter) {return $counter ++;};
}
$counter1 = counter();

print_r($counter());
print_r($counter());
print_r($counter()());
print_r($counter()());
print_r($counter()());
print_r($counter()());
print_r( '=======S======================' );
print_r($counter1());
print_r($counter1());
print_r($counter1());
print_r($counter1());
print_r( PHP_EOL );



$a = 1;

$closure = function () use ($a) {
    echo $a;
};


print_r($closure().PHP_EOL);
$a=2;

print_r($closure().PHP_EOL);
//*************************
$a = 1;

$closure = function () use (&$a) {//注意这里，加了一个&
    echo $a;
};
print_r($closure().PHP_EOL);

$a=2;
print_r($closure().PHP_EOL);

