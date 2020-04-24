<?php
//$links = new SplDoublyLinkedList();
$links = new SplQueue();
//$links = new SplStack();
echo 'SplQueue: '.PHP_EOL;
print_r($links);
/*
SplDoublyLinkedList Object
(
	[flags:SplDoublyLinkedList:private] => 4
    [dllist:SplDoublyLinkedList:private] => Array
		(
		)

)
*/
$links->rewind();
echo 'is valid ? ';
var_dump($links->valid()); //false
echo PHP_EOL;
echo 'push:1-2-3; unshift:10: '.PHP_EOL;

$links->push(1);
$links->push(2);
$links->push(3);
$links->unshift(10);
print_r($links); //10;1;2;3
echo PHP_EOL;
/*
SplDoublyLinkedList Object
(
	[flags:SplDoublyLinkedList:private] => 4
    [dllist:SplDoublyLinkedList:private] => Array
		(
			[0] => 10
            [1] => 1
            [2] => 2
            [3] => 3
        )

)
*/
//添加数据后，不一下重置可能无法输出（指针有值可输出）
echo __LINE__.'current:' .$links->current();
$links->next();
echo '--next node:' .$links->current(). PHP_EOL. PHP_EOL; //空-空

$links->rewind(); //10;1;2;3 --10
echo __LINE__.'rewind, current:' .$links->current(). ', '.PHP_EOL;
$links->next(); //10;1;2;3 --1
echo 'next, node:' .$links->current(). ', '.PHP_EOL;
$links->next(); //10;1;2;3 --2
echo 'next, node:' .$links->current(). PHP_EOL;
/*
rewind, current:10,
next, node:1,
next, node:2
current pop?:3
current:2
*/

echo __LINE__.'current pop?:' .$links->pop(). PHP_EOL;  //10;1;2[;3] --1 pop(3)固定是尾部
echo 'current:' .$links->current(). PHP_EOL;
$links->push('X');
$links->unshift('Y'); //Y;10;1;2;X
echo 'push:X; unshift:Y: '.PHP_EOL;
echo 'current pop:' .$links->pop(). PHP_EOL; //Y;10;1;2 --2
echo __LINE__.'current:' .$links->current(). PHP_EOL;

print_r($links);
echo PHP_EOL;
echo 'offsetGet: 3 == ' .$links->offsetGet(3). '; '; //Y
echo 'top:' .$links->top(). '; '; //2
echo 'bottom:' .$links->bottom(). PHP_EOL; //Y
print_r($links);
/*
offsetGet: 3 == 2; top:2; bottom:Y
SplQueue Object
(
    [flags:SplDoublyLinkedList:private] => 4
    [dllist:SplDoublyLinkedList:private] => Array
        (
            [0] => Y
            [1] => 10
            [2] => 1
            [3] => 2
        )

)
rewind顺序打印:
Y,10,1,2,
*/
echo 'rewind顺序打印: '.PHP_EOL;
$links->rewind();
while($links->valid()){
	echo $links->current() .',';
	$links->next();
}
echo PHP_EOL, $links->getIteratorMode();