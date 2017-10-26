/*12/2010: mars.thmwork.stage
  2/2014: idexes to improve web-servelet performance
  8/2014: removed isis_command and isis_lon_system; change isis_map_projection_type to projection
          adding fields: dn_min/dn_max/dn_avg/dn_ignore
  12/2014: added file_bytes (bigint to allow for big GEO files)
  10/2017: CEdwards sync'ing to NAU
*/

create table thmwork.stage (file_id varchar(9),
                            stage varchar(4),
                            bands integer,
                            band_bin_base varchar(255),
                            band_bin_multiplier varchar(255),
                            band_center double precision,
                            band_number integer,
                            cal_date_time varchar(24),
                            cal_user_name varchar(50),
                            cal_user_note text,
                            cal_version_id varchar(4),
                            dn_avg double precision,
                            dn_ignore double precision,
                            dn_min double precision,
                            dn_max double precision,
                            file_bytes bigint,
                            file_records integer,
                            geom_source varchar(255),
                            hist_bytes integer,
                            isis_hist_group text,
                            projection varchar(30),
                            label_records integer,
                            lines integer,
                            location varchar(255),
                            md5_checksum varchar(100),
                            offset_value double precision,
                            product_creation_time varchar(24),
                            record_bytes integer,
                            release_id varchar(4),
                            samples integer,
                            scaling_factor double precision,
                            sfdu2cube_date_time varchar(24),
                            sfdu2cube_ert_start_time varchar(35),
                            sfdu2cube_ert_stop_time varchar(35),
                            sfdu2cube_found_packets integer,
                            sfdu2cube_missing_packets integer,
                            sfdu2cube_start_sfdu_id varchar(12),
                            sfdu2cube_stop_sfdu_id varchar(12),
                            sfdu2cube_user_name varchar(50),
                            sfdu2cube_user_note varchar(255),
                            sfdu2cube_version_id varchar(4),
                            source_note varchar(255),
                            source_version_id varchar(4),
                            version_id varchar(4));
                            
create index stg_Iband on thmwork.stage (bands);
create index stg_Irelid on thmwork.stage (release_id);

comment on table thmwork.stage is 'THEMIS (working) Image product specific information table';
comment on column thmwork.stage.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.stage.stage is 'PK/FK- Abbreviated processing level of image';

comment on column thmwork.stage.band_bin_base is 'IR-RDR: Offset value for the stored data of each band; see also stage.band_bin_multiplier';
comment on column thmwork.stage.band_bin_multiplier is 'IR-RDR: Constant value per band multiplied by the stored data and added to the stage.band_bin_base value to reproduce the true data';

comment on column thmwork.stage.band_center is 'BTR/ABR/PBT: Wavelength value (micrometers) of the band contained in this IMG';
comment on column thmwork.stage.band_number is 'BTR/ABR/PBT: Identifies which band of the source RDR QUBE this IMG was derived';
comment on column thmwork.stage.cal_date_time is 'RDR: Date and time cal_x_image was executed on this image';
comment on column thmwork.stage.cal_user_name is 'RDR: Computer from which cal_x_image was executed on this image';
comment on column thmwork.stage.cal_user_note is 'RDR: User note regarding cal_x_image execution of this image';
comment on column thmwork.stage.cal_version_id is 'RDR: Version of cal_x_image algorithm executed on this image';
comment on column thmwork.stage.file_records is 'Number of records in this file including labels and data';
comment on column thmwork.stage.geom_source is 'RDR+: Description of the geometry kernels used by the ISIS software for this image';
comment on column thmwork.stage.hist_bytes is 'Number of history records stored in the history object in the header of this QUBE';
comment on column thmwork.stage.isis_hist_group is 'GEO: List of processes applied to create this image';
comment on column thmwork.stage.projection is 'GEO: ISIS map projection type of this image';
comment on column thmwork.stage.label_records is 'Number of records used for label data; value does not include tlm or history records';
comment on column thmwork.stage.location is 'Pathname to this working file in the ASU Themis directory tree';
comment on column thmwork.stage.md5_checksum is '128-bit checksum identification of the data portion of the QUBE';
comment on column thmwork.stage.offset_value is 'BTR: Offset value of the stored data in this IMG';
comment on column thmwork.stage.product_creation_time is 'Date and time of creation of this product';
comment on column thmwork.stage.record_bytes is 'Number of bytes per record';
comment on column thmwork.stage.release_id is 'Identification of the original public release of this QUBE';
comment on column thmwork.stage.scaling_factor is 'BTR: Constant value multiplied by the stored data in this IMG and added to the stage.offset value to reproduce the true data';
comment on column thmwork.stage.sfdu2cube_date_time is 'EDR: Date and time sfdu2cube was executed on this image';
comment on column thmwork.stage.sfdu2cube_ert_start_time is 'EDR: Start Earth-Recieved-Time for the first sfdu packet associated with this image';
comment on column thmwork.stage.sfdu2cube_ert_stop_time is 'EDR: Stop Earth-Recieved-Time for the last sfdu packet associated with this image';
comment on column thmwork.stage.sfdu2cube_found_packets is 'EDR: Number of sfdu packets found associated with this image';
comment on column thmwork.stage.sfdu2cube_missing_packets is 'EDR: Number of missing sfdu packets associated with this image';
comment on column thmwork.stage.sfdu2cube_start_sfdu_id is 'EDR: Start sfdu packet identity associated with this image';
comment on column thmwork.stage.sfdu2cube_stop_sfdu_id is 'EDR: Stop sfdu packet identity associated with this image';
comment on column thmwork.stage.sfdu2cube_user_name is 'EDR: Computer from which sfdu2cube was executed on this image';
comment on column thmwork.stage.sfdu2cube_user_note is 'EDR: User note regarding sfdu2cube executed of this image';
comment on column thmwork.stage.sfdu2cube_version_id is 'EDR: Version of sfdu2cube algorithm executed on this image';
comment on column thmwork.stage.source_note is 'BWS/THB: Note regarding generation of browse/thumbnail images';
comment on column thmwork.stage.source_version_id is 'RDR+: Version_id of the source from which this product was derived; BWS/THB: Product type from which this image was derived';
comment on column thmwork.stage.version_id is 'Version identification of this product';
comment on column thmwork.stage.bands is 'Number of pixels along the Z-axis (layers) of this product';
comment on column thmwork.stage.samples is 'Number of pixels along the X-axis (columns) of this product';
comment on column thmwork.stage.lines is 'Number of pixels along the Y-axis (rows) of this product';
comment on column thmwork.stage.dn_avg is 'Average DN value of this product; see reference.glossary for details';
comment on column thmwork.stage.dn_ignore is 'Ignore DN value of this product; see reference.glossary for details';
comment on column thmwork.stage.dn_min is 'Minimum DN value of this product; see reference.glossary for details';
comment on column thmwork.stage.dn_max is 'Maximum DN value of this product; see reference.glossary for details';
comment on column thmwork.stage.file_bytes is 'Size in bytes of this product';
