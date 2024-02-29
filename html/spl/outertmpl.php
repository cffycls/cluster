<?php

class OuterTmpl extends IteratorIterator
{
    public function current(){
        return (parent::current() * parent::current()).'_**_'. parent::key();
    }
    public function key(){
        return 'key? '. (parent::key() * 2);
    }
}
$array = [1,3,5,7,9];
$outerObj = new OuterTmpl(new ArrayIterator($array));
foreach($outerObj as $key => $value){
    echo $key. ': '. $value, PHP_EOL;
}