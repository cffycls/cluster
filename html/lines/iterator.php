<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/14
 * Time: 10:55
 */
class FileIterator implements Iterator
{
    // 打开的文件句柄
    private $fp;
    // 打开的文件行数
    private $lineNumber;
    // 行内容
    private $lineContent;

    public function __construct($file)
    {
        $fp = fopen($file, "r");
        if (!$fp) {
            throw new Exception("「{$file}」不能打开");
        }
        $this->fp = $fp;
    }

    public function current()
    {
        //echo "current — 返回当前元素 \n";
        $this->lineContent = fgets($this->fp);
        return rtrim($this->lineContent, "\n");
    }

    public function next()
    {
        //echo "next — 向前移动到下一个元素 \n";
        $this->lineNumber++;
    }

    public function key()
    {
        //echo "key — 返回当前元素的键 \n";
        return $this->lineNumber;
    }

    public function valid()
    {
        //echo "valid — 检查当前位置是否有效 \n";
        return feof($this->fp) ? false : true;
    }

    public function rewind()
    {
        //echo "rewind — 返回到迭代器的第一个元素 \n";
        $this->lineNumber = 1;
    }


}