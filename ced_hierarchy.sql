DROP TABLE IF EXISTS ced_hierarchy;

create table ced_hierarchy (
    id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    ced_code char(9) COMMENT 'ward code',
    ced_name varchar(255),
    cty_name varchar(255),
    cty_code char(9) COMMENT 'County code',
    ctry_name varchar(255),
    ctry_code char(9) COMMENT ' country code',
    Primary key (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'full names and codes for County Electoral Divisions, counties';



insert into ced_hierarchy (
        ced_code,
        cty_code,
        ctry_code
    )
select distinct ced as ced_code,
    cty as cty_code,
    ctry as ctry_code
from nspl;
create index idx_ced_ced on ced_hierarchy (ced_code);
create index idx_ced_cty on ced_hierarchy (cty_code);
create index idx_ced_ctry on ced_hierarchy (ctry_code);
update ced_hierarchy
    inner join divisions on ced_code = divisions.code
set ced_name = divisions.name;
update ced_hierarchy
    inner join countries on ctry_code = countries.code
set ctry_name = countries.name;
update ced_hierarchy
    inner join counties on cty_code = counties.code
set cty_name = counties.name;
