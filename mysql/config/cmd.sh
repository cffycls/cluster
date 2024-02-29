#!/bin/bash
mysql -p3306 -uroot -p123456 -Dtestdb -e "source /etc/mysql/t10_5.sql"