/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.0.180
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 192.168.0.180:3306
 Source Schema         : talk5.0

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 31/08/2022 14:12:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ibcp_nlp_individual
-- ----------------------------
DROP TABLE IF EXISTS `ibcp_nlp_individual`;
CREATE TABLE `ibcp_nlp_individual`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `session_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessionid`(`session_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '个性词字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ibcp_nlp_keyword
-- ----------------------------
DROP TABLE IF EXISTS `ibcp_nlp_keyword`;
CREATE TABLE `ibcp_nlp_keyword`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `session_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'sessionId',
  `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键词',
  `history` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `key`(`word`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '关键词字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ibcp_nlp_mood_word
-- ----------------------------
DROP TABLE IF EXISTS `ibcp_nlp_mood_word`;
CREATE TABLE `ibcp_nlp_mood_word`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语气词内容',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '语气词字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ibcp_nlp_sensitive
-- ----------------------------
DROP TABLE IF EXISTS `ibcp_nlp_sensitive`;
CREATE TABLE `ibcp_nlp_sensitive`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `session_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务id',
  `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '敏感词',
  `replace_word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '替换词',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessionid`(`session_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '敏感词字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ibcp_nlp_term
-- ----------------------------
DROP TABLE IF EXISTS `ibcp_nlp_term`;
CREATE TABLE `ibcp_nlp_term`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `term` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '词性',
  `means` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '含义',
  `is_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否显示. 1:true:显示, 0:false:不显示',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `term`(`term`) USING BTREE,
  INDEX `show_index`(`is_show`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '词性字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_case
-- ----------------------------
DROP TABLE IF EXISTS `in_case`;
CREATE TABLE `in_case`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录编号',
  `legal_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '案件id',
  `person_id` bigint(20) NOT NULL COMMENT '讯/询问对象id',
  `times` int(2) NOT NULL COMMENT '询问次数',
  `record_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录类型',
  `record_department` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审讯部门',
  `record_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录人',
  `status` int(1) NULL DEFAULT 0 COMMENT '状态. 0: 未完成, 1: 已完成, 2:暂停中',
  `duration` bigint(20) NULL DEFAULT 0 COMMENT '审讯时长(也是上次暂停位于任务中的时间, 不算暂停笔录和继续笔录的无效时间)',
  `templet_qa_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问答模板',
  `templet_id` bigint(20) NULL DEFAULT NULL COMMENT '审讯模板',
  `room_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审讯室(笔录地点)',
  `stop_time` datetime NULL DEFAULT NULL COMMENT '暂停时间',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '笔录内容',
  `owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '笔录拥有者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '笔录创建时间',
  `rtmp_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视频RTMP地址',
  `flv_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视频flv地址',
  `record_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回播地址',
  `person_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审讯对象类型',
  `room_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间名称',
  `mic_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '麦克风信息',
  `pre_delete_time` datetime NULL DEFAULT NULL COMMENT '预删除时间',
  `pause_time` datetime NULL DEFAULT NULL COMMENT '暂停时间',
  `continue_time` datetime NULL DEFAULT NULL COMMENT '继续时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `createtime`(`create_time`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `person_id`(`person_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '案件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_case_attachment
-- ----------------------------
DROP TABLE IF EXISTS `in_case_attachment`;
CREATE TABLE `in_case_attachment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '笔录编号',
  `md5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件MD5',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件插入笔录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_case_config
-- ----------------------------
DROP TABLE IF EXISTS `in_case_config`;
CREATE TABLE `in_case_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `case_id` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录id',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人id',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人名称',
  `room_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ACT对应房间编号',
  `rtsp_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'rtsp取流地址',
  `burn_type` bit(1) NULL DEFAULT NULL COMMENT '刻录类型.1-双光驱直刻false 2-接力刻true',
  `burn_enabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启刻录',
  `video_enabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启视频直播',
  `audio_enabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启音频转写',
  `start_type` int(2) NULL DEFAULT NULL COMMENT '开始笔录时的笔录类型',
  `premium` bit(1) NOT NULL DEFAULT b'0' COMMENT '开始笔录时的标准笔录页面类型（精简版、高级版）',
  `is_over` bit(1) NOT NULL DEFAULT b'0' COMMENT '笔录是否结束',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `case_id`(`case_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `room_id`(`room_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '笔录配置记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for in_case_content
-- ----------------------------
DROP TABLE IF EXISTS `in_case_content`;
CREATE TABLE `in_case_content`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '笔录编号',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '识别结果',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型，0：问，1：答',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态,0:正常，1：已删除',
  `create_time` bigint(20) NOT NULL COMMENT '识别时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '案件转写结果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_case_export_file
-- ----------------------------
DROP TABLE IF EXISTS `in_case_export_file`;
CREATE TABLE `in_case_export_file`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `md5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件MD5',
  `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '笔录编号',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户编号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '导出密码',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `md5`(`md5`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '笔录导出文件密码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_case_mark
-- ----------------------------
DROP TABLE IF EXISTS `in_case_mark`;
CREATE TABLE `in_case_mark`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录编号',
  `tag_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标记编号（前端定义唯一属性）',
  `mark_type` int(3) NULL DEFAULT NULL COMMENT '标记类型（ABCD）',
  `begin_time` int(11) NOT NULL COMMENT '一句话的开始时间',
  `end_time` int(11) NOT NULL COMMENT '一句话的结束时间',
  `mark_content` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打标内容',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `case_tag_id`(`case_id`, `tag_id`) USING BTREE,
  FULLTEXT INDEX `mark_content`(`mark_content`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '笔录打标内容' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_case_person
-- ----------------------------
DROP TABLE IF EXISTS `in_case_person`;
CREATE TABLE `in_case_person`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录编号',
  `person_id` bigint(20) NOT NULL COMMENT '人员编号',
  `relation_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '与被审讯人关系ID(字典)',
  `language_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '翻译语种ID(字典)',
  `cosplay` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录中扮演的角色',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_dict
-- ----------------------------
DROP TABLE IF EXISTS `in_dict`;
CREATE TABLE `in_dict`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下拉框分类.record_type 笔录类型、interrogation_object 询问对象、way_to_case 到案方式、cred_type 证件类型、sex_type 性别、nation_type 民族、isregard 代表委员、political_status 政治面貌、degree 学历',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态：0：正常，1：停用',
  `value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典值',
  `group` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签分组名称',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_industry
-- ----------------------------
DROP TABLE IF EXISTS `in_industry`;
CREATE TABLE `in_industry`  (
  `industry_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '行业编号',
  `industry_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业名称',
  `industry_app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业应用名称',
  `industry_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业logo名称',
  `industry_remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业备注',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`industry_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行业表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_interrogator
-- ----------------------------
DROP TABLE IF EXISTS `in_interrogator`;
CREATE TABLE `in_interrogator`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审讯人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '案件ID',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `case_id`(`case_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '案件审讯人表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_laws
-- ----------------------------
DROP TABLE IF EXISTS `in_laws`;
CREATE TABLE `in_laws`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '法律法规表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_laws_content
-- ----------------------------
DROP TABLE IF EXISTS `in_laws_content`;
CREATE TABLE `in_laws_content`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `law_id` bigint(20) NULL DEFAULT NULL COMMENT '法规id',
  `item` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '条',
  `section` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '章',
  `pian` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编',
  `part` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `law_id`(`law_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2173 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '法律法规内容表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_legal
-- ----------------------------
DROP TABLE IF EXISTS `in_legal`;
CREATE TABLE `in_legal`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录id',
  `case_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '案件名称',
  `case_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '案件编号',
  `target_person` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标人物编号',
  `under_department` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办案部门',
  `case_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件类型',
  `cause_action` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案由',
  `summary` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简要案情',
  `status` decimal(2, 0) NULL DEFAULT NULL COMMENT '状态,0:正常，1：已删除',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属用户',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '笔录创建时间',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `person_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '涉案人员类型',
  `start_type` int(2) NOT NULL COMMENT '开始笔录时的笔录类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `createtime`(`create_time`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '案件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_legal_user
-- ----------------------------
DROP TABLE IF EXISTS `in_legal_user`;
CREATE TABLE `in_legal_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `legal_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件编号|笔录编号',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户编号',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `auth` int(11) NULL DEFAULT NULL COMMENT '权限，1：拥有者，2：被分享者',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `legal_id`(`legal_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '案件共享表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_letter_auth
-- ----------------------------
DROP TABLE IF EXISTS `in_letter_auth`;
CREATE TABLE `in_letter_auth`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权利书名称',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `forder_location_woman` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '源文件路径',
  `forder_location_man` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '男声音频路径',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态，1已合成，0正在合成',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权利义务告知书' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_log
-- ----------------------------
DROP TABLE IF EXISTS `in_log`;
CREATE TABLE `in_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型(0 - 管理员操作,1 - 用户操作,2 - 系统日志)',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_params
-- ----------------------------
DROP TABLE IF EXISTS `in_params`;
CREATE TABLE `in_params`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数key',
  `val` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数值',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `default_value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统参数表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_person
-- ----------------------------
DROP TABLE IF EXISTS `in_person`;
CREATE TABLE `in_person`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '人员编号',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `name_used` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '曾用名',
  `nick_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绰号',
  `type` int(11) NULL DEFAULT NULL COMMENT '对象类型: 0 - 被审讯人, 1 - 其他人员',
  `certificate_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证件类型',
  `certificate_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `sex` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `nationality` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '国籍',
  `nation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '民族',
  `birthday` datetime NULL DEFAULT NULL COMMENT '出生日期',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `occupation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职业',
  `isdeputy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代表委员',
  `political_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `rank` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职级',
  `degree` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `work_unit` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作单位',
  `domicile` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户籍地',
  `present` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现住地',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态,0:正常，1：已删除',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `createtime`(`create_time`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人员信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_person_legal
-- ----------------------------
DROP TABLE IF EXISTS `in_person_legal`;
CREATE TABLE `in_person_legal`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `person_id` bigint(20) NULL DEFAULT NULL COMMENT '讯/询问对象id',
  `legal_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for in_template
-- ----------------------------
DROP TABLE IF EXISTS `in_template`;
CREATE TABLE `in_template`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板id主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板名称',
  `type` tinyint(4) NOT NULL COMMENT '模板类型: 0 - 问答模板, 1 - 笔录模板',
  `record_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '适用笔录类型ID',
  `admin_create` tinyint(4) NULL DEFAULT NULL COMMENT '是否管理员创建(0 - 否,1 - 是)',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态: 0 - 停用, 1 - 启用',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户',
  `person_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '适用对象ID',
  `is_default` int(11) NULL DEFAULT 0 COMMENT '是否默认: type非0时指定, 1 - 是, 0 - 否',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_template_content
-- ----------------------------
DROP TABLE IF EXISTS `in_template_content`;
CREATE TABLE `in_template_content`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板内容编号',
  `templet_id` bigint(20) NULL DEFAULT NULL COMMENT '模板ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `sort` int(11) NOT NULL COMMENT '顺序号',
  `type` int(11) NULL DEFAULT NULL COMMENT '模板类型:0 - 头部模板,1 - 正文模板,2 - 尾部模板',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模板内容表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_undertaker
-- ----------------------------
DROP TABLE IF EXISTS `in_undertaker`;
CREATE TABLE `in_undertaker`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '承办人',
  `legal_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '案件ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `case_id`(`legal_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_user_room
-- ----------------------------
DROP TABLE IF EXISTS `in_user_room`;
CREATE TABLE `in_user_room`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `room_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户房间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for in_user_skin
-- ----------------------------
DROP TABLE IF EXISTS `in_user_skin`;
CREATE TABLE `in_user_skin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `skin_code` int(2) NOT NULL COMMENT '皮肤编码',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户换肤表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for local_file
-- ----------------------------
DROP TABLE IF EXISTS `local_file`;
CREATE TABLE `local_file`  (
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键,文件md5',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `file_size` int(11) NOT NULL COMMENT '文件大小（kb）',
  `text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '识别结果',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT '时长',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`md5`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for view_file
-- ----------------------------
DROP TABLE IF EXISTS `view_file`;
CREATE TABLE `view_file`  (
  `file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `file_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `domain_lang` int(11) NOT NULL COMMENT '领域: 0 普通话, 1 粤语',
  `md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件MD5',
  `file_status` int(11) NOT NULL COMMENT '识别状态 0 - 正在识别 1 - 识别完成 2 - 服务异常 3 - 等待识别',
  `task_text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '识别结果',
  `create_time` datetime NOT NULL COMMENT '上传时间',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上传者id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
