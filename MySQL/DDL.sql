-- 修改字段
ALTER Table `table` MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
ALTER Table `table` CHANGE `id` `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

-- 添加字段
ALTER Table `table` ADD `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '主键';

-- 添加索引
ALTER Table `table` ADD UNIQUE INDEX `term`(`term`) USING BTREE;

-- 删除索引
ALTER TABLE `table` DROP INDEX `fk_in_case_owner_in_user`;
 
-- 添加表注释
ALTER Table `table` COMMENT '词性字典表';

-- 删除字段
ALTER TABLE `table` DROP COLUMN `id`;

-- 删除主键
ALTER Table `table` DROP PRIMARY KEY;

-- 删除表
DROP TABLE IF EXISTS `table`;