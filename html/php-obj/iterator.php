<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/12
 * Time: 17:37
 */

class Hero{
    public $data;
    public $next=null;
    public function __construct($no=0,$name='',$nickname=''){
        $data['no'] = $no;
        $data['name'] = $name;
        $data['nickname'] = $nickname;
        $this->data = $data;
    }
}

$list = new SplDoublyLinkedList();
/*
$list->add(1, new Hero(1,"宋江","及时雨") );
$list->add(8, new Hero(1,"卢俊义","玉麒麟") );
$list->add(13, new Hero(13,'赵小白','小白') );
$list->add(6, new Hero(6,'李兴河','小何') );
$list->add(11, new Hero(11,'张大河','大何') );
*/
$list->add(0,"1 宋江 及时雨" );
$list->add(1, "8 卢俊义 玉麒麟" );
$list->add(2, '13 赵小白 小白' );
$list->add(3, '6 李兴河 小何' );
$list->add(4, '11 张大河 大何' );


$list->setIteratorMode(SplDoublyLinkedList::IT_MODE_FIFO);
for ($list->rewind(); $list->valid(); $list->next()) {
    echo $list->current()."<br/>";
}