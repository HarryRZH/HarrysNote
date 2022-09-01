-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------- 基于审讯4.2.0.0升级增量脚本 --------------------------------------
-- ----------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS in_keyword;

ALTER TABLE ibcp_nlp_term DROP PRIMARY KEY;
ALTER TABLE ibcp_nlp_term ADD UNIQUE KEY `term` ( `term` );
ALTER TABLE ibcp_nlp_term ADD `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键' primary key FIRST;

-- ----------------------------
-- Records of ibcp_nlp_mood_word
-- ----------------------------

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

ALTER TABLE in_industry MODIFY `industry_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER TABLE `in_template` CHANGE `transcript_type` `record_type` varchar(255) DEFAULT NULL COMMENT '适用笔录类型ID';

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

-- 增加字段保存父级表数据,将父级表的id行号设置到子集表的 父级id中,保存父级表id的行号数据,删除字段保存父级表数据
ALTER TABLE in_template_content ADD `iddd` VARCHAR ( 50 ) CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '主键';
UPDATE in_template_content SET iddd = id;

UPDATE in_template_content bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_template_content bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;
ALTER TABLE in_template_content DROP COLUMN `iddd`;
ALTER TABLE in_template_content MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键';

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

ALTER TABLE person_legal rename to in_person_legal;

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
ALTER TABLE in_person_legal CHANGE `person_id` `person_id` bigint(20) DEFAULT NULL COMMENT '讯/询问对象id';

ALTER TABLE in_person DROP COLUMN `iddd`;
ALTER TABLE in_person MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键';

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

ALTER TABLE in_interrogator ADD `iddd` VARCHAR ( 50 ) CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '主键';
UPDATE in_interrogator SET iddd = id;

UPDATE in_interrogator bs1
    INNER JOIN ( SELECT @r := @r + 1 AS row_num, bs2.id FROM in_interrogator bs2, ( SELECT @r := 0 ) b ) tb ON bs1.id = tb.id
    SET bs1.id = tb.row_num;

ALTER TABLE in_interrogator DROP COLUMN `iddd`;
ALTER TABLE in_interrogator MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键';

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

ALTER TABLE `in_legal` ADD  `start_type` int(2) NOT NULL COMMENT '开始笔录时的笔录类型';

UPDATE `in_legal` SET `start_type` = 0;

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
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

-- INSERT INTO in_case_config (case_id, user_id, user_name, room_id, rtsp_url, burn_type, burn_enabled, video_enabled,
-- audio_enabled, start_type, premium, is_over, gmt_create, gmt_modify) SELECT i.id AS case_id,
-- IFNULL( u.user_id, '未知' ) AS user_id, IFNULL(u.user_name,'未知') AS user_name, i.room_id AS room_id, i.rtsp_url AS rtsp_url,
-- NULL AS burn_type, FALSE AS burn_enabled, i.video AS video_enabled, TRUE AS audio_enabled, 0 AS start_type,
-- FALSE AS premium, (CASE i.`status` WHEN i.`status` = 0 THEN FALSE WHEN i.`status`=2 THEN FALSE ELSE TRUE END ) AS is_over,
-- i.create_time AS gmt_create, IFNULL(i.stop_time,i.create_time) AS gmt_modify
-- FROM in_case i LEFT JOIN app_uac.uac_users u ON i.`owner` = u.user_id;

INSERT INTO in_case_config (case_id, user_id, user_name, room_id, rtsp_url, burn_type, burn_enabled, video_enabled,
audio_enabled, start_type, premium, is_over, gmt_create, gmt_modify) SELECT i.id AS case_id,
IFNULL( u.user_id, '未知' ) AS user_id, IFNULL(u.user_name,'未知') AS user_name, i.room_id AS room_id, i.rtsp_url AS rtsp_url,
NULL AS burn_type, FALSE AS burn_enabled, i.video AS video_enabled, TRUE AS audio_enabled, 0 AS start_type,
FALSE AS premium, (CASE i.`status` WHEN i.`status` = 0 THEN FALSE WHEN i.`status`=2 THEN FALSE ELSE TRUE END ) AS is_over,
i.create_time AS gmt_create, IFNULL(i.stop_time,i.create_time) AS gmt_modify
FROM in_case i LEFT JOIN uac.uac_users u ON i.`owner` = u.user_id;

ALTER TABLE `in_case` DROP COLUMN `rtsp_url`,DROP COLUMN `video`;

ALTER TABLE `in_case_person` CHANGE `relation` `relation_id` varchar(50) DEFAULT NULL COMMENT '与被审讯人关系ID(字典)';
ALTER TABLE `in_case_person` CHANGE `language` `language_id` varchar(50) DEFAULT NULL COMMENT '翻译语种ID(字典)';

CREATE TABLE IF NOT EXISTS `in_case_export_file` (
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

CREATE TABLE IF NOT EXISTS `in_user_skin` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
    `skin_code` int(2) NOT NULL COMMENT '皮肤编码',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户换肤表';

CREATE TABLE IF NOT EXISTS `in_user_room` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
    `room_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户房间表';

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

UPDATE in_params SET id = 'appId' WHERE id = 'app_id';
UPDATE in_params SET id = 'autoSaveTime' WHERE id = 'auto_save_time';
UPDATE in_params SET id = 'badLanguage' WHERE id = 'bad_language';
UPDATE in_params SET id = 'homophoneCheck' WHERE id = 'homophone_check';
UPDATE in_params SET id = 'systemName' WHERE id = 'system_name';
UPDATE in_params SET id = 'systemLogo' WHERE id = 'system_logo';
UPDATE in_params SET id = 'systemSupport' WHERE id = 'system_support';

DELETE FROM in_params WHERE id NOT IN ('appId','isService','industry','jtts','systemName','systemLogo', 'systemSupport','nlp','vod', 'autoSaveTime','badLanguage','homophoneCheck','nlpMoodKeyword','exportAudio','exportVideo','exportWord');

-- 添加溯源时间字段
ALTER TABLE ibcp_nlp_individual ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE ibcp_nlp_keyword ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE ibcp_nlp_mood_word ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE ibcp_nlp_sensitive ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE ibcp_nlp_term ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE ibcp_nlp_sensitive CHANGE `replace` `replace_word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '替换词';

ALTER TABLE in_case ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_case_attachment ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_case_content ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_case_person ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_dict ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_industry ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_interrogator ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_laws ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_laws_content ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_legal ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_legal_user ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_letter_auth ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_log ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_params ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_person ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_person_legal ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_template ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_template_content ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE in_undertaker ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE local_file ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';
ALTER TABLE view_file ADD `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',ADD `gmt_modify` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间';

-- 解决关键字冲突问题
ALTER TABLE view_file CHANGE `domain` `domain_lang` int(11) NOT NULL COMMENT '领域\r\n0 普通话\r\n1 粤语';

-- 新版转录路径可配置化
UPDATE local_file SET file_path = SUBSTR(file_path, LOCATE('transFile', file_path) + LENGTH('transFile'), LENGTH(file_path)) WHERE LOCATE('transFile', file_path) > 0;