<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/1
 * Time: 13:08
 */

session_start();
$pdo = new \PDO("mysql:host=172.1.11.11;dbname=test", "root", "123456");
$result = $pdo->query("SELECT username,last_login FROM `user` limit 0,1");
$user = $result->fetch(PDO::FETCH_ASSOC);
while(empty($user)){
    $sql = sprintf("INSERT INTO `user` (`username`,`passwd`,`last_login`) VALUES ('%s', '%s', '%s')",
        'cffycls', sha1(md5('123456')), date('Y-m-d H:i:s'));
    $result = $pdo->query($sql);

    $result = $pdo->query("SELECT username,last_login FROM `user` limit 0,1");
    $user = $result->fetch(PDO::FETCH_ASSOC);
}
$serverInfo = [
    'gethostbyname'=>gethostbyname(gethostname().'.'),
    'REQUEST_TIME'=>date("Y-m-d H:i:s", $_SERVER['REQUEST_TIME']),
    'HTTP_COOKIE'=>$_SERVER['HTTP_COOKIE'],
    'HTTP_HOST'=>$_SERVER['HTTP_HOST'],
    'SERVER_SOFTWARE'=>$_SERVER['SERVER_SOFTWARE'],
    'SERVER_ADDR'=>$_SERVER['SERVER_ADDR'],
    'SERVER_PORT'=>$_SERVER['SERVER_PORT'],
    'REMOTE_ADDR'=>$_SERVER['REMOTE_ADDR'],
    'REMOTE_PORT'=>$_SERVER['REMOTE_PORT'],
    //'$_SERVER'=>$_SERVER,
];
$data = array_merge_recursive(['session_id'=>session_id()], $user, $serverInfo);
echo '<pre>';
print_r($data);

