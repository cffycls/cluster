<?php

$it = new FilesystemIterator('.');
foreach ($it as $fInfo){
    print_r([
        'mt'=>date('Y-m-d H:i:s', $fInfo->getMTime()),
        'fs'=>$fInfo->getSize()
    ]);
}

## 逐行读取文件
$file = new \SplFileInfo('tree.php');
$fileObj = $file->openFile('r');
while($fileObj->valid()){
    echo $fileObj->fgets(); 
}
//关闭文件对象
$fileObj = null;
$file = null;