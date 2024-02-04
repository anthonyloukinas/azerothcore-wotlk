-- DB update 2019_05_12_00 -> 2019_05_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2019_05_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2019_05_12_00 2019_05_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1557226918417685700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1557226918417685700');

ALTER TABLE `character_arena_stats`
MODIFY `guid` int(10) unsigned NOT NULL DEFAULT '0',
MODIFY `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
MODIFY `matchMakerRating` smallint(5) unsigned NOT NULL DEFAULT '0';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;