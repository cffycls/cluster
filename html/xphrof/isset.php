<?php

print_r(true);
print_r(false);
$arr = array( "one"=>"1", "two"=>"2", "three"=>null );
var_dump(array_key_exists("one", $arr)); // true
var_dump(array_key_exists("two", $arr)); // true
var_dump(array_key_exists("three", $arr)); // true
echo PHP_EOL;
$arr = array( "one"=>"1", "two"=>"2", "three"=>null );
var_dump(isset($arr["one"])); // true
var_dump(isset($arr["two"])); // true
var_dump(isset($arr["three"])); // false

//第2题：
$arr = [1,2,3,4,5];
foreach($arr as &$v) {
	//nothing todo.
}
foreach($arr as $v) {
	//nothing todo.
	echo $v. PHP_EOL;
}
var_export($arr);
//output:array(0=>1,1=>2,2=>2)，你的答案对了吗？为什么
