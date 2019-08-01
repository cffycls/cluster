<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/14
 * Time: 10:23
 */
$pathB = "B.txt";
$reqNum = 5; //需要个数

/**
 * 1.读取
 */
$file = fopen($pathB, "rb") or exit("Unable to open file!");
fclose($file);

$output = shell_exec("wc -l $pathB");
$total = (int) $output;

function getRandLines(string $filename, int $total, int $num, $method = 'rb'){
    $content = array();
    $getNum = array();
    for ($i=0; $i<$num; $i++){
        $getNum[] = mt_rand(1, $total);
    }
    sort($getNum);

    if (version_compare(PHP_VERSION, '5.1.0', '>=')) {
        $fp = new SplFileObject($filename, $method);
        foreach ($getNum as $startLine){
            $fp->seek($startLine - 1);
            $content[] = $fp->current();
            $fp->next();
        }
    } else { //PHP<5.1
        $fp = fopen($filename, $method);

        for ($i = 1; $i < $total; ++$i) {
            if(in_array($i, $getNum)) {
                $content[] = fgets($fp);
            }
        }
        fclose($fp);
    }
    return array_filter($content);
}

$contents = getRandLines($pathB, $total, $reqNum);
//print_r($contents);

/**
 * 2.插入
 */
$pathA = "A.txt";
$wordsX = 'x';
$wordsY = 'y';
$cmd0 = "sed -i s/\"{$wordsX}{$wordsY}\"/\"{$wordsX}";
$cmdP = addslashes(rtrim($contents[0])); //B中的某个字符串，去除右边换行符
$cmd1 = "{$wordsY}\"/g A.txt.0";

print_r($cmd0. $cmdP. $cmd1 .PHP_EOL);
$output = shell_exec($cmd0. $cmdP. $cmd1);
print_r($output);

/**
 * 3.运行m次
 * 4.保存 A.x.html
 *   使用2.
 */
$m = 5;
$pathA = "A.txt";
$dir = './D';
if(!file_exists($dir)){
    mkdir($dir);
}
$max = count($contents);
$m = $m>$max ? $max : $m;

$savePath = 'C.txt';
$saveFiles = [];

for ($i=1; $i<=$m; $i++){
    $dst = $dir."/A_{$i}.html";
    copy($pathA, $dst);

    $wordsX = 'x';
    $wordsY = 'y';
    $cmd0 = "sed -i s/\"{$wordsX}{$wordsY}\"/\"{$wordsX}";
    $cmdP = addslashes(rtrim($contents[$i-1])); //B中的某个字符串，去除右边换行符
    $cmd1 = "{$wordsY}\"/g {$dst}";

    print_r($cmd0. $cmdP. $cmd1 .PHP_EOL);
    $output = shell_exec($cmd0. $cmdP. $cmd1);

    $saveFiles[] = $dst;
}

file_put_contents($savePath, implode(PHP_EOL, $saveFiles));

/**
 * 5.保存生成文件名，见上
 */



