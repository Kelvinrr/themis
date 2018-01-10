/* 2/2014: idexes to improve web-servelet performance*/
/* create index NAME on TABLE (field);               */

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

create index stg_Iband on thmwork.stage (bands);
create index stg_Irelid on thmwork.stage (release_id);

create index isci_Ioicea on thmwork.irqubsci (tau_ice);
create index isci_Ioiceb on thmwork.irqubsci (tau_ice_min,tau_ice_max);
create index isci_Iodusta on thmwork.irqubsci (tau_dust);
create index isci_Iodustb on thmwork.irqubsci (tau_dust_min,tau_dust_max);
create index isci_Imolaa on thmwork.irqubsci (mola_avg);
create index isci_Imolab on thmwork.irqubsci (mola_min,mola_max);
create index isci_Itia on thmwork.irqubsci (ti_avg);
create index isci_Itib on thmwork.irqubsci (ti_min,ti_max);
create index isci_Istempa on thmwork.irqubsci (surf_temp_avg);
create index isci_Istempb on thmwork.irqubsci (surf_temp_min,surf_temp_max);
create index isci_Italba on thmwork.irqubsci (tes_alb_avg);
create index isci_Italbb on thmwork.irqubsci (tes_alb_min,tes_alb_max);
create index isci_Itdusta on thmwork.irqubsci (tes_dust_avg);
create index isci_Itdustb on thmwork.irqubsci (tes_dust_min,tes_dust_max);
create index isci_Itraa on thmwork.irqubsci (tes_ra_avg);
create index isci_Itrab on thmwork.irqubsci (tes_ra_min,tes_ra_max);
create index isci_Ittia on thmwork.irqubsci (tes_ti_avg);
create index isci_Ittib on thmwork.irqubsci (tes_ti_min,tes_ti_max);
create index isci_Iemis3 on thmwork.irqubsci (tes_emiss3);
create index isci_Iemis4 on thmwork.irqubsci (tes_emiss4);
create index isci_Iemis5 on thmwork.irqubsci (tes_emiss5);
create index isci_Iemis6 on thmwork.irqubsci (tes_emiss6);
create index isci_Iemis7 on thmwork.irqubsci (tes_emiss7);
create index isci_Iemis8 on thmwork.irqubsci (tes_emiss8);
create index isci_Itestemp on thmwork.irqubsci (tes_b10_temp);
create index isci_Ithmtemp on thmwork.irqubsci (thm_b10_temp);
create index isci_Idrop on thmwork.irqubsci (dropouts);
create index isci_Isat on thmwork.irqubsci (saturated);
create index isci_Iusat on thmwork.irqubsci (undersaturated);

create index vsci_Italba on thmwork.vissci (tes_alb_avg);
create index vsci_Italbb on thmwork.vissci (tes_alb_min,tes_alb_max);
create index vsci_Iaavg on thmwork.vissci (alb_avg);
create index vsci_Iamin on thmwork.vissci (alb_min);
create index vsci_Iamax on thmwork.vissci (alb_max);

create index qgeom_Ilat on thmwork.qubgeom (lat);
create index qgeom_Ilon on thmwork.qubgeom (lon);
create index qgeom_Isoldist on thmwork.qubgeom (solar_distance);
create index qgeom_Isollon on thmwork.qubgeom (solar_longitude);
create index qgeom_Iincang on thmwork.qubgeom (incidence_angle);
create index qgeom_Isoltime on thmwork.qubgeom (local_solar_time);
create index qgeom_Iemsang on thmwork.qubgeom (emission_angle);
create index qgeom_Ireskm on thmwork.qubgeom (line_res_km);
