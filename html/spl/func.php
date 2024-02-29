<?php
# iterator_apply
$it = new ArrayIterator(["Apples", "Bananas", "Cherries"]);
iterator_apply($it, function (Iterator $iterator) {
    echo strtoupper($iterator->current()) . "\n";
    return TRUE;
}, array($it));
foreach($it as $key => $value){
    echo '<br/>';
    echo $key. ': '. $value;
}
echo '<br/>';
# iterator_count
var_dump(iterator_count($it)); //2
#iterator_to_array
var_dump(iterator_to_array($it, true));

echo '<hr/>';
$file = new \SplFileInfo('tree.php');
$fileObj = $file->openFile('r');
while($fileObj->valid()){
    echo $fileObj->fgets();
}
//关闭文件对象
$fileObj = null;
$file = null;