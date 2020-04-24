<?php

//example 1; 普通数组迭代
$fruits = array(
    "apple" => "yummy",
    "orange" => "ah ya, nice",
    "grape" => "wow, I love it!",
    "plum" => "nah, not me"
);
$obj = new ArrayObject( $fruits );
$it = $obj->getIterator();
echo "Iterating over: " . $obj->count() . " values\n";
while( $it->valid() )
{
    echo $it->key() . "=" . $it->current() . "\n";
    $it->next();
}
foreach ($it as $key=>$val)
echo $key.":".$val."\n";
/*
Iterating over: 4 values
apple=yummy
orange=ah ya, nice
grape=wow, I love it!
plum=nah, not me
apple:yummy
orange:ah ya, nice
grape:wow, I love it!
plum:nah, not me

 */


//example 2: 两数组健值组合[array_combine]
$fruits = array(
                "apple" => "yummy",
                "orange" => "ah ya, nice",
                "grape" => "wow, I love it!",
                 "plum" => "nah, not me"
                );

$veg = array("potato" => "chips", "carrot" => "soup");
$grocery = array($fruits, $veg);
$obj = new ArrayObject( $grocery );
$it = new RecursiveIteratorIterator( new RecursiveArrayIterator($grocery));
foreach ($it as $key=>$val)
echo $key.":".$val."\n";
/*
plum=nah, not me
apple:yummy
orange:ah ya, nice
grape:wow, I love it!
plum:nah, not me

 */

//example 3: 类似目录结构输出
class PrintArray
{
    private $code = null;

    function __construct ($val)
    {
        $this->code = $val;
        $this->_print();
    }
    
    private function arrayIterator($val, $grau)
    {
        $grau++;
        $arr = new \ArrayIterator($val);
        while ($arr->valid())
        {
            if(is_array($arr->current()))
            {
                $this->arrayIterator($arr->current(), $grau);
            }
            else
            {
                $this->code .= str_repeat(" ", (4 * $grau)) . $arr->key() . " : " . $arr->current() . PHP_EOL;
            }
            $arr->next();
        }
    }
    
    private function _print() 
    {
        if (is_array($this->code))
        {
            $arr = new \ArrayIterator($this->code);
            $this->code = 'array(' . PHP_EOL;
            while ($arr->valid())
            {
                if(is_array($arr->current()))
                {
                    $this->arrayIterator($arr->current(), 0);
                }
                else
                {
                    $this->code .= $arr->key() . " : " . $arr->current() . "\n";
                }
                $arr->next();
            }
            $this->code .= ')';
        }
        return $this;
    }
    
    public function getVal ()
    {
        return $this->code;
    }
}

$arr = array(
    array(
        'ok' => 1, array(9,7,5,9,'a','b'=>array(1,2)),
        'error' => 2, array('h','u','o')
    )
    , 'array'
);
$pArray = new PrintArray($arr);
var_dump($pArray->getVal());

/*
string(191) "array(
    ok : 1
        0 : 9
        1 : 7
        2 : 5
        3 : 9
        4 : a
            0 : 1
            1 : 2
    error : 2
        0 : h
        1 : u
        2 : o
1 : array
)"

 */