/*3/2011: mars.thm*."themis_details"
  6/2011: significant overhaul
  1/2013: added solar_distance
  1/2014: changed irsci to irqubsci
  2/2014: added vissci
  5/2014: added themis_proj_details
  8/2014: stage.isis_map_projection_type changed to stage.projection; added dn_* fields
  8/2014: rename (VIEW)themis_details to details_view, create TABLE.themis_details
  1/2015: created thmwork.details_view for testing purposes
  10/2017: CEdwards sync'ing to NAU
*/

create view thmteam.themis_proj_details as
       select s.file_id AS file_id, stage, location,
              s.projection, ctr_lat, ctr_lon, dn_avg, dn_ignore, dn_min, dn_max, east_lon, line_offset, ll_lat, ll_lon, lr_lat, lr_lon, lon_system, max_lat, min_lat, resolution, sample_offset, scale, ulcorner_x, ulcorner_y, ul_lat, ul_lon, ur_lat, ur_lon, west_lon,
              lines, samples, bands, offset_value, scaling_factor
       from thmteam.stage s, thmteam.projgeom p
       where s.file_id=p.file_id and s.projection=p.projection and s.projection is not null;

/*Attmept/Difficult to populate dn_* fields with joins
#             , (case when file_id~'I%' then isci.maximum_brightness_temperature when file_id~'V%' then vsci.alb_max end) as dnmax,
#              (case when file_id~'I%' then isci.minimum_brightness_temperature when file_id~'V%' then vsci.alb_min end) as dnmin
#     , left join thmteam.irqubsci isci on s.file_id=isci.file_id, left join thmteam.vissci vsci on s.file_id=vsci.file_id and vsci.band=3
*/

comment on view thmteam.themis_proj_details is 'THEMIS (TEAM) Projection meta_data used by web-based query servelet';
comment on column thmteam.themis_proj_details is '';


