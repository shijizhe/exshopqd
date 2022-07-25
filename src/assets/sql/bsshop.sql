/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50734
Source Host           : localhost:3306
Source Database       : bsshop

Target Server Type    : MYSQL
Target Server Version : 50734
File Encoding         : 65001

Date: 2022-07-25 22:06:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `adid` int(20) NOT NULL AUTO_INCREMENT,
  `aduserid` int(20) DEFAULT NULL,
  `adname` varchar(255) DEFAULT NULL,
  `adphone` varchar(30) DEFAULT NULL,
  `adprovince` varchar(255) DEFAULT NULL COMMENT '一级',
  `adcity` varchar(255) DEFAULT NULL COMMENT '二级',
  `adcounty` varchar(255) DEFAULT NULL COMMENT '三级',
  `adpca` varchar(255) DEFAULT NULL,
  `addetail` varchar(255) DEFAULT NULL,
  `adisdefault` int(2) DEFAULT '0',
  PRIMARY KEY (`adid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('14', '1', 'Ya', '123456789', '山东省', '青岛市', '黄岛区', '370211', '中国石油大学', '0');
INSERT INTO `address` VALUES ('15', '1', '小黑', '8888888', '北京市', '市辖区', '东城区', '110101', '凤凰小区', '0');
INSERT INTO `address` VALUES ('16', '1', '小明', '123456', '辽宁省', '沈阳市', '和平区', '210102', '英才小学', '0');
INSERT INTO `address` VALUES ('17', '3', '石际哲', '666666', '山东省', '青岛市', '黄岛区', '370211', '19号楼360', '1');
INSERT INTO `address` VALUES ('18', '2', '收货人root', '12321', '内蒙古自治区', '赤峰市', '阿鲁科尔沁旗', '150421', '蒙古草原', '0');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `ca_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ca_name` varchar(255) NOT NULL,
  `ca_parent_id` bigint(20) DEFAULT NULL,
  `ca_level` int(20) NOT NULL,
  `ca_group` varchar(255) DEFAULT 'goods',
  `ca_icon` varchar(255) DEFAULT NULL,
  `ca_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ca_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '书籍资料', '0', '1', 'goods', 'el-icon-reading', null);
