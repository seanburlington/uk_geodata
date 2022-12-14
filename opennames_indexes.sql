create index idx_op_id on opennames (ID);
create index idx_op_place on opennames (POPULATED_PLACE);
create index idx_op_name on opennames (NAME1);
create index idx_op_code on opennames (POSTCODE_DISTRICT);
create index idx_op_bourough on opennames (DISTRICT_BOROUGH);
create index idx_op_bourtype on opennames (DISTRICT_BOROUGH_TYPE);
create index idx_op_unitary on opennames (COUNTY_UNITARY);
create index idx_op_unitarytype on opennames (COUNTY_UNITARY_TYPE);
create index idx_op_region on opennames (REGION);
create index idx_op_country on opennames (COUNTRY);
