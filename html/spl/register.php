<?php

spl_autoload_extensions(".php, .inc");
set_include_path(get_include_path() . PATH_SEPARATOR .'libs/');
var_dump(get_include_path() );

spl_autoload_register();
spl_autoload('PEople');

echo php_uname();
echo php_uname('s');
echo strtoupper(substr(PHP_OS,0,3))==='WIN'?'windows 服务器':'不是 widnows 服务器';
echo '<br/>';
var_dump(new test());
var_dump(new PEople());