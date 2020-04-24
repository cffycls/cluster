<?php

$array_a = array(
                "apple" => "yummy",
                "orange" => "ah ya, nice",
                "grape" => "wow, I love it!",
                 "plum" => "nah, not me"
                );

$array_b = array("potato" => "chips", "plum" => "soup");
$it = new AppendIterator();
$it->append(new ArrayIterator($array_a));
$it->append(new ArrayIterator($array_b));
foreach($it as $key => $value){
    echo $key. ': '. $value .PHP_EOL;
}
/*
apple: yummy
orange: ah ya, nice
grape: wow, I love it!
plum: nah, not me
potato: chips
plum: soup

 */