<?php

class P
{
    public static function getChild() {
        return static::class. '/'. self::class. '|'. __CLASS__;
    }
    public function get() {
        return static::class. '<'. self::class. '|'. __CLASS__;
    }
} 

class C extends P {}

echo C::getChild(), PHP_EOL; //类调用，输出：C/P|P

$c = new C(); //对象调用
echo $c->get(). PHP_EOL; //输出：C<P|P


