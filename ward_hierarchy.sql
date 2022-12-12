DROP TABLE IF EXISTS ward_hierarchy;

create table ward_hierarchy (
    id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    ward_code char(9) COMMENT 'ward code',
    ward_name varchar(255),
    lad_name varchar(255),
    lad_code char(9) COMMENT 'Local Authority District code (Different to County Election Division)',
    cty_name varchar(255),
    cty_code char(9) COMMENT 'County code',
    ctry_name varchar(255),
    ctry_code char(9) COMMENT ' country code',
    Primary key (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'full names and codes for wards, districts, counties';


insert into ward_hierarchy (
        ward_code,
        lad_code,
        cty_code,
        ctry_code
    )
select distinct ward as ward_code,
    laua as lad_code,
    cty as cty_code,
    ctry as ctry_code
from nspl;
create index idx_wh_ward on ward_hierarchy (ward_code);
create index idx_wh_lad on ward_hierarchy (lad_code);
create index idx_wh_cty on ward_hierarchy (cty_code);
create index idx_wh_ctry on ward_hierarchy (ctry_code);
update ward_hierarchy
    inner join wards on ward_code = wards.code
set ward_name = wards.name;
update ward_hierarchy
    inner join lads on lad_code = lads.code
set lad_name = lads.name;
update ward_hierarchy
    inner join countries on ctry_code = countries.code
set ctry_name = countries.name;
update ward_hierarchy
    inner join counties on cty_code = counties.code
set cty_name = counties.name;