create view thmteam.details_view as
       select imgidx.file_id, imgidx.band_bin_band_number, imgidx.band_bin_filter_number, imgidx.calibration, imgidx.calib_flag_temp, imgidx.orbit, imgidx.core_items, imgidx.description, imgidx.detector_id, imgidx.exposure_duration, imgidx.focal_plane_temperature, imgidx.frm1_charge as vis_frm1_quality, imgidx.image_duration, imgidx.image_rating, imgidx.mars_year, imgidx.maximum_brightness_temperature, imgidx.minimum_brightness_temperature, imgidx.missing_scan_lines, imgidx.perc_missing, imgidx.spacecraft_clock_start_count, imgidx.spacecraft_orientation, imgidx.spacecraft_pointing_mode, imgidx.spatial_summing, imgidx.start_time, imgidx.stop_time, imgidx.start_time_et,

              cast(imgidx.start_time as timestamp without time zone) as start_timestamp,
              cast(split_part(trim(leading '(' from spacecraft_orientation),',',1) as numeric) as pitch,
              cast(split_part(spacecraft_orientation,',',2) as numeric) as roll,
              cast(split_part(trim(trailing ')' from spacecraft_orientation),',',3) as numeric) as yaw,
              case when (band_bin_band_number like '(1,%') then 1 else 0 end as band_1,
              case when (band_bin_band_number like '%2%') then 1 else 0 end as band_2,
              case when (band_bin_band_number like '%3%') then 1 else 0 end as band_3,
              case when (band_bin_band_number like '%4%') then 1 else 0 end as band_4,
              case when (band_bin_band_number like '%5%') then 1 else 0 end as band_5,
              case when (band_bin_band_number like '%6%') then 1 else 0 end as band_6,
              case when (band_bin_band_number like '%7%') then 1 else 0 end as band_7,
              case when (band_bin_band_number like '%8%') then 1 else 0 end as band_8,
              case when (band_bin_band_number like '%9%') then 1 else 0 end as band_9,
              case when (band_bin_band_number like '%10)') then 1 else 0 end as band_10,

              array(select stage from thmteam.stage S where imgidx.file_id=S.file_id order by S.stage) stagelist,
              stage.bands, stage.lines, stage.samples, stage.product_creation_time as product_modification_date, stage.release_id,

              irsci.dropouts,irsci.mola_avg, irsci.mola_max, irsci.mola_min, irsci.mola_sigma, irsci.saturated, irsci.surf_pressure, irsci.surf_temp_atm, irsci.surf_temp_avg, irsci.surf_temp_max, irsci.surf_temp_min, irsci.tau_dust as tau_dust_avg, irsci.tau_dust_max, irsci.tau_dust_min, irsci.tau_dustscaled, irsci.tau_ice as tau_ice_avg, irsci.tau_ice_max, irsci.tau_ice_min, irsci.tau_rms, irsci.tes_dust_avg, irsci.tes_dust_max, irsci.tes_dust_min, irsci.tes_dust_sigma, irsci.tes_emiss3, irsci.tes_emiss4, irsci.tes_emiss5, irsci.tes_emiss6, irsci.tes_emiss7, irsci.tes_emiss8, irsci.tes_ra_avg, irsci.tes_ra_max, irsci.tes_ra_min, irsci.tes_ra_pix, irsci.tes_ra_sigma, irsci.tes_tau_dust, irsci.tes_tau_ice, irsci.tes_ti_avg, irsci.tes_ti_max, irsci.tes_ti_min, irsci.tes_ti_sigma, irsci.tes_b10_temp, irsci.thm_b10_temp, irsci.ti_deltat, irsci.ti_avg, irsci.ti_max, irsci.ti_min, irsci.undersaturated,

              (case when detector_id='IR' then irsci.tes_alb_avg when detector_id='VIS' then vissci.tes_alb_avg end) as tes_alb_avg,
              (case when detector_id='IR' then irsci.tes_alb_min when detector_id='VIS' then vissci.tes_alb_min end) as tes_alb_min,
              (case when detector_id='IR' then irsci.tes_alb_max when detector_id='VIS' then vissci.tes_alb_max end) as tes_alb_max,
              (case when detector_id='IR' then irsci.tes_alb_sigma when detector_id='VIS' then vissci.tes_alb_sigma end) as tes_alb_sigma,

              vissci.alb_avg, vissci.alb_min, vissci.alb_max,

              cgeom.solar_distance, cgeom.solar_longitude, cgeom.slant_distance, cgeom.north_azimuth_angle, cgeom.line_res_km, cgeom.sample_res_km, cgeom.incidence_angle, cgeom.local_solar_time, cgeom.emission_angle, cgeom.phase_angle, cgeom.geometry_level,
              cgeom.lat as ct_lat, cgeom.lon as ct_lon,
              ulgeom.lat as ul_lat, ulgeom.lon as ul_lon,
              urgeom.lat as ur_lat, urgeom.lon as ur_lon,
              llgeom.lat as ll_lat, llgeom.lon as ll_lon,
              lrgeom.lat as lr_lat, lrgeom.lon as lr_lon,

              pgis_outline

       from thmteam.stage as stage, thmteam.pgisgeom as pgis, thmteam.qubgeom as cgeom,
            thmteam.qubgeom as ulgeom, thmteam.qubgeom as urgeom, thmteam.qubgeom as llgeom, thmteam.qubgeom as lrgeom,
            thmteam.imgidx as imgidx left join thmteam.irqubsci as irsci on imgidx.file_id=irsci.file_id
            left join thmteam.vissci as vissci on imgidx.file_id=vissci.file_id and vissci.band=3

       where imgidx.file_id=pgis.file_id and
             imgidx.file_id=stage.file_id and stage.stage='EDR' and
             imgidx.file_id=cgeom.file_id and cgeom.point_id='CT' and cgeom.band_idx=1 and
             imgidx.file_id=ulgeom.file_id and ulgeom.point_id='UL' and ulgeom.band_idx=1 and
             imgidx.file_id=urgeom.file_id and urgeom.point_id='UR' and urgeom.band_idx=1 and
             imgidx.file_id=llgeom.file_id and llgeom.point_id='LL' and llgeom.band_idx=1 and
             imgidx.file_id=lrgeom.file_id and lrgeom.point_id='LR' and lrgeom.band_idx=1;


comment on view thmteam.details_view is 'THEMIS (team) staging for Image meta-data transferred to themis_details';
/*comment on column thmteam.details_view is '';*/


