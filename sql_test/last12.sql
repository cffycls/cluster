-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2020-01-04 11:37:14
-- 服务器版本： 8.0.13
-- PHP 版本： 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `last12`
--

-- --------------------------------------------------------

--
-- 表的结构 `app_sequence`
--

CREATE TABLE `app_sequence` (
  `seq_date` varchar(16) COLLATE utf8mb4_general_ci NOT NULL,
  `seq_name` varchar(16) COLLATE utf8mb4_general_ci NOT NULL,
  `seq_value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `app_sequence`
--

INSERT INTO `app_sequence` (`seq_date`, `seq_name`, `seq_value`) VALUES
('200103', '200103', 1);

-- --------------------------------------------------------

--
-- 表的结构 `ms_stock`
--

CREATE TABLE `ms_stock` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'id',
  `product_id` int(11) UNSIGNED NOT NULL COMMENT '产品库存编号',
  `number` int(11) UNSIGNED NOT NULL COMMENT '库存数量',
  `update_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '最后修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀库存表';

--
-- 转存表中的数据 `ms_stock`
--

INSERT INTO `ms_stock` (`id`, `product_id`, `number`, `update_time`) VALUES
(1, 1, 951, '2019-12-25 16:56:24');

-- --------------------------------------------------------

--
-- 表的结构 `order_queue`
--

CREATE TABLE `order_queue` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'id',
  `order_id` varchar(20) NOT NULL COMMENT '订单号',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `create_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '订单创建时间',
  `update_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '订单处理完成时间',
  `status` tinyint(2) NOT NULL COMMENT '当前状态： 0未处理，1处理中，2已处理'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `order_queue`
--

INSERT INTO `order_queue` (`id`, `order_id`, `mobile`, `create_time`, `update_time`, `status`) VALUES
(1, '20191223110731-7009', '18545665556', '2019-12-23 11:07:31', '2019-12-23 11:36:02', 2),
(2, '20191223110732-8457', '18545665556', '2019-12-23 11:07:32', '2019-12-23 11:36:02', 2),
(3, '20191223110740-6706', '18545635556', '2019-12-23 11:07:40', '2019-12-23 11:37:01', 2),
(4, '20191223110746-9999', '18635635556', '2019-12-23 11:07:46', '2019-12-23 11:37:01', 2),
(5, '20191223110751-6000', '18875635556', '2019-12-23 11:07:51', '2019-12-23 11:38:01', 2),
(6, '20191223110754-2552', '18875635556', '2019-12-23 11:07:54', '2019-12-23 11:38:01', 2),
(7, '20191223110755-3868', '18875635556', '2019-12-23 11:07:55', '2019-12-23 11:39:01', 2),
(8, '20191223110847-1159', '11685635556', '2019-12-23 11:08:47', '2019-12-23 11:39:01', 2),
(9, '20191223110852-5744', '13685635556', '2019-12-23 11:08:52', '2019-12-23 11:40:01', 2),
(10, '20191223110854-8582', '13685635556', '2019-12-23 11:08:54', '2019-12-23 11:40:01', 2),
(11, '20191223110855-8620', '13685635556', '2019-12-23 11:08:55', '2019-12-23 11:41:01', 2),
(12, '20191223110902-2941', '13685635556', '2019-12-23 11:09:02', '2019-12-23 11:41:01', 2);

-- --------------------------------------------------------

--
-- 表的结构 `order_seq`
--

CREATE TABLE `order_seq` (
  `time_str` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `order_sn` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `order_seq`
--

INSERT INTO `order_seq` (`time_str`, `order_sn`) VALUES
('20200103143448', 95);

-- --------------------------------------------------------

--
-- 表的结构 `redis_queue`
--

CREATE TABLE `redis_queue` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'id',
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `rtime` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '--创建时间',
  `req_time` varchar(24) NOT NULL COMMENT '时间戳字符串'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `redis_queue`
--

INSERT INTO `redis_queue` (`id`, `uid`, `rtime`, `req_time`) VALUES
(1, 333398, '2019-12-23 12:55:22', '0.11824700 1577076922'),
(2, 430466, '2019-12-23 12:55:24', '0.11861300 1577076922'),
(3, 788128, '2019-12-23 12:55:26', '0.11895300 1577076922'),
(4, 440030, '2019-12-23 12:55:28', '0.11950500 1577076922'),
(5, 709246, '2019-12-23 12:55:30', '0.11970100 1577076922'),
(6, 768200, '2019-12-23 12:55:32', '0.11985600 1577076922'),
(7, 181939, '2019-12-23 12:55:34', '0.12001000 1577076922'),
(8, 850026, '2019-12-23 12:55:36', '0.12016100 1577076922'),
(9, 822695, '2019-12-23 12:55:38', '0.12039900 1577076922'),
(10, 335204, '2019-12-23 12:55:40', '0.12055700 1577076922'),
(11, 335098, '2019-12-23 12:55:42', '0.12085100 1577076922'),
(12, 469891, '2019-12-23 12:55:44', '0.00241200 1577076925'),
(13, 638057, '2019-12-23 12:56:18', '0.21001400 1577076977'),
(14, 653337, '2019-12-23 12:56:20', '0.21021300 1577076977'),
(15, 641621, '2019-12-23 12:56:23', '0.21047600 1577076977'),
(16, 396653, '2019-12-23 12:56:25', '0.21081200 1577076977'),
(17, 498794, '2019-12-23 12:56:27', '0.21107600 1577076977'),
(18, 668294, '2019-12-23 12:56:29', '0.21124800 1577076977'),
(19, 165660, '2019-12-23 12:56:31', '0.21141400 1577076977'),
(20, 292090, '2019-12-23 12:56:33', '0.21159100 1577076977'),
(21, 502587, '2019-12-23 12:56:35', '0.21179600 1577076977'),
(22, 723517, '2019-12-23 12:56:37', '0.21202600 1577076977'),
(23, 569167, '2019-12-23 12:56:39', '0.07174600 1577076980'),
(24, 159643, '2019-12-23 12:56:41', '0.46664000 1577076982'),
(25, 522658, '2019-12-23 12:56:43', '0.11309200 1577076983'),
(26, 456168, '2019-12-23 12:56:45', '0.41086900 1577076985'),
(27, 288644, '2019-12-23 12:56:47', '0.04970600 1577076987'),
(28, 492692, '2019-12-23 12:57:24', '0.78612800 1577077042'),
(29, 926091, '2019-12-23 12:57:26', '0.78629300 1577077042'),
(30, 553816, '2019-12-23 12:57:28', '0.78644200 1577077042'),
(31, 414748, '2019-12-23 12:57:30', '0.78661000 1577077042'),
(32, 672223, '2019-12-23 12:57:32', '0.78675800 1577077042'),
(33, 906872, '2019-12-23 12:57:34', '0.78692200 1577077042'),
(34, 537211, '2019-12-23 12:57:36', '0.78710100 1577077042'),
(35, 621353, '2019-12-23 12:57:38', '0.78725000 1577077042'),
(36, 417791, '2019-12-23 12:57:40', '0.78739500 1577077042'),
(37, 134020, '2019-12-23 12:57:42', '0.78753900 1577077042'),
(38, 140115, '2019-12-23 12:58:48', '0.61960500 1577077127'),
(39, 270195, '2019-12-23 12:58:51', '0.61979500 1577077127'),
(40, 517434, '2019-12-23 12:58:53', '0.61996100 1577077127'),
(41, 559350, '2019-12-23 12:58:55', '0.62011500 1577077127'),
(42, 589896, '2019-12-23 12:58:57', '0.62027500 1577077127'),
(43, 630075, '2019-12-23 12:58:59', '0.62041600 1577077127'),
(44, 947544, '2019-12-23 12:59:01', '0.62056500 1577077127'),
(45, 218847, '2019-12-23 12:59:03', '0.62082700 1577077127'),
(46, 301573, '2019-12-23 12:59:05', '0.62102300 1577077127'),
(47, 248495, '2019-12-23 12:59:07', '0.62118100 1577077127'),
(48, 712716, '2019-12-23 12:59:09', '0.20918900 1577077129'),
(49, 705830, '2019-12-23 12:59:11', '0.65320500 1577077131'),
(50, 947363, '2019-12-23 12:59:13', '0.23429800 1577077133'),
(51, 302231, '2019-12-23 12:59:15', '0.81984700 1577077136'),
(52, 224361, '2019-12-23 12:59:17', '0.09084400 1577077138'),
(53, 863581, '2019-12-23 13:00:59', '0.15306800 1577077258'),
(54, 211953, '2019-12-23 13:01:01', '0.15367300 1577077258'),
(55, 956058, '2019-12-23 13:01:03', '0.15382800 1577077258'),
(56, 315942, '2019-12-23 13:01:05', '0.15397800 1577077258'),
(57, 842193, '2019-12-23 13:01:07', '0.15412800 1577077258'),
(58, 855975, '2019-12-23 13:01:10', '0.15427600 1577077258'),
(59, 722493, '2019-12-23 13:01:12', '0.15442200 1577077258'),
(60, 667250, '2019-12-23 13:01:14', '0.15462000 1577077258'),
(61, 470335, '2019-12-23 13:01:16', '0.15488000 1577077258'),
(62, 833623, '2019-12-23 13:01:18', '0.15503100 1577077258');

-- --------------------------------------------------------

--
-- 表的结构 `tax_rate`
--

CREATE TABLE `tax_rate` (
  `id` int(11) NOT NULL,
  `low` float(10,2) UNSIGNED NOT NULL COMMENT '计税起点',
  `hight` float(10,2) UNSIGNED NOT NULL COMMENT '计税终点',
  `rate` float(5,5) NOT NULL COMMENT '税率'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `tax_rate`
--

INSERT INTO `tax_rate` (`id`, `low`, `hight`, `rate`) VALUES
(1, 0.00, 1500.00, 0.03000),
(2, 1500.00, 4500.00, 0.10000),
(3, 4500.00, 9000.00, 0.20000),
(4, 9000.00, 35000.00, 0.25000),
(5, 35000.00, 55000.00, 0.30000),
(6, 55000.00, 80000.00, 0.35000),
(7, 80000.00, 100000000.00, 0.45000);

-- --------------------------------------------------------

--
-- 表的结构 `tb_sequence`
--

CREATE TABLE `tb_sequence` (
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `tb_sequence`
--

INSERT INTO `tb_sequence` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `over_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '称号',
  `mobile` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '电话，多个、以‘,’分割'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='唐僧师徒表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `user_name`, `over_name`, `mobile`) VALUES
(1, '唐僧', '旃檀功德佛', '16452223658'),
(2, '孙悟空', '斗战胜佛', '16366665325,15623231454,16366665325,16366665325,16832565214'),
(3, '猪八戒', '净坛使者', '13641412541,12645456332,13641412541'),
(4, '沙僧', '金身罗汉', '13869696541,19811113265');

-- --------------------------------------------------------

--
-- 表的结构 `user_equipment`
--

CREATE TABLE `user_equipment` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT 'users表id',
  `arms` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '武器',
  `clothing` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服饰',
  `shoe` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '鞋子'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='唐僧师徒表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `user_equipment`
--

INSERT INTO `user_equipment` (`id`, `user_id`, `arms`, `clothing`, `shoe`) VALUES
(1, 1, '九环锡杖', '锦斓袈裟', '僧鞋'),
(2, 2, '金箍棒', '锁子黄金甲', '藕丝步云履'),
(3, 3, '九齿钉耙', '僧衣', '僧鞋'),
(4, 4, '降妖宝杖', '僧衣', '僧鞋');

-- --------------------------------------------------------

--
-- 表的结构 `user_flow`
--

CREATE TABLE `user_flow` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `flow` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '随后前程'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='悟空朋友们表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `user_flow`
--

INSERT INTO `user_flow` (`id`, `user_name`, `flow`) VALUES
(1, '孙悟空', '成佛'),
(2, '牛魔王', '被降服'),
(3, '蛟魔王', '被降服'),
(4, '鹏魔王', '被降服'),
(5, '狮驼王', '被降服');

-- --------------------------------------------------------

--
-- 表的结构 `user_kills`
--

CREATE TABLE `user_kills` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT 'users表对应id',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  `kills` mediumint(8) UNSIGNED NOT NULL COMMENT '杀怪数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='打怪记录表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `user_kills`
--

INSERT INTO `user_kills` (`id`, `user_id`, `kills`) VALUES
(1, 3, 10),
(2, 3, 2),
(3, 3, 12),
(4, 4, 3),
(5, 2, 5),
(6, 2, 1),
(7, 2, 20),
(8, 2, 14),
(9, 3, 5),
(10, 4, 10),
(11, 2, 17);

-- --------------------------------------------------------

--
-- 表的结构 `user_salary`
--

CREATE TABLE `user_salary` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `over` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '称号',
  `money` float(10,2) DEFAULT '0.00' COMMENT '收入'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='唐僧师徒表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `user_salary`
--

INSERT INTO `user_salary` (`id`, `user_name`, `over`, `money`) VALUES
(1, '唐僧', '旃檀功德佛', 35000.00),
(2, '孙悟空', '斗战胜佛', 28000.00),
(3, '猪八戒', '净坛使者', 15000.00),
(4, '沙僧', '金身罗汉', 8000.00);

--
-- 转储表的索引
--

--
-- 表的索引 `ms_stock`
--
ALTER TABLE `ms_stock`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `order_queue`
--
ALTER TABLE `order_queue`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `redis_queue`
--
ALTER TABLE `redis_queue`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `tax_rate`
--
ALTER TABLE `tax_rate`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `tb_sequence`
--
ALTER TABLE `tb_sequence`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_equipment`
--
ALTER TABLE `user_equipment`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_flow`
--
ALTER TABLE `user_flow`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_kills`
--
ALTER TABLE `user_kills`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_salary`
--
ALTER TABLE `user_salary`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `ms_stock`
--
ALTER TABLE `ms_stock`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `order_queue`
--
ALTER TABLE `order_queue`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `redis_queue`
--
ALTER TABLE `redis_queue`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=63;

--
-- 使用表AUTO_INCREMENT `tax_rate`
--
ALTER TABLE `tax_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `tb_sequence`
--
ALTER TABLE `tb_sequence`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `user_equipment`
--
ALTER TABLE `user_equipment`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `user_flow`
--
ALTER TABLE `user_flow`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `user_kills`
--
ALTER TABLE `user_kills`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `user_salary`
--
ALTER TABLE `user_salary`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
