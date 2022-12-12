
-- https://geoportal.statistics.gov.uk/search?collection=Dataset&sort=-created&tags=all(PRD_NSPL)

DROP TABLE IF EXISTS nspl;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS counties;
DROP TABLE IF EXISTS divsions;
DROP TABLE IF EXISTS wards;
DROP TABLE IF EXISTS pfas;
DROP TABLE IF EXISTS parls;
DROP TABLE IF EXISTS divisions;
DROP TABLE IF EXISTS lads;


Create table nspl (
    pcd varchar(7) COMMENT 'All current live postcodes within the United Kingdom',
    pcd2 char(8) COMMENT '5th character always blank and 3rd and 4th characters may be blank ',
    pcds varchar(8) COMMENT 'I think this is the usual UK postcode format',
    dointr char(6) COMMENT 'Date of introduction YYYYMM',
    doterm char(6) COMMENT 'Date of termination YYYYMM',
    usertype tinyint COMMENT '0 small uer, 1 large user',
    oseast1m integer COMMENT 'The OS grid reference Easting to 1 metre resolution',
    osnrth1m integer COMMENT 'The OS grid reference Northing to 1 metre resolution',
    osgrdind integer COMMENT 'status of gridref  - 1 good to 9 bad',
    oa11 char(9) COMMENT 'Census Output Area',
    cty char(9) COMMENT 'County',
    ced char(9) COMMENT 'County Electoral Division',
    laua char(9) COMMENT '(lad) Local Authority District (LAD) - unitary authority (UA)/non- metropolitan district (NMD)/ metropolitan district (MD)/ London borough (LB)/ council area (CA)/district council area (DCA)',
    ward char(9) COMMENT 'The current administrative/electoral area to which the postcode has been assigned. Pseudo codes are included for Channel Islands and Isle of Man.',
    hlthau char(9) COMMENT 'The health area code for the postcode. SHAs were abolished in England in 2013',
    nhser char(9) COMMENT 'NHS region',
    ctry char(9) COMMENT 'Country',
    rgn char(9) COMMENT 'Region',
    pcon char(9) COMMENT 'Westminster parliamentary constituency',
    eer char(9) COMMENT 'European Electoral Region',
    teclec char(9) COMMENT 'Local Learning and Skills Counci',
    ttwa char(9) COMMENT 'Travel to Work Area',
    pct char(9) COMMENT 'Primary Care Trust',
    itl char(9) COMMENT 'International Territorial Level',
    park char(9) COMMENT 'National park',
    lsoa11 char(9) COMMENT 'Lower Layer Super Output Area',
    msoa11 char(9) COMMENT 'Middle Layer Super Output Area',
    wz11 char(9) COMMENT 'Workplace Zone',
    ccg char(9) COMMENT 'Sub ICB Location - health related',
    bua11 char(9) COMMENT 'Built-up Area',
    buasd11 char(9) COMMENT 'Built-up Area Sub-division',
    ru11ind char(9) COMMENT 'rural-urban classification',
    oac11 char(9) COMMENT 'Census Output Area classification',
    lat char(9) COMMENT 'The postcode coordinates in degrees latitude to six decimal places',
    `long` char(9) COMMENT 'The postcode coordinates in degrees longitude to six decimal places',
    lep1 char(9) COMMENT 'The primary LEP code',
    lep2 char(9) COMMENT 'Where LEPs overlap, the secondary code for each affected English postcode',
    pfa char(9) COMMENT 'The PFA code for each postcode.',
    imd char(9) COMMENT 'Index of Multiple Deprivation',
    calncv char(9) COMMENT 'Cancer Alliance code',
    stp char(9) COMMENT 'Integrated Care Board'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'National Statistics Postcode Lookup NSPL';

LOAD DATA LOCAL INFILE 'NSPL/Data/NSPL_NOV_2022_UK.csv'
    INTO TABLE nspl
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    IGNORE 1 LINES;

-- faster to create indexes after data load

create index idx_nspl_pcds on nspl (pcds);
create index idx_nspl_cty on nspl (cty);
create index idx_nspl_ward on nspl (ward);
create index idx_nspl_pcon on nspl (pcon);
create index idx_nspl_region on nspl (rgn);
create index idx_nspl_pfa on nspl (pfa);



CREATE TABLE parls (
    code char(9),
    name varchar(255)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'Westminster Parliamentary Constituency names and codes UK as at 12_14';

LOAD DATA LOCAL INFILE 'NSPL/Documents/Westminster Parliamentary Constituency names and codes UK as at 12_14.csv'
    INTO TABLE parls
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;


CREATE TABLE regions (
    code char(9),
    lettercode char(1),
    name varchar(255),
    welsh_name varchar(255)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

LOAD DATA LOCAL INFILE 'NSPL/Documents/Region names and codes EN as at 12_20 (RGN).csv'
    INTO TABLE regions
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

CREATE TABLE countries (
    code char(9),
    codenum INT,
    name varchar(255),
    welsh_name varchar(255)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'Country names and codes UK as at 08_12';

LOAD DATA LOCAL INFILE 'NSPL/Documents/Country names and codes UK as at 08_12.csv'
    INTO TABLE countries
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;


CREATE TABLE wards (
    code char(9),
    name varchar(255)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

LOAD DATA LOCAL INFILE 'NSPL/Documents/Ward names and codes UK as at 05_21 NSPL.csv'
    INTO TABLE wards
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

create index idx_ward_name on wards (name);
create index idx_ward_code on wards (code);

CREATE TABLE pfas (
    code char(9),
    name varchar(255)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

LOAD DATA LOCAL INFILE 'NSPL/Documents/PFA names and codes GB as at 12_15.csv'
    INTO TABLE pfas
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

CREATE TABLE divisions (
    code char(9),
    name varchar(255)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'County Electoral Division names and codes EN as at 05_21';


LOAD DATA LOCAL INFILE 'NSPL/Documents/County Electoral Division names and codes EN as at 05_21.csv'
    INTO TABLE divisions
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

CREATE TABLE counties (
    code char(9),
    name varchar(255)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;


LOAD DATA LOCAL INFILE 'NSPL/Documents/County names and codes UK as at 04_21_NSPL.csv'
    INTO TABLE counties
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;


CREATE TABLE lads (
    code char(9),
    name varchar(255)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT '(laua - LAD) LA_UA names and codes UK as at 04_21 ';

LOAD DATA LOCAL INFILE 'NSPL/Documents/LA_UA names and codes UK as at 04_21.csv'
    INTO TABLE lads
    CHARACTER SET utf8mb4
    COLUMNS TERMINATED by ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

