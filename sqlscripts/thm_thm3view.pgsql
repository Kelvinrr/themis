/*10/2010: mars.thmteam.thm3_qube*/
/*03/2012: correcting issues discoverd during MSQL failure & recovery
  01/2014: changing irsci to irqubsci
  11/2014: removed feather from quality
  10/2017: CEdwards sync'ing to NAU
*/

create view thmwork.thm3_qube as
       select imgproc.file_id,
              imgproc.assoc_image,
              imgidx.calib_flag_dn1,
              imgidx.calib_flag_dn2,
              imgidx.calib_flag_dn3,
              imgidx.calib_flag_dn4,
              imgidx.calib_flag_dn5,
              imgidx.calib_flag_dn6,
              imgidx.calib_flag_dn7,
              imgidx.calib_flag_dn8,
              imgidx.calib_flag_dn9,
              imgidx.calib_flag_dn10,
              imgidx.calib_flag_temp,
              imgproc.ck_gap,
              imgproc.edrdn_avg,
              imgproc.edrdn_hpeak,
              imgproc.edrdn_max,
              imgproc.edrdn_min,
              imgproc.edrdn_stdev,
              qubgeom.geometry_level,
              imgproc.last_framelet_id,
              imgproc.last_framelet_length,
              imgidx.mars_year,
              imgproc.cal_cmd,
              imgproc.shutter_cmd,
              imgproc.shutter_id,
              status.status,
              imgproc.roto_id,
              imgproc.pitch,
              imgproc.roll,
              imgproc.yaw
       from thmwork.imgproc as imgproc, thmwork.imgidx as imgidx, thmwork.qubgeom as qubgeom, thmwork.status as status
       where imgproc.file_id=imgidx.file_id and imgproc.file_id=qubgeom.file_id and
             imgproc.file_id=status.file_id and
             qubgeom.point_id='CT' and qubgeom.band_idx=1;


comment on view thmwork.thm3_qube is 'THEMIS (team) View approximately reproduces original themis3.qube table';
/*comment on column thmwork.thm3_qube is '';*/

/*10/2010: mars.thmwork.thm3_header*/

create view thmwork.thm3_header as
       select imgidx.file_id,
              imgidx.band_bin_band_number,
              imgidx.band_bin_filter_number,
              imgidx.orbit as command_sequence_number,
              stage.bands as core_band,
              imgidx.core_items,
              stage.lines as core_line,
              stage.samples as core_sample,
              imgidx.description,
              imgidx.detector_id,
              imgidx.exposure_duration,
              imgidx.focal_plane_temperature,
              imgidx.gain_number,
              imgidx.image_duration,
              imgidx.image_id,
              imgidx.inst_cmprs_name,
              imgidx.inst_cmprs_ratio,
              imgidx.interframe_delay,
              imgidx.partial_sum_lines,
              imgidx.missing_scan_lines,
              imgidx.offset_number,
              imgidx.orbit as orbit_number,
              imgidx.spacecraft_clock_start_count,
              imgidx.spacecraft_clock_stop_count,
              imgidx.spacecraft_orientation,
              imgidx.spacecraft_pointing_mode,
              imgidx.spatial_summing,
              imgidx.start_time,
              imgidx.start_time_et,
              imgidx.stop_time,
              imgidx.stop_time_et,
              imgidx.time_delay_integration_flag,
              imgidx.uncorrected_sclk_start_count
       from thmwork.imgidx as imgidx, thmwork.stage as stage
       where imgidx.file_id=stage.file_id and stage.stage='EDR';


comment on view thmwork.thm3_header is 'THEMIS (team) View approximately reproduces original themis3.header table';

/*10/2010: mars.thmwork.thm3_quality*/

create view thmwork.thm3_quality as
       select imgproc.file_id,
              imgidx.calibration,
              irsci.THM_b10_temp,
              irsci.TES_b10_temp,
              imgidx.frm1_charge,
              imgidx.image_rating,
              imgproc.non_sci_target,
              imgidx.perc_missing,
              status.processing_note,
              imgproc.OP_note,
              imgproc.TI_note,
              imgproc.reset,
              imgproc.shutter_rms,
              imgproc.shutter_time

       from thmwork.imgproc as imgproc, thmwork.imgidx as imgidx, thmwork.status as status
             left join thmwork.irqubsci as irsci on status.file_id=irsci.file_id
             /*and irsci.framelet_id=0 (2014: implicit)*/
       where imgproc.file_id=imgidx.file_id and
             imgproc.file_id=status.file_id;



comment on view thmwork.thm3_quality is 'THEMIS (team) View approximately reproduces original themis3.quality table';
