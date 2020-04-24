<?php

//键值同步分离
$it1 = new ArrayIterator(array(1,2,3,4,5));	//对照只列出前3个
$it2 = new ArrayIterator(array(4,5,6));

$multipleIterator = new MultipleIterator(MultipleIterator::MIT_NEED_ALL|MultipleIterator::MIT_KEYS_ASSOC);

$multipleIterator->attachIterator($it1, 1);
$multipleIterator->attachIterator($it2, 'second');

foreach ($multipleIterator as $key => $value) {
    echo "Key"; var_dump($key);
    echo "Value"; var_dump($value);
    echo "---next---\n";
}
/*
Keyarray(2) {
  [1]=>
  int(0)
  ["second"]=>
  int(0)
}
Valuearray(2) {
  [1]=>
  int(1)
  ["second"]=>
  int(4)
}
---next---
Keyarray(2) {
  [1]=>
  int(1)
  ["second"]=>
  int(1)
}
Valuearray(2) {
  [1]=>
  int(2)
  ["second"]=>
  int(5)
}
---next---
Keyarray(2) {
  [1]=>
  int(2)
  ["second"]=>
  int(2)
}
Valuearray(2) {
  [1]=>
  int(3)
  ["second"]=>
  int(6)
}
---next---


 */