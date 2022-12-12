# UK Geodata

The UK ONS and OS provide some great open data products but understanding how to use them isn't trivial (nor is understanding UK geography)

Some background reading [A Beginner's Guide to UK Geography](https://geoportal.statistics.gov.uk/documents/a-beginners-guide-to-uk-geography-2021-v1-0-1/explore)

This repo contains some scripts (mostly SQL) that I'm working on to put the data into a form I can use.

I'm mostly interested in (English) electoral geography at the moment.

Note that using these scripts requires manual data download first 

Likely the filenames of the downloads will change - and the scripts  would need editing.

I don't know if I will maintain this - but I hoipe it may at least be a good starting point even if it becomes outdated.

## National Statistics Postcode Lookup (NSPL)



This contains a *lot* of data

Some of the data I have has electoral areas listed by name - but since names of wards/districts/wards are not unique I needed to get a hierarchy of names so that I can work out which one is relevant.

The NSPL data by itself is great for (as it says on the tin) looking up stuff rom postcodes.

I've also extracted a hierarchy - based on the way the areas work.

Wards are contained within Local Authority Districts which are within Counties which are within UK Countries.

There are also County Electoral Divisions which are within Counties within Countries.

I don't understand why we have both county districts and county divisions 

> English county councils are the only type of local authority in the UK which does not use standard electoral wards/divisions for electing councillors. Instead they use their own larger units, which are confusingly also termed electoral divisions.
> 
> __A Beginner's Guide to UK Geography__

### Source tables

These are all loaded direct from the csv

The main lookup table from postcodes to areas.

 - nspl 


These tables contains names for some of the columns

- wards   
- divisions
- lads
- counties
- regions
- countries
- parls
- pfas

The result of some data processing 

ced_hierachy 
ward_hierarchy

### Source Data


https://geoportal.statistics.gov.uk/search?collection=Dataset&sort=-created&tags=all(PRD_NSPL)

Download the above dataset and extract it (relative to this file) to 

./NSPL/


### Database 

setup a database 

Import the data (uses mysql's LOAD DATA INFILE)


```bash
mysql mydbname < nspl.sql
mysql mydbname < ward_hierarchy.sql
mysql mydbname < ced_hierarchy.sql
```

### Examples


Many wards names "castle"

```sql
select ward_code, ward_name, lad_name, ctry_name from ward_hierarchy where ward_name='castle';
```

```text
+-----------+-----------+--------------------------+------------------+
| ward_code | ward_name | lad_name                 | ctry_name        |
+-----------+-----------+--------------------------+------------------+
| E05007069 | Castle    | Tamworth                 | England          |
| E05007695 | Castle    | Worthing                 | England          |
| N08001111 | Castle    | Ards and North Down      | Northern Ireland |
| N08000813 | Castle    | Mid and East Antrim      | Northern Ireland |
| E05013052 | Castle    | Cambridge                | England          |
| E05010828 | Castle    | Colchester               | England          |
| E05003513 | Castle    | Mid Devon                | England          |
| E05009448 | Castle    | Herefordshire, County of | England          |
| E05009596 | Castle    | Lancaster                | England          |
| E05010463 | Castle    | Leicester                | England          |
| E05010788 | Castle    | Lincoln                  | England          |
| E05008753 | Castle    | Bedford                  | England          |
| E05011441 | Castle    | Newcastle upon Tyne      | England          |
| E05012277 | Castle    | Nottingham               | England          |
| E05011554 | Castle    | Newark and Sherwood      | England          |
| E05010155 | Castle    | South Kesteven           | England          |
| E05013246 | Castle    | West Northamptonshire    | England          |
| W05000794 | Castle    | Monmouthshire            | Wales            |
| W05000961 | Castle    | Swansea                  | Wales            |
| E05001154 | Castle    | Sunderland               | England          |
| E05009573 | Castle    | Tonbridge and Malling    | England          |
| E05011204 | Castle    | Hastings                 | England          |
| E05012373 | Castle    | Scarborough              | England          |
+-----------+-----------+--------------------------+------------------+
```



There are even two wards named "Nelson" that are both in Norfolk!

```sql
select ward_code, ward_name, lad_name, cty_name, ctry_name from ward_hierarchy where ward_name='nelson';
```

```text
+-----------+-----------+----------------+-----------------------------+-----------+
| ward_code | ward_name | lad_name       | cty_name                    | ctry_name |
+-----------+-----------+----------------+-----------------------------+-----------+
| W05000735 | Nelson    | Caerphilly     | (pseudo) Wales              | Wales     |
| E05012908 | Nelson    | Norwich        | Norfolk                     | England   |
| E05005795 | Nelson    | Great Yarmouth | Norfolk                     | England   |
| E05002451 | Nelson    | Portsmouth     | (pseudo) England (UA/MD/LB) | England   |
+-----------+-----------+----------------+-----------------------------+-----------+
```

## Parish to Ward to Local Authority District

Dataset available from ONS at https://geoportal.statistics.gov.uk/datasets/ons::parish-to-ward-to-local-authority-district-december-2020-lookup-in-england-and-wales-v2-1/about


```bash
mysql databasename < parish_to_ward_to_local_authority_district.sql
```

This just creates the database tables and loads teh data.

Note that parish <-> ward is a many to many relationship as parish boundaries and ward boundaries are not aligned. 



## OS OpenNames 


This contains the names of many things like roads and towns plus some postcode infp

### Source 
https://www.ordnancesurvey.co.uk/business-government/products/open-map-names

The data is supplied in lots of small csv file so I use a small script to run the process

Download the files - extract to ./os_opennames (relative to here)

create a database

run the script with your database name as a parameter 

```bash
./os-opennames.sh mydatabasename
```

This creates a table called opennames with the names and info about a lot of places

 ```sql
 select name1, type, local_type, postcode_district, district_borough from opennames ;
```

An edited selection of results 

```text
+--------------------------+------------------+------------------------+-------------------+------------------+
| name1                    | type             | local_type             | postcode_district | district_borough |
+--------------------------+------------------+------------------------+-------------------+------------------+
| Westing                  | populatedPlace   | Other Settlement       | ZE2               |                  |
| ZE2 9DN                  | other            | Postcode               |                   |                  |
| Brough View              | transportNetwork | Named Road             | ZE2               |                  |
| B9084                    | transportNetwork | Numbered Road          | ZE2               |                  |
| Wick of Trutis           | hydrography      | Bay                    | ZE2               |                  |
| Ham of Grudale           | landform         | Island                 | ZE2               |                  |
| Grey Kame                | landform         | Other Coastal Landform | ZE2               |                  |
| Kidna Water              | hydrography      | Inland Water           | ZE2               |                  |
| The Icelander            | landform         | Island                 | ZE2               |                  |
| Gloup Lochs              | hydrography      | Inland Water           | ZE2               |                  |
+--------------------------+------------------+------------------------+-------------------+------------------+
```

and a sample of some of the location data available 

```text
                 NAME1: Cormorant Way
            NAME1_LANG: 
                 NAME2: 
            NAME2_LANG: 
                  TYPE: transportNetwork
            LOCAL_TYPE: Named Road
            GEOMETRY_X: 462130
            GEOMETRY_Y: 1209508
  MOST_DETAIL_VIEW_RES: 1000
 LEAST_DETAIL_VIEW_RES: 20000
              MBR_XMIN: 462127
              MBR_YMIN: 1209485
              MBR_XMAX: 462132
              MBR_YMAX: 1209529
     POSTCODE_DISTRICT: ZE2
```


## Other data

As well as the postcode lookup there is a similar lookup based on UPRN (unique property reference number)

This should be more accurate because Postcodes don't align with electoral geography and the postcode lookup is on a "best fit basis".

https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-november-2021-user-guide-odt-1/about


The [PAF Programmers guide](https://www.poweredbypaf.com/wp-content/uploads/2017/07/Latest-Programmers_guide_Edition-7-Version-6.pdf) is essential reading for an understanding of UK postcodes - and there is also sample PAF data available.

Loads more at 

- https://geoportal.statistics.gov.uk/
- https://www.ordnancesurvey.co.uk/business-government/tools-support/open-data-support


