/*10/2010: mars.thmwork.imgproc*/
/*11/09/10: Moved status & proc_note to thmwork.status; added FK=status.file_id
  05/09/12: Added despeck for VIS processing
  10/03/13: roll/pitch/yaw default=0
  01/07/14: line_var
  11/04/14: feather changed to orb_node
  09/22/16: added bws_band
*/


create table thmwork.imgproc (file_id varchar(9) primary key,
                              assoc_image varchar(9),
                              BandCfg_cmd integer,
                              bws_band integer,
                              cal_cmd smallint,
                              camera_cmd varchar(5),
                              ck_gap integer,
                              edrdn_avg double precision,
                              edrdn_hpeak integer,
                              edrdn_max integer,
                              edrdn_min integer,
                              edrdn_stdev double precision,
                              despeck smallint,
                              Duration_cmd double precision,
                              Ilen_cmd integer,
                              orb_node varchar(10),
                              last_framelet_id integer,
                              last_framelet_length integer,
                              line_var double precision,
                              Nframes_cmd integer,
                              non_sci_target text,
                              OP_note smallint,
                              orbit integer,
                              pitch integer default 0,
                              reset double precision,
                              roll integer default 0,
                              roto_id integer,
                              start_et_cmd double precision,
                              start_sclk_cmd double precision,
                              shutter_cmd smallint,
                              shutter_id varchar(9),
                              shutter_rms double precision,
                              shutter_time double precision,
                              Summing_cmd integer,
                              TI_note smallint,
                              yaw integer default 0);

comment on table thmwork.imgproc is 'THEMIS (working) Image processing information table';
comment on column thmwork.imgproc.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.imgproc.assoc_image is 'Image acquired at the same time as this image';
comment on column thmwork.imgproc.cal_cmd is 'IR: (from MICP) identifies calibration sequence command at start of I or R image: cal-command=1 no-command=0';
comment on column thmwork.imgproc.ck_gap is 'Size of a gap in the SPICE-CK kernel file corresponding with the time of this image acquisition';
/*comment on column thmwork.imgproc.feather is 'Options for automated VIS-GEO processing [DOWN;OFF;NoREPAIR-OFF;beremove=#]';*/
comment on column thmwork.imgproc.orb_node is 'Orbital node of spacecraft during image collection [Desc;DescX;Asc;AscX]';
comment on column thmwork.imgproc.last_framelet_id is 'IR: Last framelet counted in an image; use in conjunction with projgeom and irfrmsci';
comment on column thmwork.imgproc.last_framelet_length is 'IR: Number of lines in the last framelet of an image; lines in a standard framelet: IR = 256, VIS = 192/spatial_summing';
comment on column thmwork.imgproc.non_sci_target is 'Non-science reason for targeting this image';
comment on column thmwork.imgproc.OP_note is 'IR: Availablity of opacity in IRFRMSCI where AVAIL=1, NOT_AVAIL=0; see THM3_info/Opacity_process.txt';
comment on column thmwork.imgproc.orbit is 'ODY orbit during image collection (from MICP)';
comment on column thmwork.imgproc.pitch is 'ODY pitch angle during image collection';
comment on column thmwork.imgproc.reset is 'SCLK value from apid31-alleng recording reset of camera during this image (VIS=bad_ping or IR=bad_irframe)';
comment on column thmwork.imgproc.roll is 'ODY roll angle during image collection';
comment on column thmwork.imgproc.shutter_cmd is 'IR: (from MICP) status of shutter closing action and identifies S-images: shutter closing=1 shutter stationary=0';
comment on column thmwork.imgproc.shutter_id is 'IR: Shutter image used to calibrate this image';
comment on column thmwork.imgproc.shutter_rms is 'Measure of line-to-line (RMS) noise in band3 of a shutter closing image; -99 indicates error calculating value';
comment on column thmwork.imgproc.shutter_time is 'IR: Amount of time (seconds) between end of IR image and beginning of shutter image used in calibration';
comment on column thmwork.imgproc.TI_note is 'IR: Availablity of thermal inertia in IRFRMSCI where AVAIL=1, NOT_AVAIL=0; see THM3_info/TI_process.txt';
comment on column thmwork.imgproc.yaw is 'ODY yaw angle during image collection';
comment on column thmwork.imgproc.roto_id is 'ODY yaw angle during image collection';
comment on column thmwork.imgproc.edrdn_avg is 'Average DN for EDR image; IR calc on bands3-9 & VIS calc on band3';
comment on column thmwork.imgproc.edrdn_hpeak is 'Histogram peak DN value for EDR image; IR calc on bands3-9 & VIS calc on band3';
comment on column thmwork.imgproc.edrdn_max is 'Maximum DN for EDR image; IR calc on bands3-9 & VIS calc on band3';
comment on column thmwork.imgproc.edrdn_min is 'Minimum DN for EDR image; IR calc on bands3-9 & VIS calc on band3';
comment on column thmwork.imgproc.edrdn_stdev is 'Sandard Devation DN for EDR image; IR calc on bands3-9 & VIS calc on band3';
comment on column thmwork.imgproc.camera_cmd is 'Identifies THEMIS camera: Infrared = {IR|0}, Visible = {VIS|1} (from MICP)';
comment on column thmwork.imgproc.duration_cmd is 'Image length in seconds (from MICP)';
comment on column thmwork.imgproc.nframes_cmd is 'VIS: Number of frames in the downlinked image (from MICP)';
comment on column thmwork.imgproc.bandcfg_cmd is 'Binary representation of FILTER selection with filter 1 last: filter-off=0 filter-on=1 (from MICP; see THM3_info/THM-bandcfg)';
comment on column thmwork.imgproc.ilen_cmd is 'IR: Image LENgth command parameter; used to calcuate duration: (((1+ilen)*256)-240)/30=obs.duration (from MICP)';
comment on column thmwork.imgproc.summing_cmd is 'Spatial summing mode; VIS:1-2-4 IR:1 to 320 (from MICP)';
comment on column thmwork.imgproc.start_et_cmd is 'Start time of data acquisition in SCET-ET format (from MICP)';
comment on column thmwork.imgproc.start_sclk_cmd is 'Start time of data acquisition in SCLK seconds (from MICP)';
comment on column thmwork.imgproc.despeck is 'VIS: Identifies images which require post-RDR DESPECK processing; see thmwork.despeck table for details';
comment on column thmwork.imgproc.line_var is 'Rough measure of line-to-line_variance in image';
comment on column thmwork.imgproc.bws_band is 'Number of band used to generate IR|VIS browse image';


/*Moved to thmwork.status
  status varchar(12) constraint status_list check (status in ('PLANNED','UPLINKED','DOWNLINKED','FAILED')),
  processing_note text,
*/
/*
alter table thmwork.imgproc rename column feather to orb_node;
alter table thmwork.imgproc alter column orb_node type varchar(10);
comment on column thmwork.imgproc.orb_node is 'Orbital node of spacecraft during image collection [Desc;DescX;Asc;AscX]th';
#drop feather from thm3_quality view
*/
