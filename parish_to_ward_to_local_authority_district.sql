-- https://geoportal.statistics.gov.uk/datasets/ons::parish-to-ward-to-local-authority-district-december-2020-lookup-in-england-and-wales-v2-1/about
-- FID,PAR20CD,PAR20NM,WD20CD,WD20NM,LAD20CD,LAD20NM
-- 1,E04011378,Welshampton and Lyneal,E05008192,The Meres,E06000051,Shropshire

DROP TABLE IF EXISTS parish_ward_lad_lookup;


create table parish_ward_lad_lookup (
    fid BIGINT unsigned primary key,
    par_code char(9) COMMENT 'ONS parish code',
    par_name varchar(255) COMMENT 'ONS parish name',
    ward_code char(9) COMMENT 'ONS ward code',
    ward_name varchar(255) COMMENT 'ONS Ward Name',
    lad_code char(9) COMMENT 'ONS Local Authority District Code (divisions table)',
    lad_name varchar(255) COMMENT 'ONS Local Authority District Name (divisions table)'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'parishes can straddle boundaries - not a clear hierarchical relationship. Parish_to_Ward_to_Local_Authority_District_\(December_2020\)_Lookup_in_England_and_Wales_V2.csv';



LOAD DATA LOCAL INFILE 'Parish_to_Ward_to_Local_Authority_District_\(December_2020\)_Lookup_in_England_and_Wales_V2.csv'
    INTO TABLE parish_ward_lad_lookup
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES; -- header