create table thmteam.themis_details (file_id varchar(9) primary key,
                                  band_bin_band_number varchar(80),
                                  band_bin_filter_number varchar(80),
                                  calibration smallint,
                                  calib_flag_temp real,
                                  orbit integer,
                                  core_items varchar(40),
                                  description text,
                                  detector_id varchar(3),
                                  exposure_duration double precision,
                                  focal_plane_temperature double precision,
                                  vis_frm1_quality smallint,
                                  image_duration numeric(7,3),
                                  image_rating smallint,
                                  mars_year integer,
                                  maximum_brightness_temperature double precision,
                                  minimum_brightness_temperature double precision,
                                  missing_scan_lines integer,
                                  perc_missing real,
                                  spacecraft_clock_start_count varchar(14),
                                  spacecraft_orientation varchar(16),
                                  spacecraft_pointing_mode varchar(50),
                                  spatial_summing integer,
                                  start_time varchar(24),
                                  stop_time varchar(24),
                                  start_time_et double precision,
                                  start_timestamp timestamp without time zone,
                                  pitch numeric,
                                  roll numeric,
                                  yaw numeric,
                                  band_1 integer,
                                  band_2 integer,
                                  band_3 integer,
                                  band_4 integer,
                                  band_5 integer,
                                  band_6 integer,
                                  band_7 integer,
                                  band_8 integer,
                                  band_9 integer,
                                  band_10 integer,
                                  stagelist varchar(255),
                                  bands integer,
                                  lines integer,
                                  samples integer,
                                  product_modification_date varchar(24),
                                  release_id varchar(4),
                                  dropouts smallint,
                                  mola_avg double precision,
                                  mola_max double precision,
                                  mola_min double precision,
                                  mola_sigma double precision,
                                  saturated double precision,
                                  surf_pressure double precision,
                                  surf_temp_atm real,
                                  surf_temp_avg double precision,
                                  surf_temp_max double precision,
                                  surf_temp_min double precision,
                                  tau_dust_avg double precision,
                                  tau_dust_max double precision,
                                  tau_dust_min double precision,
                                  tau_dustscaled double precision,
                                  tau_ice_avg double precision,
                                  tau_ice_max double precision,
                                  tau_ice_min double precision,
                                  tau_rms real,
                                  tes_dust_avg double precision,
                                  tes_dust_max double precision,
                                  tes_dust_min double precision,
                                  tes_dust_sigma double precision,
                                  tes_emiss3 double precision,
                                  tes_emiss4 double precision,
                                  tes_emiss5 double precision,
                                  tes_emiss6 double precision,
                                  tes_emiss7 double precision,
                                  tes_emiss8 double precision,
                                  tes_ra_avg double precision,
                                  tes_ra_max double precision,
                                  tes_ra_min double precision,
                                  tes_ra_pix integer,
                                  tes_ra_sigma double precision,
                                  tes_tau_dust double precision,
                                  tes_tau_ice double precision,
                                  tes_ti_avg double precision,
                                  tes_ti_max double precision,
                                  tes_ti_min double precision,
                                  tes_ti_sigma double precision,
                                  tes_b10_temp double precision,
                                  thm_b10_temp double precision,
                                  ti_deltat real,
                                  ti_avg real,
                                  ti_max real,
                                  ti_min real,
                                  undersaturated double precision,
                                  tes_alb_avg double precision,
                                  tes_alb_min double precision,
                                  tes_alb_max double precision,
                                  tes_alb_sigma double precision,
                                  alb_avg double precision,
                                  alb_min double precision,
                                  alb_max double precision,
                                  solar_distance double precision,
                                  solar_longitude double precision,
                                  slant_distance double precision,
                                  north_azimuth_angle double precision,
                                  line_res_km double precision,
                                  sample_res_km double precision,
                                  incidence_angle double precision,
                                  local_solar_time double precision,
                                  emission_angle double precision,
                                  phase_angle double precision,
                                  geometry_level varchar(3),
                                  ct_lat double precision,
                                  ct_lon double precision,
                                  ul_lat double precision,
                                  ul_lon double precision,
                                  ur_lat double precision,
                                  ur_lon double precision,
                                  ll_lat double precision,
                                  ll_lon double precision,
                                  lr_lat double precision,
                                  lr_lon double precision,
                                  pgis_outline geometry);

