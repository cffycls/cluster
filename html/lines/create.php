<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/14
 * Time: 11:24
 */

echo '<pre>';
print_r([ord(' '), ord( 'z')]);

function cdata() {
    $data = [
        'xy',
        chr(mt_rand(ord(' '), ord('z'))) . chr(mt_rand(ord(' '), ord('z'))),
        chr(mt_rand(ord(' '), ord('z'))) . chr(mt_rand(ord(' '), ord('z'))),
        chr(mt_rand(ord(' '), ord('z'))) . chr(mt_rand(ord(' '), ord('z'))),
    ];
    $weight = [
        mt_rand(0,10),
        mt_rand(0,10),
        mt_rand(0,10),
        mt_rand(0,10),
    ];

    $words = mt_rand(0,200);
    $array = [];
    for ($i=0; $i<$words; $i++){
        $string = [];
        $string[] = ' ';
        $string[] = str_repeat($data[0], $weight[0]);
        $string[] = str_repeat($data[1], $weight[1]);
        $string[] = str_repeat($data[2], $weight[2]);
        $string[] = str_repeat($data[3], $weight[3]) .PHP_EOL;
        shuffle($string);
        $array[] = implode(null, $string);
    }
    return implode(null, $array);
}

$path = '../php-file/A.txt';
for ($i=0; $i<200; $i++){
    echo file_put_contents($path, cdata(), FILE_APPEND) .PHP_EOL;
}
echo 'OK';