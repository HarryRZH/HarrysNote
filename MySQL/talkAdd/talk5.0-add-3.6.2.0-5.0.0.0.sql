-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------- 基于审讯3.6.2.0升级增量脚本 --------------------------------------
-- ----------------------------------------------------------------------------------------------------


ALTER TABLE person_legal rename to in_person_legal;

CREATE TABLE IF NOT EXISTS `ibcp_nlp_individual` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `session_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `sessionid` (`session_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT = '个性词字典表';

CREATE TABLE IF NOT EXISTS `ibcp_nlp_keyword` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `session_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'sessionId',
    `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键词',
    `history` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `key` (`word`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='关键词字典表';

CREATE TABLE IF NOT EXISTS `ibcp_nlp_mood_word` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '语气词内容',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='语气词字典表';

CREATE TABLE IF NOT EXISTS `ibcp_nlp_sensitive` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `session_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务id',
    `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '敏感词',
    `replace_word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '替换词',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `sessionid` (`session_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT = '敏感词字典表';

CREATE TABLE IF NOT EXISTS `ibcp_nlp_term` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `term` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '词性',
    `means` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '含义',
    `is_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否显示. 1:true:显示, 0:false:不显示',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `term` (`term`) USING BTREE,
    KEY `show_index` (`is_show`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT = '词性字典表';


INSERT INTO `ibcp_nlp_term` select 1, 'card', '身份证', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='card');
INSERT INTO `ibcp_nlp_term` select 2, 'def', '自定义', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='def');
INSERT INTO `ibcp_nlp_term` select 3, 'kn', '管制刀具', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='kn');
INSERT INTO `ibcp_nlp_term` select 4, 'mq', '数量词', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='mq');
INSERT INTO `ibcp_nlp_term` select 5, 'nation', '民族', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nation');
INSERT INTO `ibcp_nlp_term` select 6, 'nhd', '疾病', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nhd');
INSERT INTO `ibcp_nlp_term` select 7, 'nhm', '药品', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nhm');
INSERT INTO `ibcp_nlp_term` select 8, 'nnd', '职业', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nnd');
INSERT INTO `ibcp_nlp_term` select 9, 'nr', '人名', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nr');
INSERT INTO `ibcp_nlp_term` select 10, 'ns', '地名', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='ns');
INSERT INTO `ibcp_nlp_term` select 11, 'nt', '机构团体名', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nt');
INSERT INTO `ibcp_nlp_term` select 12, 'ntc', '公司名', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='ntc');
INSERT INTO `ibcp_nlp_term` select 13, 'ntcb', '银行', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='ntcb');
INSERT INTO `ibcp_nlp_term` select 14, 'ntcf', '工厂', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='ntcf');
INSERT INTO `ibcp_nlp_term` select 15, 'ntch', '酒店宾馆', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='ntch');
INSERT INTO `ibcp_nlp_term` select 16, 'nto', '政府机构', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='card');
INSERT INTO `ibcp_nlp_term` select 17, 'nts', '中小学', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='nts');
INSERT INTO `ibcp_nlp_term` select 18, 'ntu', '大学', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='ntu');
INSERT INTO `ibcp_nlp_term` select 19, 'phone', '手机号', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='phone');
INSERT INTO `ibcp_nlp_term` select 20, 't', '时间词', FALSE, now(), now() from DUAL where not exists(select term from ibcp_nlp_term where term='t');

INSERT INTO `ibcp_nlp_mood_word` select 1, '嗯', now(), now(), now() from DUAL where not exists(select word from ibcp_nlp_mood_word where word='嗯');
INSERT INTO `ibcp_nlp_mood_word` select 2, '啊', now(), now(), now() from DUAL where not exists(select word from ibcp_nlp_mood_word where word='啊');
INSERT INTO `ibcp_nlp_mood_word` select 3, '呃', now(), now(), now() from DUAL where not exists(select word from ibcp_nlp_mood_word where word='呃');
INSERT INTO `ibcp_nlp_mood_word` select 4, '诶', now(), now(), now() from DUAL where not exists(select word from ibcp_nlp_mood_word where word='诶');
INSERT INTO `ibcp_nlp_mood_word` select 5, '唉', now(), now(), now() from DUAL where not exists(select word from ibcp_nlp_mood_word where word='唉');


ALTER TABLE `in_case` DROP FOREIGN KEY `fk_in_case_legal_in_legal`;
ALTER TABLE `in_case` DROP FOREIGN KEY `fk_in_case_person_in_person`;
ALTER TABLE `in_case` DROP FOREIGN KEY `fk_in_case_templetid_in_templ`;
ALTER TABLE `in_case` DROP INDEX `fk_in_case_owner_in_user`;
ALTER TABLE `in_case` DROP INDEX `fk_in_case_roomid_in_inque`;
ALTER TABLE `in_case` DROP INDEX `fk_in_case_templetid_in_templ`;
ALTER TABLE `in_case` DROP INDEX `fk_in_case_legal_in_legal`;
ALTER TABLE `in_case` DROP INDEX `fk_in_case_person_in_person`;
ALTER Table `in_case` ADD INDEX `person_id`(`person_id`) USING BTREE;
ALTER Table `in_case` DROP `rtsp_url`;
ALTER TABLE `in_case` CHANGE `status` `status` int(1) NULL DEFAULT 0 COMMENT '状态. 0: 未完成, 1: 已完成, 2:暂停中';
ALTER TABLE `in_case` CHANGE `duration` `duration` bigint(20) NULL DEFAULT 0 COMMENT '审讯时长(也是上次暂停位于任务中的时间, 不算暂停笔录和继续笔录的无效时间)';
ALTER TABLE `in_case` CHANGE `templet_id` `templet_id` bigint(20) NULL DEFAULT NULL COMMENT '审讯模板';
ALTER TABLE `in_case` CHANGE `mic_info` `mic_info` varchar(255) NULL DEFAULT NULL COMMENT '麦克风信息';
ALTER TABLE `in_case` ADD `pause_time` datetime NULL DEFAULT NULL COMMENT '暂停时间';
ALTER TABLE `in_case` ADD `continue_time` datetime NULL DEFAULT NULL COMMENT '继续时间';
ALTER TABLE `in_case` ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER TABLE `in_case` ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';



CREATE TABLE IF NOT EXISTS `in_case_attachment` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件名',
    `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '笔录编号',
    `md5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件MD5',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='文件插入笔录表';


CREATE TABLE IF NOT EXISTS `in_case_config` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `case_id` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录id',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人id',
    `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人名称',
    `room_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'ACT对应房间编号',
    `rtsp_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'rtsp取流地址',
    `burn_type` bit(1) DEFAULT NULL COMMENT '刻录类型.1-双光驱直刻false 2-接力刻true',
    `burn_enabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启刻录',
    `video_enabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启视频直播',
    `audio_enabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启音频转写',
    `start_type` int(2) DEFAULT NULL COMMENT '开始笔录时的笔录类型',
    `premium` bit(1) NOT NULL DEFAULT b'0' COMMENT '开始笔录时的标准笔录页面类型（精简版、高级版）',
    `is_over` bit(1) NOT NULL DEFAULT b'0' COMMENT '笔录是否结束',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `case_id` (`case_id`) USING BTREE,
    KEY `user_id` (`user_id`) USING BTREE,
    KEY `room_id` (`room_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='笔录配置记录';


ALTER TABLE in_case_content ADD `iddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
UPDATE in_case_content SET iddd = id;

UPDATE in_case_content bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_case_content bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_case_content DROP COLUMN `iddd`;
ALTER TABLE in_case_content MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER Table `in_case_content` CHANGE `create_time` `create_time` bigint NOT NULL COMMENT '识别时间';
ALTER Table `in_case_content` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_case_content` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';


CREATE TABLE `in_case_export_file` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `md5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件MD5',
    `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '笔录编号',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户编号',
    `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '导出密码',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `md5` (`md5`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='笔录导出文件密码表';


ALTER Table `in_case_person` CHANGE `person_id` `person_id` bigint(20) NOT NULL COMMENT '人员编号';
ALTER Table `in_case_person` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_case_person` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER Table `in_case_person` CHANGE `relation` `relation_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '与被审讯人关系ID(字典)';
ALTER Table `in_case_person` CHANGE `language` `language_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '翻译语种ID(字典)';


ALTER Table `in_dict` CHANGE `sort` `sort` int(11) NULL DEFAULT NULL COMMENT '排序';
ALTER Table `in_dict` CHANGE `status` `status` int(11) NULL DEFAULT NULL COMMENT '状态：0：正常，1：停用';
ALTER Table `in_dict` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_dict` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';

INSERT INTO `in_dict` VALUES ('ef7308c8c76644608b6c813944f6dfa9', '其他', 'CASE_CAUSE', '641', '0', null, null, now(), now());
INSERT INTO `in_dict` VALUES ('e182a88a41a741afb6ac974fd6de3537', '谈话', 'RECORD_TYPE', '3', '0', null, null, now(), now());
INSERT INTO `in_dict` VALUES ('85fe4e70b26c402a935b1e2cf0a917a0', '罪犯', 'PERSON_TYPE', '6', '0', null, null, now(), now());
INSERT INTO `in_dict` VALUES ('8f6a1e11de8f49228f4688a4439b3889', '被谈话人', 'PERSON_TYPE', '5', '0', null, null, now(), now());


ALTER TABLE in_industry MODIFY `industry_id` bigint NOT NULL AUTO_INCREMENT COMMENT '行业编号';
ALTER Table `in_industry` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_industry` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';


ALTER Table `in_interrogator` DROP FOREIGN KEY `case_id`;
ALTER Table `in_interrogator` CHANGE `id` `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
ALTER Table `in_interrogator` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_interrogator` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';
ALTER Table `in_interrogator` COMMENT '案件审讯人表';


ALTER Table `in_laws` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间';
ALTER Table `in_laws` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_laws` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';
ALTER Table `in_laws` COMMENT '法律法规表';

ALTER TABLE in_laws_content DROP FOREIGN KEY `in_laws_content_ibfk_1`;
ALTER TABLE in_laws ADD `idd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键';
UPDATE in_laws SET idd = id;
UPDATE in_laws bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_laws bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
		
-- 同步更新关联表的外键
UPDATE in_laws_content t1 JOIN in_laws t2 ON t2.idd = t1.law_id SET t1.law_id = t2.id;
ALTER TABLE in_laws DROP COLUMN `idd`;
ALTER TABLE in_laws MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
ALTER TABLE in_laws_content MODIFY `law_id` bigint(20) NULL DEFAULT NULL COMMENT '法规id';


ALTER Table `in_laws_content` CHANGE `sort` `sort` int(11) NULL DEFAULT 0 COMMENT '排序';
ALTER Table `in_laws_content` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_laws_content` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_laws_content` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';
ALTER Table `in_laws_content` RENAME INDEX `fk_in_laws__reference_in_laws` TO `law_id`;
ALTER Table `in_laws_content` COMMENT '法律法规内容表';

ALTER TABLE in_laws_content ADD `idd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
UPDATE in_laws_content SET idd = id;

UPDATE in_laws_content bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_laws_content bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_laws_content DROP COLUMN `idd`;
ALTER TABLE in_laws_content MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';


ALTER Table `in_legal` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_legal` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER Table `in_legal` ADD  `start_type` int(2) NOT NULL COMMENT '开始笔录时的笔录类型';
ALTER Table `in_legal` CHANGE `id` `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录id';
ALTER Table `in_legal` CHANGE `create_time` `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '笔录创建时间';


ALTER TABLE in_legal_user ADD `iddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
UPDATE in_legal_user SET iddd = id;

UPDATE in_legal_user bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_legal_user bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_legal_user DROP COLUMN `iddd`;
ALTER TABLE in_legal_user MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER Table `in_legal_user` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间';
ALTER Table `in_legal_user` CHANGE `auth` `auth` int(11) NULL DEFAULT NULL COMMENT '权限，1：拥有者，2：被分享者';
ALTER Table `in_legal_user` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_legal_user` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER Table `in_legal_user` RENAME INDEX `fk_in_case__userid_in_user` TO `user_id`;
ALTER Table `in_legal_user` RENAME INDEX `caseid` TO `legal_id`;


ALTER TABLE in_letter_auth ADD `iddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键';
UPDATE in_letter_auth SET iddd = id;

UPDATE in_letter_auth bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_letter_auth bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_letter_auth DROP COLUMN `iddd`;
ALTER TABLE in_letter_auth MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER Table `in_letter_auth` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间';
ALTER Table `in_letter_auth` CHANGE `forder_location_man` `forder_location_man` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '男声音频路径';
ALTER Table `in_letter_auth` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_letter_auth` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';


ALTER TABLE in_log ADD `iddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键';
UPDATE in_log SET iddd = id;

UPDATE in_log bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_log bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_log DROP COLUMN `iddd`;
ALTER TABLE in_log MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER Table `in_log` CHANGE `type` `type` int(11) NULL DEFAULT NULL COMMENT '类型(0 - 管理员操作,1 - 用户操作,2 - 系统日志)';
ALTER Table `in_log` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间';
ALTER Table `in_log` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_log` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER Table `in_log` RENAME INDEX `fk_in_log_userid_in_user` TO `user_name`;


ALTER Table `in_params` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_params` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';


ALTER Table person_extend DROP FOREIGN KEY `person_extend_ibfk_1`;
ALTER TABLE in_person ADD `iddd` VARCHAR ( 50 ) CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '主键';
UPDATE in_person SET iddd = id;

UPDATE in_person bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_person bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;

UPDATE in_person_legal a JOIN in_person b ON b.iddd = a.person_id SET a.person_id = b.id;
UPDATE in_case a JOIN in_person b ON b.iddd = a.person_id SET a.person_id = b.id;
UPDATE in_case_person a JOIN in_person b ON b.iddd = a.person_id SET a.person_id = b.id;


ALTER TABLE `in_case` CHANGE `person_id` `person_id` bigint(20) NOT NULL COMMENT '讯/询问对象id';
ALTER TABLE `in_case_person` CHANGE `person_id` `person_id` bigint(20) NOT NULL COMMENT '人员编号';
ALTER TABLE `in_case_person` CHANGE `id` `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
ALTER Table `in_person` CHANGE `id` `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '人员编号';
ALTER TABLE in_person_legal CHANGE `person_id` `person_id` bigint(20) DEFAULT NULL COMMENT '讯/询问对象id';
ALTER TABLE in_person_legal CHANGE `legal_id` `legal_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件id';
ALTER TABLE in_person_legal CHANGE `id` `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
ALTER TABLE in_person_legal ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER TABLE in_person_legal ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';

ALTER TABLE in_person DROP COLUMN `iddd`;
ALTER TABLE in_person MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '人员编号';

ALTER Table `in_person` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_person` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER Table `in_person` CHANGE `age` `age` int(11) NULL DEFAULT NULL COMMENT '年龄';
ALTER Table `in_person` CHANGE `status` `status` int(11) NULL DEFAULT NULL COMMENT '状态,0:正常，1：已删除';
ALTER Table `in_person` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间';



CREATE TABLE IF NOT EXISTS `in_template` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '模板id主键',
    `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '模板名称',
    `type` tinyint NOT NULL COMMENT '模板类型: 0 - 问答模板, 1 - 笔录模板',
    `record_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '适用笔录类型ID',
    `admin_create` tinyint DEFAULT NULL COMMENT '是否管理员创建(0 - 否,1 - 是)',
    `status` int DEFAULT NULL COMMENT '状态: 0 - 停用, 1 - 启用',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属用户',
    `person_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '适用对象ID',
    `is_default` int DEFAULT '0' COMMENT '是否默认: type非0时指定, 1 - 是, 0 - 否',
    `create_time` datetime NOT NULL COMMENT '操作时间',
    `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`),
    INDEX `type`(`type`) USING BTREE,
    INDEX `status`(`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='模板表';


CREATE TABLE IF NOT EXISTS `in_template_content` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板内容编号',
    `templet_id` bigint(20) DEFAULT NULL COMMENT '模板ID',
    `content` text COMMENT '内容',
    `sort` int NOT NULL COMMENT '顺序号',
    `type` int DEFAULT NULL COMMENT '模板类型:0 - 头部模板,1 - 正文模板,2 - 尾部模板',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='模板内容表';


ALTER TABLE in_undertaker ADD `iddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
UPDATE in_undertaker SET iddd = id;

UPDATE in_undertaker bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_undertaker bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_undertaker DROP COLUMN `iddd`;
ALTER TABLE in_undertaker MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER Table `in_undertaker` ADD  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER Table `in_undertaker` ADD  `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER Table `in_undertaker` CHANGE `create_time` `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间';
ALTER Table `in_undertaker` DROP FOREIGN KEY `in_undertaker_ibfk_1`;



CREATE TABLE IF NOT EXISTS `in_user_room` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
    `room_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT = '用户房间表';


CREATE TABLE IF NOT EXISTS `in_user_skin` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
    `skin_code` int(2) NOT NULL COMMENT '皮肤编码',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT = '用户换肤表';


CREATE TABLE IF NOT EXISTS `in_case_mark` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `case_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '笔录编号',
    `tag_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标记编号（前端定义唯一属性）',
    `mark_type` int(3) DEFAULT NULL COMMENT '标记类型（ABCD）',
    `begin_time` int(11) NOT NULL COMMENT '一句话的开始时间',
    `end_time` int(11) NOT NULL COMMENT '一句话的结束时间',
    `mark_content` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打标内容',
    `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `case_tag_id` (`case_id`,`tag_id`) USING BTREE,
    FULLTEXT KEY `mark_content` (`mark_content`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='笔录打标内容';


CREATE TABLE IF NOT EXISTS `local_file` (
    `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键,文件md5',
    `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
    `file_size` int NOT NULL COMMENT '文件大小（kb）',
    `text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '识别结果',
    `duration` bigint DEFAULT NULL COMMENT '时长',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`md5`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE IF NOT EXISTS `view_file` (
    `file_id` int NOT NULL AUTO_INCREMENT COMMENT '文件ID',
    `file_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
    `domain_lang` int NOT NULL COMMENT '领域: 0 普通话, 1 粤语',
    `md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件MD5',
    `file_status` int NOT NULL COMMENT '识别状态 0 - 正在识别 1 - 识别完成 2 - 服务异常 3 - 等待识别',
    `task_text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '识别结果',
    `create_time` datetime NOT NULL COMMENT '上传时间',
    `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上传者id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`file_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;



DROP TABLE IF EXISTS in_keyword;
DROP TABLE IF EXISTS in_major;
DROP TABLE IF EXISTS in_templet;
DROP TABLE IF EXISTS in_templet_content;
DROP TABLE IF EXISTS person_extend;
DROP TABLE IF EXISTS sq_in_undertaker;
DROP TABLE IF EXISTS user_room;

