INSERT INTO `category` VALUES ('2', '数码电器', '0', '1', 'goods', 'el-icon-mobile-phone', null);
INSERT INTO `category` VALUES ('3', '服装配饰', '0', '1', 'goods', 'el-icon-user', null);
INSERT INTO `category` VALUES ('4', '运动户外', '0', '1', 'goods', 'el-icon-basketball', null);
INSERT INTO `category` VALUES ('5', '生活百货', '0', '1', 'goods', 'el-icon-food', null);
INSERT INTO `category` VALUES ('11', '书籍', '1', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('12', '文具教具', '1', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('21', '手机', '2', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('22', '电脑', '2', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('23', '相机', '2', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('24', '数码配件', '2', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('31', '男装', '3', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('32', '女装', '3', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('33', '男鞋', '3', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('34', '女鞋', '3', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('35', '配饰', '3', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('41', '运动穿搭', '4', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('42', '体育运动', '4', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('43', '小众运动', '4', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('51', '家用电器', '5', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('52', '家居用品', '5', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('53', '美妆个护', '5', '2', 'goods', null, null);
INSERT INTO `category` VALUES ('54', '办公用品', '5', '2', 'goods', null, null);

-- ----------------------------
-- Table structure for excharity
-- ----------------------------
DROP TABLE IF EXISTS `excharity`;
CREATE TABLE `excharity` (
  `ch_id` int(11) NOT NULL AUTO_INCREMENT,
  `ch_name` varchar(255) DEFAULT NULL,
  `ch_content` varchar(255) DEFAULT NULL,
  `ch_userid` int(11) DEFAULT NULL,
  `ch_phone` varchar(255) DEFAULT NULL,
  `ch_createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ch_status` int(5) DEFAULT '0',
  PRIMARY KEY (`ch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of excharity
-- ----------------------------
INSERT INTO `excharity` VALUES ('1', '少年衣服需求', '太康县李庄需要一些小朋友穿的衣服，要求只要整洁就好，有意请联系。石先生', '1', '7777', '2021-05-23 22:07:46', '3');
INSERT INTO `excharity` VALUES ('4', '山区图书馆', '四川某乡构建山区乡村图书馆，希望广大网友援助一些适合青少年看的书籍，有意向联系，程小姐。', '1', '88888888', '2021-05-23 22:07:48', '2');
INSERT INTO `excharity` VALUES ('7', '测试申请', '测试中', '1', '1234', '2021-05-24 11:04:05', '2');
INSERT INTO `excharity` VALUES ('8', '测试公益', '这是一个测试公益', '3', '15254511511', '2021-06-15 23:23:38', '2');
INSERT INTO `excharity` VALUES ('9', '测试公益2', '这是一个测试公益', '3', '1111111', '2021-06-15 23:24:05', '3');
INSERT INTO `excharity` VALUES ('10', '测试公益3', '这是一个测试公益', '3', '88888888', '2021-06-15 23:26:49', '0');

-- ----------------------------
-- Table structure for excomment
-- ----------------------------
DROP TABLE IF EXISTS `excomment`;
CREATE TABLE `excomment` (
  `cm_id` int(20) NOT NULL AUTO_INCREMENT,
  `cm_orderid` int(20) NOT NULL,
  `cm_goodsid` int(20) DEFAULT NULL,
  `cm_sellerid` int(20) DEFAULT NULL,
  `cm_reply` varchar(255) DEFAULT NULL,
  `cm_buyerid` int(20) DEFAULT NULL,
  `cm_star` int(10) DEFAULT NULL,
  `cm_content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of excomment
-- ----------------------------
INSERT INTO `excomment` VALUES ('1', '16', '2', '1', 'bb', '2', '3', 'aa');
INSERT INTO `excomment` VALUES ('2', '19', '21', '1', 'haode', '2', '4', 'aaa');
INSERT INTO `excomment` VALUES ('3', '22', '23', '1', 'xiexie', '3', '4', 'henmanyi');
INSERT INTO `excomment` VALUES ('4', '23', '31', '3', 'xiexieninde pignjia', '1', '5', 'henhao');

-- ----------------------------
-- Table structure for exnote
-- ----------------------------
DROP TABLE IF EXISTS `exnote`;
CREATE TABLE `exnote` (
  `n_id` int(20) NOT NULL AUTO_INCREMENT,
  `n_title` varchar(255) DEFAULT NULL,
  `n_content` varchar(255) DEFAULT NULL,
  `n_admin_id` int(20) DEFAULT NULL,
  `n_createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`n_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exnote
-- ----------------------------
INSERT INTO `exnote` VALUES ('2', '庆祝建站活动', '所有平台下单的用户将会获得一定数额的激励金，快邀请亲友们下单呀！', '1', '2021-05-19 11:04:24');
INSERT INTO `exnote` VALUES ('6', '更新通知', '平台于本周五进行更新，请注意', '1', '2021-05-19 14:31:25');

-- ----------------------------
-- Table structure for exorder
-- ----------------------------
DROP TABLE IF EXISTS `exorder`;
CREATE TABLE `exorder` (
  `or_id` int(20) NOT NULL AUTO_INCREMENT,
  `or_no` varchar(255) DEFAULT NULL,
  `or_seller_id` int(20) DEFAULT NULL,
  `or_goods_id` int(20) DEFAULT NULL,
  `or_goods_num` int(20) DEFAULT NULL,
  `or_price` int(20) DEFAULT NULL,
  `or_adress_id` int(20) DEFAULT NULL,
  `or_status` int(20) DEFAULT '1' COMMENT '1：用户下单',
  `or_buyer_id` int(20) DEFAULT NULL,
  `or_expressno` varchar(30) DEFAULT NULL,
  `or_expresstype` varchar(20) DEFAULT NULL,
  `or_updatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`or_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exorder
-- ----------------------------
INSERT INTO `exorder` VALUES ('16', '4883626661220003', '1', '2', '1', '59', '17', '5', '2', '773096380913475', 'STO', '2021-05-20 20:53:55');
INSERT INTO `exorder` VALUES ('17', '8808866887570003', '2', '16', '1', '1', '17', '1', '3', null, null, '2021-05-19 17:48:08');
INSERT INTO `exorder` VALUES ('18', '5063327775220001', '3', '13', '1', '129', '16', '1', '1', null, null, '2021-05-19 17:49:37');
INSERT INTO `exorder` VALUES ('19', '7254716032640002', '1', '21', '1', '309', '18', '5', '2', '773098328703792', 'STO', '2021-05-21 15:03:23');
INSERT INTO `exorder` VALUES ('20', '9781759750690003', '1', '10', '1', '129', '17', '1', '3', null, null, '2021-05-29 10:06:15');
INSERT INTO `exorder` VALUES ('21', '1898067575000001', '2', '1', '1', '2999', '14', '1', '1', null, null, '2021-05-29 11:09:17');
INSERT INTO `exorder` VALUES ('22', '2185809622790003', '1', '23', '2', '24', '17', '5', '3', '773098328703792', 'STO', '2021-06-15 13:29:22');
INSERT INTO `exorder` VALUES ('23', '1971079511930001', '3', '31', '2', '240', '14', '5', '1', '773098328703792', 'STO', '2021-06-15 19:19:11');
INSERT INTO `exorder` VALUES ('24', '8642250305930001', '3', '33', '2', '258', '14', '1', '1', null, null, '2021-06-16 09:30:30');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `gid` bigint(20) NOT NULL AUTO_INCREMENT,
  `gname` varchar(255) NOT NULL,
  `gcateid` bigint(20) DEFAULT NULL,
  `gownerid` bigint(20) DEFAULT NULL,
  `gprice` bigint(20) DEFAULT NULL,
  `gdetail` varchar(255) DEFAULT NULL,
  `gison` int(20) DEFAULT '1',
  `gcover` varchar(255) DEFAULT NULL,
  `gaddtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gupdatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '小米mix2S', '21', '2', '2999', '95新全陶瓷白色', '2', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/mix2s.jpeg', '2021-04-28 09:56:35', '2021-05-29 11:09:17');
INSERT INTO `goods` VALUES ('2', '《红楼梦》', '21', '1', '59', '全新', '2', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/redlowdream.jpg', '2021-04-29 12:01:27', '2021-05-23 14:38:42');
INSERT INTO `goods` VALUES ('10', '手环', '24', '1', '129', '全新防水523', '2', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/handhuan.jpeg', '2021-05-07 14:19:45', '2021-05-29 10:06:15');
INSERT INTO `goods` VALUES ('12', 'QCYT8', '24', '1', '89', '99新；蓝牙耳机；白色；淘宝官方正品', '1', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/qcyT8.jpg', '2021-05-11 10:58:24', '2021-05-23 17:55:48');
INSERT INTO `goods` VALUES ('13', '商品1', '11', '3', '129', '无', '2', null, '2021-05-17 11:11:47', '2021-05-19 17:49:37');
INSERT INTO `goods` VALUES ('16', '测试商品2', '23', '2', '1', '1', '2', null, '2021-05-19 15:28:27', '2021-05-19 17:48:08');
INSERT INTO `goods` VALUES ('21', '内存条', '24', '1', '309', '8G；笔记本通用', '2', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/neicuntiao.jpg', '2021-05-21 15:01:32', '2021-05-23 14:38:55');
INSERT INTO `goods` VALUES ('23', 'ceshi', '11', '1', '12', '2131', '2', '', '2021-06-15 13:28:39', '2021-06-15 17:08:22');
INSERT INTO `goods` VALUES ('26', '测试商品3', '11', '2', '2', '1', '0', null, '2021-05-19 15:28:35', '2021-05-19 16:40:46');
INSERT INTO `goods` VALUES ('27', '测试商品5', '11', '2', '2', '2', '0', null, '2021-05-19 15:28:43', '2021-05-19 16:40:47');
INSERT INTO `goods` VALUES ('28', '测试商品6', '11', '2', '2', '1', '0', null, '2021-05-19 15:28:54', '2021-05-19 16:40:49');
INSERT INTO `goods` VALUES ('29', '测试商品7', '43', '2', '1', '1', '0', null, '2021-05-19 15:31:32', '2021-05-19 16:40:50');
INSERT INTO `goods` VALUES ('30', '想赚钱，赶紧来', '11', '4', '1', 'qwea@c。o。m来了你就知道', '1', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/harmful.jpg', '2021-06-15 16:21:14', '2021-06-15 16:21:14');
INSERT INTO `goods` VALUES ('31', 'test', '11', '3', '120', '111', '2', null, '2021-06-15 19:16:21', '2021-06-15 19:19:11');
INSERT INTO `goods` VALUES ('32', '封禁商品', '11', '3', '129', '测试', '0', null, '2021-06-15 19:50:22', '2021-06-15 20:46:04');
INSERT INTO `goods` VALUES ('33', '李宁运动鞋', '33', '3', '129', '全新，未穿。尺码：42', '2', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/lining.jpg', '2021-05-10 14:40:14', '2021-06-16 09:30:30');
INSERT INTO `goods` VALUES ('35', '沙发', '52', '3', '1299', '自己用了一年；搬家了用不着；9成新', '1', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/shafa.jpg', '2021-05-17 11:12:03', '2021-06-15 20:46:08');
INSERT INTO `goods` VALUES ('36', '篮球', '42', '3', '99', '刚买的；全新', '1', 'http://qtg6q2mj3.hd-bkt.clouddn.com/goods/cover/lanqiu.jpg', '2021-05-18 16:50:22', '2021-06-15 20:46:11');
INSERT INTO `goods` VALUES ('39', '123', '11', '6', '123', '123', '0', null, '2021-06-15 20:01:16', '2021-06-15 20:01:16');

-- ----------------------------
-- Table structure for harminfo
-- ----------------------------
DROP TABLE IF EXISTS `harminfo`;
CREATE TABLE `harminfo` (
  `ha_id` int(20) NOT NULL AUTO_INCREMENT,
  `ha_userid` int(20) DEFAULT NULL,
  `ha_goodsid` int(20) DEFAULT NULL,
  `ha_count` int(20) DEFAULT '1',
  `ha_result` int(20) DEFAULT NULL COMMENT 'ban-day',
  `ha_reason` varchar(255) DEFAULT NULL,
  `ha_option` varchar(255) DEFAULT NULL COMMENT 'user;goods',
  `ha_createdtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ha_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of harminfo
-- ----------------------------
INSERT INTO `harminfo` VALUES ('5', '2', '1', '1', '1', '123', 'user', '2021-05-23 17:58:54');
INSERT INTO `harminfo` VALUES ('6', '1', '12', '1', null, '123', 'goods', '2021-05-23 18:11:39');
INSERT INTO `harminfo` VALUES ('7', '2', '20', '1', '7', 'shi', 'user', '2021-05-29 10:50:09');
INSERT INTO `harminfo` VALUES ('8', '1', '23', '1', null, 'shi', 'goods', '2021-06-15 13:28:57');
INSERT INTO `harminfo` VALUES ('9', '3', '32', '3', '3', '615ceshi', 'user', '2021-06-15 19:50:34');
INSERT INTO `harminfo` VALUES ('10', '6', '39', '1', '1', '发布垃圾商品', 'user', '2021-06-15 20:36:17');
INSERT INTO `harminfo` VALUES ('11', '4', '30', '1', null, null, null, '2021-06-16 09:30:09');

-- ----------------------------
-- Table structure for orderstatus
-- ----------------------------
DROP TABLE IF EXISTS `orderstatus`;
CREATE TABLE `orderstatus` (
  `sa_id` int(11) NOT NULL AUTO_INCREMENT,
  `sa_orderid` int(11) DEFAULT NULL,
  `sa_ordernum` varchar(20) DEFAULT NULL,
  `sa_status` int(2) DEFAULT NULL,
  `sa_statusinfo` varchar(255) DEFAULT NULL,
  `sa_creadtedtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sa_exinfo1` varchar(255) DEFAULT NULL,
  `sa_exinfo2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderstatus
-- ----------------------------
INSERT INTO `orderstatus` VALUES ('1', '5', '5596467986380001', '1', '用户下单', '2021-05-17 11:06:38', null, null);
INSERT INTO `orderstatus` VALUES ('2', '6', '5890251348720001', '1', '用户下单', '2021-05-17 11:12:14', null, null);
INSERT INTO `orderstatus` VALUES ('3', '7', '4429687972420001', '1', '用户下单', '2021-05-17 14:59:57', null, null);
INSERT INTO `orderstatus` VALUES ('4', '8', '5980640295530003', '1', '用户下单', '2021-05-17 19:30:29', null, null);
INSERT INTO `orderstatus` VALUES ('5', '9', '7363187805320001', '1', '用户下单', '2021-05-18 16:49:40', null, null);
INSERT INTO `orderstatus` VALUES ('6', '10', '9234621753630001', '1', '用户下单', '2021-05-19 10:09:35', null, null);
INSERT INTO `orderstatus` VALUES ('7', '11', '9311940882240001', '1', '用户下单', '2021-05-19 16:14:48', null, null);
INSERT INTO `orderstatus` VALUES ('8', '12', '7370438550430001', '1', '用户下单', '2021-05-19 16:27:35', null, null);
INSERT INTO `orderstatus` VALUES ('9', '13', '9869892446550001', '1', '用户下单', '2021-05-19 16:34:04', null, null);
INSERT INTO `orderstatus` VALUES ('10', '14', '8152553674370001', '1', '用户下单', '2021-05-19 16:36:07', null, null);
INSERT INTO `orderstatus` VALUES ('11', '15', '6743994094150001', '1', '用户下单', '2021-05-19 16:36:49', null, null);
INSERT INTO `orderstatus` VALUES ('12', '16', '4883626661220003', '1', '用户下单', '2021-05-19 17:47:46', null, null);
INSERT INTO `orderstatus` VALUES ('13', '17', '8808866887570003', '1', '用户下单', '2021-05-19 17:48:08', null, null);
INSERT INTO `orderstatus` VALUES ('14', '18', '5063327775220001', '1', '用户下单', '2021-05-19 17:49:37', null, null);
INSERT INTO `orderstatus` VALUES ('17', '16', '4883626661220003', '3', '商家发货', '2021-05-20 15:48:15', 'STO', '773096380913475');
INSERT INTO `orderstatus` VALUES ('18', '16', '4883626661220003', '4', '用户签收', '2021-05-20 16:02:01', 'STO', '773096380913475');
INSERT INTO `orderstatus` VALUES ('20', '16', '4883626661220003', '5', '用户评价完成', '2021-05-20 21:51:33', '3', 'aa');
INSERT INTO `orderstatus` VALUES ('21', '19', '7254716032640002', '1', '用户下单', '2021-05-21 15:03:23', null, null);
INSERT INTO `orderstatus` VALUES ('22', '19', '7254716032640002', '3', '商家发货', '2021-05-21 15:03:40', 'STO', '773098328703792');
INSERT INTO `orderstatus` VALUES ('23', '19', '7254716032640002', '4', '用户签收', '2021-05-21 15:21:45', 'STO', '773098328703792');
INSERT INTO `orderstatus` VALUES ('24', '19', '7254716032640002', '5', '用户评价完成', '2021-05-21 15:21:50', '4', 'aaa');
INSERT INTO `orderstatus` VALUES ('25', '20', '9781759750690003', '1', '用户下单', '2021-05-29 10:06:15', null, null);
INSERT INTO `orderstatus` VALUES ('26', '21', '1898067575000001', '1', '用户下单', '2021-05-29 11:09:17', null, null);
INSERT INTO `orderstatus` VALUES ('27', '22', '2185809622790003', '1', '用户下单', '2021-06-15 13:29:22', null, null);
INSERT INTO `orderstatus` VALUES ('28', '22', '2185809622790003', '3', '商家发货', '2021-06-15 13:30:15', 'STO', '773098328703792');
INSERT INTO `orderstatus` VALUES ('29', '22', '2185809622790003', '4', '用户签收', '2021-06-15 13:30:56', 'STO', '773098328703792');
INSERT INTO `orderstatus` VALUES ('30', '22', '2185809622790003', '5', '用户评价完成', '2021-06-15 13:31:16', '4', 'henmanyi');
INSERT INTO `orderstatus` VALUES ('31', '23', '1971079511930001', '1', '用户下单', '2021-06-15 19:19:11', null, null);
INSERT INTO `orderstatus` VALUES ('32', '23', '1971079511930001', '3', '商家发货', '2021-06-15 19:19:48', 'STO', '773098328703792');
INSERT INTO `orderstatus` VALUES ('33', '23', '1971079511930001', '4', '用户签收', '2021-06-15 19:22:01', 'STO', '773098328703792');
INSERT INTO `orderstatus` VALUES ('34', '23', '1971079511930001', '5', '用户评价完成', '2021-06-15 19:22:22', '5', 'henhao');
INSERT INTO `orderstatus` VALUES ('35', '24', '8642250305930001', '1', '用户下单', '2021-06-16 09:30:30', null, null);

-- ----------------------------
-- Table structure for slidepic
-- ----------------------------
DROP TABLE IF EXISTS `slidepic`;
CREATE TABLE `slidepic` (
  `sli_id` int(20) NOT NULL AUTO_INCREMENT,
  `sli_userid` int(20) DEFAULT NULL,
  `sli_title` varchar(255) DEFAULT NULL,
  `sli_src` varchar(255) DEFAULT NULL,
  `sli_isuse` int(20) DEFAULT '1',
  `sli_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sli_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slidepic
-- ----------------------------
INSERT INTO `slidepic` VALUES ('9', '1', '图片1', 'http://qtg6q2mj3.hd-bkt.clouddn.com/manage/slidepicure/gga.png', '1', 'http://shop.kongfz.com/19661/special/75377');
INSERT INTO `slidepic` VALUES ('10', '1', '图片2', 'http://qtg6q2mj3.hd-bkt.clouddn.com/manage/slidepicure/ggc.png', '1', 'http://promotion.kongfz.com/promotion/SouthAsia_pc');
INSERT INTO `slidepic` VALUES ('11', '1', '图片3', 'http://qtg6q2mj3.hd-bkt.clouddn.com/manage/slidepicure/ggb.png', '1', 'http://shop.kongfz.com/19661/special/75301');
INSERT INTO `slidepic` VALUES ('14', '1', '图片4', 'http://qtg6q2mj3.hd-bkt.clouddn.com/manage/slidepicure/ggd.png', '1', 'http://shop.kongfz.com/19661/special/75392');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uname` varchar(255) NOT NULL,
  `uavatar` varchar(255) DEFAULT NULL,
  `upassword` varchar(255) NOT NULL,
  `uphone` varchar(255) NOT NULL,
  `umail` varchar(255) DEFAULT NULL,
  `urole` int(20) DEFAULT '0',
  `uisban` int(20) DEFAULT '0',
  `ubandate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'http://qtg6q2mj3.hd-bkt.clouddn.com/user/avatar/1619427442358.jpg', '123456', '15288888800', 'shijizhe@qq.com', '1', '0', '2021-04-22 00:05:36');
INSERT INTO `user` VALUES ('2', 'root', 'http://qtg6q2mj3.hd-bkt.clouddn.com/user/avatar/1619427442362.jpg', '123456', '15254511512', null, '1', '1', '2021-06-22 13:34:02');
INSERT INTO `user` VALUES ('3', 'user', 'http://qtg6q2mj3.hd-bkt.clouddn.com/user/avatar/1619427442380.jpg', '123456', '15254511519', '', '0', '0', '2021-06-14 20:25:39');
INSERT INTO `user` VALUES ('4', 'harm', 'http://qtg6q2mj3.hd-bkt.clouddn.com/user/avatar/e5edd2774b335e361b72bd105e5ad63d.jpeg', '123456', '15254511510', null, '0', '0', '2021-06-15 16:11:39');
INSERT INTO `user` VALUES ('5', 'dabian', 'http://qtg6q2mj3.hd-bkt.clouddn.com/user/avatar/1619427442354.png', '123456', '15254511513', null, '0', '0', '2021-06-15 16:23:54');
INSERT INTO `user` VALUES ('6', 'abc', null, '123456', '15254512301', null, '0', '1', '2021-06-16 20:36:57');
