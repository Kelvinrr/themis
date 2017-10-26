/*10/2010: mars.thmwork.imgidx
  11/09/10: added FK=status.file_id
  02/2014: idexes to improve web-servelet performance
  03/2017: added pbt_min|max_temperature
  10/2017: CEdwards sync'ing to NAU
*/

create table thmwork.imgidx (file_id varchar(9) primary key,
                            band_bin_band_number varchar(80),
                            band_bin_filter_number varchar(80),
                            calibration smallint,
                            calib_flag_dn1 double precision,
                            calib_flag_dn2 double precision,
                            calib_flag_dn3 double precision,
                            calib_flag_dn4 double precision,
                            calib_flag_dn5 double precision,
                            calib_flag_dn6 double precision,
                            calib_flag_dn7 double precision,
                            calib_flag_dn8 double precision,
                            calib_flag_dn9 double precision,
                            calib_flag_dn10 double precision,
                            calib_flag_temp real,
                            orbit integer,
                            core_items varchar(40),
                            description text,
                            detector_id varchar(3),
                            exposure_duration double precision,
                            final_stage varchar(4),
                            focal_plane_temperature double precision,
                            frm1_charge smallint,
                            gain_number integer,
                            image_duration numeric(7,3),
                            image_id integer,
                            image_rating smallint,
                            inst_cmprs_name varchar(10) constraint cmprs_list check (inst_cmprs_name in ('NONE','DCT','PREDICTIVE')),
                            inst_cmprs_ratio double precision,
                            interframe_delay double precision,
                            mars_year integer,
                            maximum_brightness_temperature double precision,
                            minimum_brightness_temperature double precision,
                            missing_scan_lines integer,
                            offset_number integer,
                            partial_sum_lines integer,
                            pbt_max_temperature double precision,
                            pbt_min_temperature double precision,
                            perc_missing real,
                            spacecraft_clock_start_count varchar(14),
                            spacecraft_clock_stop_count varchar(14),
                            spacecraft_orientation varchar(16),
                            spacecraft_pointing_mode varchar(50),
                            spatial_summing integer,
                            start_time varchar(24),
                            start_time_et double precision,
                            stop_time varchar(24),
                            stop_time_et double precision,
                            time_delay_integration_flag varchar(10) constraint tdi_list check (time_delay_integration_flag in ('ENABLED','DISABLED')),
                            tlm_rows smallint,
                            uncorrected_sclk_start_count double precision);
                            
create index iidx_Iorb on thmwork.imgidx (orbit);
create index iidx_Idetid on thmwork.imgidx (detector_id);
create index iidx_Isum on thmwork.imgidx (spatial_summing);
create index iidx_Ibbbn on thmwork.imgidx (band_bin_band_number);
create index iidx_Idesc on thmwork.imgidx (description);
create index iidx_Imyear on thmwork.imgidx (mars_year);
create index iidx_Istet on thmwork.imgidx (start_time_et);
create index iidx_Istutc on thmwork.imgidx (start_time);
create index iidx_Istsclk on thmwork.imgidx (spacecraft_clock_start_count);
create index iidx_Irating on thmwork.imgidx (image_rating);
create index iidx_Icalib on thmwork.imgidx (calibration);
create index iidx_Iyrp on thmwork.imgidx (spacecraft_orientation);
create index iidx_Iminbt on thmwork.imgidx (minimum_brightness_temperature);
create index iidx_Imaxbt on thmwork.imgidx (maximum_brightness_temperature);

comment on table thmwork.imgidx is 'THEMIS (working) Image general information table';
comment on column thmwork.imgidx.file_id is 'PK/FK- Unique identification of THEMIS image';

