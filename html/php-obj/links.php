<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/12
 * Time: 13:21
 */
// 英雄类
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
$head=new Hero();

$hero1=new Hero(1,"宋江","及时雨");
$head->next=$hero1;

$hero2=new Hero(8,"卢俊义","");
$hero1->next=$hero2;
function print_list($cur){
    while($cur->next!=null){
        echo "姓名：".$cur->next->data['no'].'. '.$cur->next->data['name']."<br/>";
        $cur=$cur->next;
    }
    print_r('**********************************<br/>');
}
echo '<pre>';

//批量添加，链式传递&
function insert_list($node, ... $args)
{
    foreach($args as $data){
        $next = new Hero($data[0], $data[1], $data[2]);
        $node->next = $next;
        $node = $next; //注意迭代
    }
}
print_list($hero2);
insert_list($hero2, [13,'赵小白','小白'], [6,'李兴河','小何'], [11,'张大河','大何']);
print_list($hero1);
print_list($head);

//排序，返回新序列
function sort_list($node, $order_field='no', $order_type="ASC"){
    $list2array=[];
    $node2 = $node;
    while($node2->next != null){
        $list2array[$node2->next->data[$order_field]] = [
            $node2->next->data['no'],
            $node2->next->data['name'],
            $node2->next->data['nickname']
        ];
        $node2 = $node2->next;
    }
    if( $order_type=="ASC"){
        ksort($list2array);
    }else{
        krsort($list2array);
    }
    $head_node = new Hero();//写时复制
    function insertls($node, $list2array) {
        foreach($list2array as $data){
            $next = new Hero($data[0], $data[1], $data[2]);
            $node->next = $next;
            $node = $next; //注意迭代
        }
    }
    insertls($head_node, $list2array);

    return $head_node;
}
$new_head = sort_list($head);

print_list($new_head);

