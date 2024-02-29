<?php

spl_autoload_extensions(".php, .inc");
set_include_path(get_include_path() . PATH_SEPARATOR .'libs/');
var_dump(get_include_path() );

spl_autoload_register();
spl_autoload('PEople'); //不区分大小写

echo PHP_EOL, php_uname(), PHP_EOL;
echo php_uname('s'), PHP_EOL;
echo strtoupper(substr(PHP_OS,0,3))==='WIN'?'windows 服务器':'不是 widnows 服务器', PHP_EOL;

//var_dump(new test());
var_dump(new PEople());