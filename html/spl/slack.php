<?php
//$links = new SplDoublyLinkedList();
$links = new SplStack();
//$links = new SplQueue();
echo '<pre>';
print_r($links);
$links->rewind();
echo 'is valid ? ';
var_dump($links->valid()); //false
echo '<hr/><hr/>';
echo 'push:1-2-3; unshift:10: <br/>';

$links->push(1);
$links->push(2);
$links->push(3);
$links->unshift(10);
print_r($links);
echo '<hr/><hr/>';

//添加数据后，不一下重置可能无法输出（指针有值可输出）
echo 'current:' .$links->current();
$links->next();
echo '--next node:' .$links->current(). '<br/>';

$links->rewind();
echo 'rewind current:' .$links->current();
$links->next();
echo '--next node:' .$links->current(). '<br/><br/>';

echo 'current pop:' .$links->pop(). '<br/>';
echo 'current:' .$links->current(). '<br/><br/>';
$links->push('X');
$links->unshift('Y');
echo 'push:X; unshift:Y: <br/>';
echo 'current pop:' .$links->pop(). '<br/>';
echo 'current:' .$links->current(). '<br/>';


echo '<hr/>';
print_r($links);
echo '<br/>';
echo 'offsetGet: 3 == ' .$links->offsetGet(3). '; ';
echo 'top:' .$links->top(). '; ';
echo 'bottom:' .$links->bottom(). '<hr/>';
//$links->offsetSet(0, 6);
//$links->offsetSet(3, 'gg');
print_r($links);