create index tdet_Iorb on thmteam.themis_details (orbit);
create index tdet_Idetid on thmteam.themis_details (detector_id);
create index tdet_Isum on thmteam.themis_details (spatial_summing);
create index tdet_Ibbbn on thmteam.themis_details (band_bin_band_number);
create index tdet_Idesc on thmteam.themis_details (description);
create index tdet_Imyear on thmteam.themis_details (mars_year);
create index tdet_Istet on thmteam.themis_details (start_time_et);
create index tdet_Istutc on thmteam.themis_details (start_time);
create index tdet_Istsclk on thmteam.themis_details (spacecraft_clock_start_count);
create index tdet_Irating on thmteam.themis_details (image_rating);
create index tdet_Icalib on thmteam.themis_details (calibration);
create index tdet_Iyrp on thmteam.themis_details (spacecraft_orientation);
create index tdet_Iminbt on thmteam.themis_details (minimum_brightness_temperature);
create index tdet_Imaxbt on thmteam.themis_details (maximum_brightness_temperature);
create index tdet_Iband on thmteam.themis_details (bands);
create index tdet_Irelid on thmteam.themis_details (release_id);
create index tdet_Ioicea on thmteam.themis_details (tau_ice_avg);
create index tdet_Ioiceb on thmteam.themis_details (tau_ice_min,tau_ice_max);
create index tdet_Iodusta on thmteam.themis_details (tau_dust_avg);
create index tdet_Iodustb on thmteam.themis_details (tau_dust_min,tau_dust_max);
create index tdet_Imolaa on thmteam.themis_details (mola_avg);
create index tdet_Imolab on thmteam.themis_details (mola_min,mola_max);
create index tdet_Itia on thmteam.themis_details (ti_avg);
create index tdet_Itib on thmteam.themis_details (ti_min,ti_max);
create index tdet_Istempa on thmteam.themis_details (surf_temp_avg);
create index tdet_Istempb on thmteam.themis_details (surf_temp_min,surf_temp_max);
create index tdet_Italba on thmteam.themis_details (tes_alb_avg);
create index tdet_Italbb on thmteam.themis_details (tes_alb_min,tes_alb_max);
create index tdet_Itdusta on thmteam.themis_details (tes_dust_avg);
create index tdet_Itdustb on thmteam.themis_details (tes_dust_min,tes_dust_max);
create index tdet_Itraa on thmteam.themis_details (tes_ra_avg);
create index tdet_Itrab on thmteam.themis_details (tes_ra_min,tes_ra_max);
create index tdet_Ittia on thmteam.themis_details (tes_ti_avg);
create index tdet_Ittib on thmteam.themis_details (tes_ti_min,tes_ti_max);
create index tdet_Iemis3 on thmteam.themis_details (tes_emiss3);
create index tdet_Iemis4 on thmteam.themis_details (tes_emiss4);
create index tdet_Iemis5 on thmteam.themis_details (tes_emiss5);
create index tdet_Iemis6 on thmteam.themis_details (tes_emiss6);
create index tdet_Iemis7 on thmteam.themis_details (tes_emiss7);
create index tdet_Iemis8 on thmteam.themis_details (tes_emiss8);
create index tdet_Itestemp on thmteam.themis_details (tes_b10_temp);
create index tdet_Ithmtemp on thmteam.themis_details (thm_b10_temp);
create index tdet_Idrop on thmteam.themis_details (dropouts);
create index tdet_Isat on thmteam.themis_details (saturated);
create index tdet_Iusat on thmteam.themis_details (undersaturated);
create index tdet_Iaavg on thmteam.themis_details (alb_avg);
create index tdet_Iamin on thmteam.themis_details (alb_min);
create index tdet_Iamax on thmteam.themis_details (alb_max);
create index tdet_Ictlat on thmteam.themis_details (ct_lat);
create index tdet_Ictlon on thmteam.themis_details (ct_lon);
create index tdet_Iullat on thmteam.themis_details (ul_lat);
create index tdet_Iullon on thmteam.themis_details (ul_lon);
create index tdet_Iurlat on thmteam.themis_details (ur_lat);
create index tdet_Iurlon on thmteam.themis_details (ur_lon);
create index tdet_Illlat on thmteam.themis_details (ll_lat);
create index tdet_Illlon on thmteam.themis_details (ll_lon);
create index tdet_Ilrlat on thmteam.themis_details (lr_lat);
create index tdet_Ilrlon on thmteam.themis_details (lr_lon);
create index tdet_Isoldist on thmteam.themis_details (solar_distance);
create index tdet_Isollon on thmteam.themis_details (solar_longitude);
create index tdet_Iincang on thmteam.themis_details (incidence_angle);
create index tdet_Isoltime on thmteam.themis_details (local_solar_time);
create index tdet_Iemsang on thmteam.themis_details (emission_angle);
create index tdet_Ireskm on thmteam.themis_details (line_res_km);

