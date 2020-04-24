<?php
$mit = new MultipleIterator(MultipleIterator::MIT_KEYS_ASSOC);
$mit->attachIterator(new ArrayIterator([1,2,3,4,5]), 'id');
$mit->attachIterator(new ArrayIterator(['zhangshan','lishi','wangwu','liuer','xiaqi']), 'name');
$mit->attachIterator(new ArrayIterator([23,24,32,30,26]), 'age');

echo '<pre>';

foreach($mit as $key => $value){
    //var_export($key);
    echo ': ';
    print_r($value);
    echo '<br/>';
}

echo '<hr/><hr/>';
$it = new FilesystemIterator('.');
foreach ($it as $fInfo){
    print_r($fInfo);

    print_r([
        'mt'=>date('Y-m-d H:i:s', $fInfo->getMTime()),
        'fs'=>$fInfo->getSize()
    ]);
}

echo '<hr/><hr/>';
class CountMe implements Countable
{
    public function count(){ return 3;}
}
echo count(new CountMe()); //3

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
    echo '<br/>';
    echo $key. ': '. $value;
}