<?php

$pdo = new \PDO('mysql:host=192.168.1.111;dbname=last12', 'root','123456');
$data = $pdo->query("select * from category")->fetchAll(PDO::FETCH_ASSOC);
echo count($data). '<pre>';

$tree = [];
$tmpMap = [];
//gcid \parentgcid\ gcname
$id = 'gcid';
$pid = 'parentgcid';
$son = 'children';
foreach ($data as $item) {
    $tmpMap[$item[$id]] = $item;
}
foreach ($data as $item) {
    if (isset($tmpMap[$item[$pid]])) {
        //把父子结构转换引用成地址，准备据完成后，输出时即是所需数据
        $tmpMap[$item[$id]]['level'] = $tmpMap[$item[$pid]]['level']>0 ? ($tmpMap[$item[$pid]]['level']+1) : 0;
        $tmpMap[$item[$pid]][$son][] = &$tmpMap[$item[$id]];
    } else {
        $tmpMap[$item[$id]]['level'] = 1;
        $tree[] = &$tmpMap[$item[$id]];
    }
}

print_r($tree);