comment on table thmteam.themis_details is 'THEMIS (team) Image meta-data used by web-based query servelet';
#comment on column thmteam.themis_details. is 'PK- ';
#comment on column thmteam.themis_details. is '';
#
#



/*Notes:
  - explicit selection on {stage='EDR'}
  - implicit selection on min(status)=~DOWNLINKED~ images due to join on stage table
  - implicit selection on {substring(file_id,1,1) ~ [IV]} due to join on pgisgeom table
  - implicit selection on geometry_level in (R,N) due to band_idx=1 restriction
  - implicit selection on irsci.framelet_id=0 due to join on irqubsci table (2014)
  - explicit selection on vissci.band=3
*/

/*Difference between public.themis_details & VIEW*/
/* pub.thm_details -vs- VIEW plus comments
       incidence_angle_min/max	-> condensed to incidence_angle (at image center); max-min range { <=1 VIS; 2-4 IR }
       local_solar_time_min/max	-> condensed to local_solar_time (at image center); max-min range { usu 0; high-lat 2-6 }
       phase_angle_min/max	-> condensed to phase_angle (at image center); max-min range { <=3 VIS; 4-7 IR }
       emission_angle_min/max	-> condensed to emission_angle (at image center); max-min range { 1-2 all }
       center_lat/lon   	-> duplicate fields; combined with ct_lat/ct_lon
       start_time       	-> format change (timestamp to varchar in standard UTC [YYYY-MM-DDTHH:MM:SS])
       start_time_str   	-> field name change == start_time (see previous line)
       start_timestamp   	-> new field added; equivalent to old start_time field in timestamp format
       status           	-> field dropped; table will show all downlinked images appropriate for TEAM/PUBLIC access
       orbit_number     	-> field name change to orbit
       band_mask        	-> field dropped
       band_#           	-> format change (boolean to [01])
       core_band        	-> field name change to bands; value corresponds to EDR
       core_line        	-> field name change to lines; value corresponds to EDR
       core_sample      	-> field name change to samples; value corresponds to EDR
       ir_image          	-> field name change to detector_id; format change (boolean to char [IR|VIS]
       stage            	-> field name changed to stagelist; {} around list
       mod_date         	-> field dropped
       product_creation_time	-> corresponds to EDR; format change (timestamp to varchar)
       spacecraft_clock_start_count -> new field added
       stop_time        	-> new field added
       band_bin_filter_number	-> new field added
       geometry_level           -> new GEOM field added
       solar_distance           -> new GEOM field added
       new INDEX fields 	-> { core_items, calib_flag_temp, focal_plane_temperature, vis_frm1_quality, exposure_duration,
                                     missing_scan_lines, maximum_brightness_temperature, minimum_brightness_temperature }
       new IRSCI fields 	-> { mola_avg, mola_sigma, surf_pressure, surf_temp_atm, surf_temp_avg, tau_dustscaled, tau_rms,
                                     tes_alb_[avg,min,max,sigma],tes_dust_[avg,min,max,sigma], tes_emiss[3-8],
                                     tes_ra_[min,max,avg,sigma], tes_ra_pix, tes_tau_dust, tes_tau_ice, tes_ti_[avg,min,max,sigma],
                                     ti_deltat, ti_avg, tes_b10_temp, thm_b10_temp, dropouts, saturated, undersaturated }
       new VISSCI fields        -> { alb_avg, alb_min, alb_max, tes_alb_[avg,min,max,sigma] }
       new PGIS field   	-> pgis_outline; validated close match with themis_pgis_webmap.p field
*/
