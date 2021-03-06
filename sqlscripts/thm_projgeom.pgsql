/* 10/2010: mars.thmwork.projgeom
  11/09/10: added FK=status.file_id
  06/20/11: reworked PK; added source_band
  02/12/13: added columns for ISIS3 processing parameters
  04/24/13: added UpperLeft corners
  02/26/14: added lon_system
  05/13/14: added proj, [corner]_lat|lon, & Visis
  08/25/14: removed source_band
  12/2014: added unzip_bytes (bigint due to large GEO files)
  10/2017: CEdwards sync'ing to NAU
*/

create table thmwork.projgeom (file_id varchar(9),
                               projection varchar(30),
                               proj varchar(5),
                               ctr_lat double precision,
                               ctr_lon double precision,
                               east_lon double precision,
                               line_offset double precision,
                               ll_lat double precision,
                               ll_lon double precision,
                               lr_lat double precision,
                               lr_lon double precision,
                               lon_system integer,
                               max_lat double precision,
                               min_lat double precision,
                               resolution double precision,
                               sample_offset double precision,
                               scale double precision,
                               ulcorner_X double precision,
                               ulcorner_Y double precision,
                               ul_lat double precision,
                               ul_lon double precision,
                               ur_lat double precision,
                               ur_lon double precision,
                               west_lon double precision,
                               param_status varchar(50),
                               geom_param varchar(15),
                               map_param text,
                               out_param text,
                               proc_param text,
                               comments text,
                               visis smallint,
                               unzip_bytes bigint);

create index pgeom_Iclat on thmwork.projgeom (ctr_lat);
create index pgeom_Iclon on thmwork.projgeom (ctr_lon);
create index pgeom_Ielon on thmwork.projgeom (east_lon);
create index pgeom_Iwlon on thmwork.projgeom (west_lon);
create index pgeom_Inlat on thmwork.projgeom (min_lat);
create index pgeom_Ixlat on thmwork.projgeom (max_lat);
create index pgeom_Iul on thmwork.projgeom (ul_lat,ul_lon);
create index pgeom_Iur on thmwork.projgeom (ur_lat,ur_lon);
create index pgeom_Ill on thmwork.projgeom (ll_lat,ll_lon);
create index pgeom_Ilr on thmwork.projgeom (lr_lat,lr_lon);

/* 6/2011: Not best solution for needs
   select AddGeometryColumn('thmwork','projgeom','poly_outline',4326,'POLYGON',2);
   comment on column thmwork.projgeom.poly_outline is 'pGIS image outline: starts at NW corner and traces counter-clockwise around corner points'; */


comment on table thmwork.projgeom is 'THEMIS (working) Image geometry table with projected details';
comment on column thmwork.projgeom.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.projgeom.projection is 'PK- Map projection of this product; join against stage.isis_map_projection_type';
comment on column thmwork.projgeom.proj is 'Abbreviated map projection';

comment on column thmwork.projgeom.ctr_lat is 'Center latitude of projected product; likely includes null-padded borders around image';
comment on column thmwork.projgeom.ctr_lon is 'Center longitude of projected product; likely includes null-padded borders around image';
comment on column thmwork.projgeom.east_lon is 'Easternmost longitude of projected product; likely includes null-padded borders around image';
comment on column thmwork.projgeom.max_lat is 'Northernmost latitude of projected product; likely includes null-padded borders around image';
comment on column thmwork.projgeom.min_lat is 'Southernmost latitude of projected product; likely includes null-padded borders around image';
comment on column thmwork.projgeom.west_lon is 'Westernmost longitude of projected product; likely includes null-padded borders around image';
comment on column thmwork.projgeom.resolution is 'Map resolution of this product in pixel/degree';
comment on column thmwork.projgeom.scale is 'Map scale of this projection in km/pixel';
comment on column thmwork.projgeom.line_offset is 'Vertical offset of the map projection origin from the upper left corner (line=1,sample=1) of the product';
comment on column thmwork.projgeom.sample_offset is 'Horizontal offset of the map projection origin from the upper left corner (line=1,sample=1) of the product';
comment on column thmwork.projgeom.ulcorner_X is 'Horizontal offset in meters between the map projection origin from the upper left corner (line=0.5,sample=0.5) of the product';
comment on column thmwork.projgeom.ulcorner_Y is 'Vertical offset in meters between the map projection origin from the upper left corner (line=0.5,sample=0.5) of the product';
comment on column thmwork.projgeom.lon_system is 'Longitude system of this projection [180 or 360]';

comment on column thmwork.projgeom.param_status is 'Describes status of projection parameters of this record; given as STATUS:yyyy-dd-mmThh:mm:ss';
comment on column thmwork.projgeom.geom_param  is 'Geometry Kernel parameter esp for use with th_*I3geo.sh; possible values: PREDICTED, RECONSTRUCTED, NADIR, ROTO';
comment on column thmwork.projgeom.out_param  is 'Output modification parameters esp for use with th_*I3geo.sh; given as list pf PARAM=value';
comment on column thmwork.projgeom.map_param  is 'MapTemplate parameters esp for use with th_*I3geo.sh; given as list of x=# or a maptemplate_filename';
comment on column thmwork.projgeom.proc_param is 'Processing parameters esp for use with th_*I3geo.sh; given as list of PARAM=value';
comment on column thmwork.projgeom.comments is 'Comments about projection issues regarding this image';
comment on column thmwork.projgeom.visis is 'ISIS version [2|3] source of projection values';
comment on column thmwork.projgeom.unzip_bytes is 'Size in bytes of this product after gzip compression removed';

/*based on current orientation (usu N-up)*/
comment on column thmwork.projgeom.ur_lat is 'UpperRight latitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.ur_lon is 'UpperRight longitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.ul_lat is 'UpperLeft latitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.ul_lon is 'UpperLeft longitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.ll_lat is 'LowerLeft latitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.ll_lon is 'LowerLeft longitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.lr_lat is 'LowerRight latitude of projected product; includes null-padded borders around image';
comment on column thmwork.projgeom.lr_lon is 'LowerRight longitude of projected product; includes null-padded borders around image';



/* param_status= Predict:yyyy-mm-dd, AsRun:yyyy-mm-dd, Modified:yyyy-mm-dd ... where date is ProdCreatDate for Run, "touched" for others */
/* geom_param =  PREDICTED|RECONSTRUCTED|NADIR|ROTO ?explicit restriction?*/
/* out_param =   (SHORT=1 GZIP=1 BAND=#,#) */
/* map_param =   NOTE defaults used for unlisted parameters; (p=# r=# l=# x=# y=# m=# o=# s=#)|maptemplate_filename */
