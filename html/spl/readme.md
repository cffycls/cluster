##SPL: Standard PHP Library 标准PHP类库
SplDoublyLinkedList.0 | SplQueue.4 | SplStack.6
====
1、类的关系
----
```markdown
class SplDoublyLinkedList implements Iterator, Countable, ArrayAccess, Serializable {
  -add($index, $newval)
  -push($value)/pop()                                --尾部 +-end
  -unshift($value)/shifts()                          --顶部 +-beginning
  -top()                                             --尾部 end
  -bottom()                                          --开头 beginning
  -count()
  -isEmpty()
  -setIteratorMode($mode)
  -getIteratorMode()
  -offsetExists($index)
  -offsetGet($index)
  -offsetSet($index, $newval)
  -offsetUnset($index)                                --删除指定索引，并重新连接[排序]
  -rewind()                                           --back to the start
  -current()
  -key()                                              --current的index
  -next()
  -prev()
  -valid()
  -serialize()
  -unserialize(string $serialized)
  -__serialize()
  -__unserialize(array $data)
}
```
### [SplDoublyLinkedList::setIteratorMode](https://www.php.net/manual/en/spldoublylinkedlist.setiteratormode.php) 参数：
```
There are two orthogonal sets of modes that can be set:
◦ The direction of the iteration 迭代的方向(either one or the other):
 ◦SplDoublyLinkedList::IT_MODE_LIFO (Stack style) 2
 ◦SplDoublyLinkedList::IT_MODE_FIFO (Queue style) 0

◦ The behavior of the iterator 迭代器的行为(either one or the other):
 ◦SplDoublyLinkedList::IT_MODE_DELETE (Elements are deleted by the iterator 元素被迭代器删除) 1
 ◦SplDoublyLinkedList::IT_MODE_KEEP (Elements are traversed by the iterator 元素由迭代器遍历) 0

The default mode is: SplDoublyLinkedList::IT_MODE_FIFO | SplDoublyLinkedList::IT_MODE_KEEP
```
参数
```
Iteration Direction
SplDoublyLinkedList::IT_MODE_LIFO
    The list will be iterated in a last in, first out order, like a stack.
    该列表将按“最后入，先出”的顺序迭代，就像栈一样。  [First in, First out.先进先出]
SplDoublyLinkedList::IT_MODE_FIFO
    The list will be iterated in a first in, first out order, like a queue.
    该列表将按照先入先出的顺序迭代，就像队列一样. [LIFO: Last in, First out.后进先出]

const IT_MODE_LIFO = 2;
const IT_MODE_FIFO = 0;
const IT_MODE_DELETE = 1;
const IT_MODE_KEEP = 0;
```
```markdown
class SplQueue extends SplDoublyLinkedList {
  -enqueue($value)                                        --入列 add to queue
  -dequeue()                                              --出列 dequeue a node
}
class SplStack extends SplDoublyLinkedList {
  -esetIteratorMode($mode)                                 --设置迭代模式（方向）
}
```
上面来自关联接口：phpstorm//stubs/SPL/SPL_c1.php 和php官网。

从C++学习基础归来，可以看到：系统分配堆、先进后出，自定义new栈、随进随出【先入必先出、不然找不到；并且执行段结束了】。
即堆[Slack]是系统指定的逆序列，堆[Heap]是随进随出的正序列。

#异同：
rewind()、next()、prev() ==> 双链表和queue是start在上、slack在下
top\bottom\add\push\pop等相同


2、堆[自动排序]
----
```markdown
abstract class SplHeap implements Iterator, Countable {
    public function extract () {}                           --末端删除并返回
    public function insert ($value) {}
    public function top () {}                               --查看顶部
    public function count () {}
    public function isEmpty () {}
    public function rewind () {}                            --to the beginning
    public function current () {}
    public function key () {}
    public function next () {}
    public function valid () {}
    public function recoverFromCorruption () {}         --Recover from the corrupted state and allow further actions on the heap
    //在SplHeap中抛出异常::compare()取消堆并将其置于阻塞状态。您可以通过调用SplHeap::recoverFromCorruption()来解除阻塞。然而，有些元素可能放置不正确，这可能会破坏堆属性。
    abstract protected function compare ($value1, $value2);
    public function isCorrupted(){}
}
```