comment on column thmwork.imgidx.band_bin_band_number is 'Comma delimeted list of Band numbers is associated with a wavelegth regions';
comment on column thmwork.imgidx.band_bin_filter_number is 'Comma delimeted list of Filter numbers; see glossary for BAND vs FILTER number difference';
comment on column thmwork.imgidx.calibration is 'IR-Calib quality flag [0=all good, 1=check acceptablity of anomalies]; see THM3_info/calib.txt';
comment on column thmwork.imgidx.calib_flag_dn1 is 'Calibration shutter image band 1 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn10 is 'Calibration shutter image band 10 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn2 is 'Calibration shutter image band 2 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn3 is 'Calibration shutter image band 3 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn4 is 'Calibration shutter image band 4 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn5 is 'Calibration shutter image band 5 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn6 is 'Calibration shutter image band 6 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn7 is 'Calibration shutter image band 7 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn8 is 'Calibration shutter image band 8 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_dn9 is 'Calibration shutter image band 9 dn values used in IR-RDR calibration';
comment on column thmwork.imgidx.calib_flag_temp is 'Measured temperature of calibration shutter';
comment on column thmwork.imgidx.orbit is 'AKA=command_sequence_number; Numeric identifier for the sequence of commands sent to the spacecraft which include this image';
comment on column thmwork.imgidx.core_items is 'Comma delimeted list defines length of each of the three axes of the core in pixels';
comment on column thmwork.imgidx.description is 'Description of image contents';
comment on column thmwork.imgidx.detector_id is 'Themis camera identification: IR or VIS';
comment on column thmwork.imgidx.exposure_duration is 'Length of time the VIS detector array is exposed per frame in a give image; given in milliseconds';
comment on column thmwork.imgidx.final_stage is 'Product abbreviation for highest level of processing completeled for this image';
comment on column thmwork.imgidx.focal_plane_temperature is 'Temperature in Kelvin of the VIS camera focal plane array at the time of the observation';
comment on column thmwork.imgidx.frm1_charge is 'VIS: Scale [0-4] of charge buildup on 1st framelet of first filter in image [0=no corruption; 4=complete corruption]';
comment on column thmwork.imgidx.gain_number is 'IR: Gain value is the multiplicative factor used in the analog to digital conversion';
comment on column thmwork.imgidx.image_duration is 'Length of time required to collect all frames of all bands in the downlinked image; given in seconds';
comment on column thmwork.imgidx.image_id is 'Numeric identifier for this image within the onboard command sequence';
comment on column thmwork.imgidx.image_rating is 'Scale [1-7] Qualitative assesment of image quality; join on reference.img_rating for text';
comment on column thmwork.imgidx.inst_cmprs_name is 'VIS: Type of compression applied to the VIS data and removed before storage in a QUBE file';
comment on column thmwork.imgidx.inst_cmprs_ratio is 'Ratio of the byte sizes of the uncompressed to the compressed data files';
comment on column thmwork.imgidx.interframe_delay is 'VIS: Time between successive frames of a VIS image; given in seconds';
comment on column thmwork.imgidx.mars_year is 'Mars year (MY) based on Ls where year 1 begins April 11,1955; see glossary for citation';
comment on column thmwork.imgidx.missing_scan_lines is 'IR: Total number of scan lines missing from an IR image when it was received at Earth';
comment on column thmwork.imgidx.offset_number is 'IR: Offset value is the value is multiplied by a constant voltage and added to the measured voltage in the analog to digital conversion';
comment on column thmwork.imgidx.perc_missing is 'Percent of total lines that are missing';
comment on column thmwork.imgidx.spacecraft_clock_start_count is 'Value of the spacecraft clock at the time of data acquisition of the leading edge of the detector array (filter 1); given in SCLK seconds';
comment on column thmwork.imgidx.spacecraft_clock_stop_count is 'Value of the spacecraft clock at the end of data acquisition calculated from the sum of the UNCORRECTED_SCLK_START_COUNT and IMAGE_DURATION; given in SCLK seconds';
comment on column thmwork.imgidx.spacecraft_orientation is 'Comma delimited list (pitch,roll,yaw) describes angle of spacecraft rotation away from true nadir';
comment on column thmwork.imgidx.spacecraft_pointing_mode is 'Description of pointing mode when image was acquired; common values NADIR, OFF-NADIR, etc';
comment on column thmwork.imgidx.spatial_summing is 'Onboard spatial average of NxN set of pixels in an image; summing=1 implies that no spatial averaging has been applied';
comment on column thmwork.imgidx.start_time is 'Time of data acquisition of the leading edge of the detector array (filter 1); given in SCET-UTC format';
comment on column thmwork.imgidx.start_time_et is 'Time of data acquisition of the leading edge of the detector array (filter 1); given in SCET-UTC format';
comment on column thmwork.imgidx.stop_time is 'Time of the end of data acquisition calculated from the sum of the UNCORRECTED_SCLK_START_COUNT and IMAGE_DURATION; given in SCET-UTC format';
comment on column thmwork.imgidx.stop_time_et is 'Time of the end of data acquisition calculated from the sum of the UNCORRECTED_SCLK_START_COUNT and IMAGE_DURATION; given in SCET-UTC format';
comment on column thmwork.imgidx.time_delay_integration_flag is 'Status of onboard algorithm which applies temporal average of successive lines in an IR image; averages 16 detector rows to equal one line in an IR image';
comment on column thmwork.imgidx.tlm_rows is 'IR: Number of telemetry records stored in the tlm table in the IR-EDR headers';
comment on column thmwork.imgidx.uncorrected_sclk_start_count is 'Spacecraft clock value in seconds when the instrument was commanded to acquire the observation';

comment on column thmwork.imgidx.partial_sum_lines is 'IR: The number of lines in a summed image which contain less than N lines of the original non-summed image';

comment on column thmwork.imgidx.maximum_brightness_temperature is 'IR: Maximum brightness temperature value calculated from BTR of this image';
comment on column thmwork.imgidx.minimum_brightness_temperature is 'IR: Maximum brightness temperature value calculated from BTR of this image';
comment on column thmwork.imgidx.pbt_max_temperature is 'IR: Maximum brightness temperature value from PBT of this image';
comment on column thmwork.imgidx.pbt_min_temperature is 'IR: Minimum brightness temperature value from PBT of this image';
