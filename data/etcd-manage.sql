/*
 Navicat Premium Data Transfer

 Source Server Type    : MySQL
 Source Host           : 127.0.0.1:3306
 Source Schema         : etcd-manage

 Target Server Type    : MySQL
 Target Server Version : 5.7.44

 Date: 24/05/2024 19:21:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for etcd_servers
-- ----------------------------
DROP TABLE IF EXISTS `etcd_servers`;
CREATE TABLE `etcd_servers`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'v3' COMMENT 'etcd版本',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'etcd服务名字',
  `address` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'etcd地址列表',
  `prefix` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'key前缀，建议不为空，防止大量key',
  `tls_enable` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'true' COMMENT '是否启用tls连接',
  `cert_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书',
  `key_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书',
  `ca_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书',
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `desc` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述信息',
  `created_at` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'etched server列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of etcd_servers
-- ----------------------------
INSERT INTO `etcd_servers` VALUES (1, 'v3', '本机测试', '192.168.1.250:2379', '', 'false', '', '', '', '', '', '默认未启用ssl', NULL, '2024-05-20 10:45:34');
INSERT INTO `etcd_servers` VALUES (2, 'v3', '集群测试', '127.0.0.1:2379,127.0.0.1:12379,127.0.0.1:22379', '', 'false', '', '', '', '', '', '', NULL, '2024-05-20 11:20:54');

-- ----------------------------
-- Table structure for role_etcd_servers
-- ----------------------------
DROP TABLE IF EXISTS `role_etcd_servers`;
CREATE TABLE `role_etcd_servers`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `etcd_server_id` int(11) NOT NULL DEFAULT 0 COMMENT 'etcd服务id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0读 1写 -1无任何权限',
  `created_at` datetime NOT NULL COMMENT '添加时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE,
  INDEX `idx_etcd_server_id`(`etcd_server_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_etcd_servers
-- ----------------------------
INSERT INTO `role_etcd_servers` VALUES (1, 1, 1, 1, '2024-05-20 10:40:19', '2024-05-20 10:45:35');
INSERT INTO `role_etcd_servers` VALUES (2, 2, 1, 1, '2024-05-20 10:40:19', '2024-05-20 10:45:36');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名',
  `created_at` datetime NOT NULL COMMENT '添加时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, '高级管理员', '2024-05-20 10:43:44', '2024-05-20 10:43:48');
INSERT INTO `roles` VALUES (2, '开发只读', '2024-05-20 10:14:42', '2024-05-20 10:32:02');
INSERT INTO `roles` VALUES (3, '开发管理', '2024-05-20 10:25:05', '2024-05-20 10:32:21');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `role_id` int(11) NOT NULL DEFAULT 0 COMMENT '角色id',
  `created_at` datetime NOT NULL COMMENT '添加时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'bfb4216c2b79c294dc503795209ffe39', '123456', 1, '2024-05-20 10:19:15', '2024-05-20 10:47:47');

SET FOREIGN_KEY_CHECKS = 1;
