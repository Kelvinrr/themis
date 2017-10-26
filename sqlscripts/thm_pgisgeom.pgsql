/*06/2011: mars.thmwork.pgisgeom
  10/2017: CEdwards sync'ing to NAU
*/

create table thmwork.pgisgeom (file_id varchar(9) primary key,
                               source_band integer);

select AddGeometryColumn('thmwork','pgisgeom','pgis_outline',4326,'POLYGON',2);

comment on table thmwork.pgisgeom is 'THEMIS (working) Image geometry table with a PGIS outline and assoc details';
comment on column thmwork.pgisgeom.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.pgisgeom.source_band is 'Band number of image used as source of geometry information';
comment on column thmwork.pgisgeom.pgis_outline is 'pGIS image outline: starts at NW corner and traces counter-clockwise around corner points';
