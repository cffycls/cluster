<?php
//官方
$heap = new SplMaxHeap(); # Ascending order
$heap->insert('E');
$heap->insert('B');
$heap->insert('D');
$heap->insert('A');
$heap->insert('C');
$heap->insert('R');
$heap->insert('W');

echo $heap->extract(), PHP_EOL; # E
echo $heap->extract(), PHP_EOL; # D

$heap = new SplMinHeap(); # Descending order
$heap->insert('E');
$heap->insert('B');
$heap->insert('D');
$heap->insert('A');
$heap->insert('C');

print PHP_EOL;
echo $heap->extract(), PHP_EOL; # A
echo $heap->extract(), PHP_EOL; # B
