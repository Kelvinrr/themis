/*10/2010: mars.thmwork.irsci
  11/09/10: added FK=status.file_id
  01/09/14: split into irsci {irfrmsci + irqubsci}
  02/2014: idexes to improve web-servelet performance
  10/2017: CEdwards sync'ing to NAU
*/
/*  SCHEMA | IRSCI | IRFRMSCI | IRQUBSCI
   --------+-------+----------+---------
   thmwork | table |  view    |  view
   thmwork | view  |  table   |  table
   thmpub  | view  |  table   |  table
*/

create table thmwork.irqubsci (file_id varchar(9),
                            framelet_id integer,
                            bright_temp1 double precision,
                            bright_temp2 double precision,
                            bright_temp3 double precision,
                            bright_temp4 double precision,
                            bright_temp5 double precision,
                            bright_temp6 double precision,
                            bright_temp7 double precision,
                            bright_temp8 double precision,
                            bright_temp9 double precision,
                            bright_temp10 double precision,
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
                            tau_dust double precision,
                            tau_dust_max double precision,
                            tau_dust_min double precision,
                            tau_dustscaled double precision,
                            tau_ice double precision,
                            tau_ice_max double precision,
                            tau_ice_min double precision,
                            tau_rms real,
                            tes_alb_avg double precision,
                            tes_alb_max double precision,
                            tes_alb_min double precision,
                            tes_alb_sigma double precision,
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
                            TES_b10_temp double precision,
                            THM_b10_temp double precision,
                            ti_deltaT real,
                            ti_avg real,
                            ti_max real,
                            ti_min real,
                            undersaturated double precision);

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

comment on table thmwork.irqubsci is 'THEMIS (working) IR image derived science values table for framlet_id=0';
comment on column thmwork.irqubsci.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.irqubsci.framelet_id is 'PK- Framelet count within image [0=entire image]';

comment on column thmwork.irqubsci.bright_temp1 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 1; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp10 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 10; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp2 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 2; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp3 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 3; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp4 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 4; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp5 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 5; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp6 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 6; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp7 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 7; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp8 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 8; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.bright_temp9 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 9; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irqubsci.dropouts is 'Logical test for missing data [0=no dropouts; 1=dropouts]';
comment on column thmwork.irqubsci.saturated is 'Ratio of number of saturated pixels to the total number of pixels; pixel is saturated if EDR dn=255';
comment on column thmwork.irqubsci.TES_b10_temp is 'Brightness temperature for (last line, band10) of "TES data" correlated with this IR image during UDDW';
comment on column thmwork.irqubsci.THM_b10_temp is 'Brightness temperature for (last line, band10) of THEMIS IR image obtained during UDDW';
comment on column thmwork.irqubsci.undersaturated is 'Ratio of number of undersaturated pixels to the total number of pixels; pixel is undersaturated if EDR dn=0';

comment on column thmwork.irqubsci.mola_avg is 'Average MOLA elevation value at center of framelet using THM3_info/MGS_maps/mola_2ppd';
comment on column thmwork.irqubsci.mola_max is 'FRM=0 Maximum mola_avg value for all framelets in image';
comment on column thmwork.irqubsci.mola_min is 'FRM=0 Minimum mola_avg value for all framelets in image';
comment on column thmwork.irqubsci.mola_sigma is 'FRM=0 Standard deviation of mola_avg values for all framelets in image';
comment on column thmwork.irqubsci.surf_pressure is 'Atmospheric pressure at the surface; framelet_id=0 is average of all valid framelets';
comment on column thmwork.irqubsci.surf_temp_atm is 'Surface temperature with atmospheric attenuation effects removed; framelet_id=0 is average of all valid framelets';
comment on column thmwork.irqubsci.surf_temp_avg is 'Average surface temperature (K) based on bright_temp3-9(warm) or bright_temp9 (cold)';
comment on column thmwork.irqubsci.surf_temp_max is 'Maximum surface temperature (K) based on bright_temp3-9(warm) or bright_temp9 (cold)';
comment on column thmwork.irqubsci.surf_temp_min is 'Minimum surface temperature (K) based on bright_temp3-9(warm) or bright_temp9 (cold)';
comment on column thmwork.irqubsci.tau_dust is 'Dust opacity (9um); framelet_id=0 is average of all valid framelets';
comment on column thmwork.irqubsci.tau_dustscaled is 'Dust opacity scaled for elevation (scaled to 6.1Mbars); framelet_id=0 is average of all valid framelets';
comment on column thmwork.irqubsci.tau_dust_max is 'FRM=0 Maximum dust opacity (9um) value for all framelets in image';
comment on column thmwork.irqubsci.tau_dust_min is 'FRM=0 Minimum dust opacity (9um) value for all framelets in image';
comment on column thmwork.irqubsci.tau_ice is 'Water ice opacity (11um); framelet_id=0 is average of all valid framelets';
comment on column thmwork.irqubsci.tau_ice_max is 'FRM=0 Maximum water ice opacity (11um) value for all framelets in image';
comment on column thmwork.irqubsci.tau_ice_min is 'FRM=0 Minimum water ice opacity (11um) value for all framelets in image';
comment on column thmwork.irqubsci.tau_rms is 'RMS error of spectral shape deconvolution used to calculate opacities; rms=0 if image okay, but opacity algorithm fails; framelet_id=0 is average of all valid framelets';
comment on column thmwork.irqubsci.tes_alb_avg is 'Average TES albedo value at center of framelet using THM3_info/MGS_maps/albedo_2ppd [approx lat coverage:87N-87S]';
comment on column thmwork.irqubsci.tes_alb_max is 'FRM=0 Maximum tes_alb_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_alb_min is 'FRM=0 Minimum tes_alb_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_alb_sigma is 'FRM=0 Standard deviation of tes_alb_avg values for all framelets in image';
comment on column thmwork.irqubsci.tes_dust_avg is 'Average TES dust index value at center of framelet using THM3_info/MGS_maps/dci_lo_ice_2ppd [approx lat coverage:67N-85S]; higher index values indicate less surface dust and 0=null';
comment on column thmwork.irqubsci.tes_dust_max is 'FRM=0 Maximum tes_dust_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_dust_min is 'FRM=0 Minimum tes_dust_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_dust_sigma is 'FRM=0 Standard deviation of tes_dust_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_emiss3 is 'TES emissivity convolved to THM band 3; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irqubsci.tes_emiss4 is 'TES emissivity convolved to THM band 4; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irqubsci.tes_emiss5 is 'TES emissivity convolved to THM band 5; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irqubsci.tes_emiss6 is 'TES emissivity convolved to THM band 6; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irqubsci.tes_emiss7 is 'TES emissivity convolved to THM band 7; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irqubsci.tes_emiss8 is 'TES emissivity convolved to THM band 8; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irqubsci.tes_ra_avg is 'Average rock abundance in framelet based on MGS_maps/rockabund_8ppd [lat coverage:60N-60S]; given in percent of rocky material with map_null=-10';
comment on column thmwork.irqubsci.tes_ra_max is 'Maximum rock abundance in framelet based on MGS_maps/rockabund_8ppd [lat coverage:60N-60S]; given in percent of rocky material with map_null=-10';
comment on column thmwork.irqubsci.tes_ra_min is 'Minimum rock abundance in framelet based on MGS_maps/rockabund_8ppd [lat coverage:60N-60S]; given in percent of rocky material with map_null=-10';
comment on column thmwork.irqubsci.tes_ra_pix is 'Count of pixels with non-null rock abundance values in framelet';
comment on column thmwork.irqubsci.tes_ra_sigma is 'Standard deviation of rock abundance values in framelet; if <2 map values per framelet then sigma=0';
comment on column thmwork.irqubsci.tes_tau_dust is 'TES 9um dust opacity based on current Ls map (30 deg Ls range, 2ppd resolution)';
comment on column thmwork.irqubsci.tes_tau_ice is 'TES 11um water ice opacity based on current Ls map (30 deg Ls range, 2ppd resolution)';
comment on column thmwork.irqubsci.tes_ti_avg is 'Average TES thermal inertia value at center of framelet using THM3_info/MGS_maps/ti_map2ppd [lat coverage: 62N-77S]; 0=null';
comment on column thmwork.irqubsci.tes_ti_max is 'FRM=0 Maximum tes_ti_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_ti_min is 'FRM=0 Minimum tes_ti_avg value for all framelets in image';
comment on column thmwork.irqubsci.tes_ti_sigma is 'FRM=0 Standard deviation of tes_ti_avg values for all framelets in image';
comment on column thmwork.irqubsci.ti_avg is 'Average thermal inertia of framelet; framelet_id=0 is average of all valid framelets; see THM3_info/TI_process.txt';
comment on column thmwork.irqubsci.ti_deltaT is 'Temp difference between surf_temps and model kinetic surface temps; see THM3_info/TI_model.txt';
comment on column thmwork.irqubsci.ti_max is 'Maximum thermal inertia of framelet; framelet_id=0 is max of all valid framelets; see THM3_info/TI_process.txt';
comment on column thmwork.irqubsci.ti_min is 'Minimum thermal inertia of framelet; framelet_id=0 is min of all valid framelets; see THM3_info/TI_process.txt';


create table thmwork.irfrmsci (file_id varchar(9),
                            framelet_id integer,
                            bright_temp1 double precision,
                            bright_temp2 double precision,
                            bright_temp3 double precision,
                            bright_temp4 double precision,
                            bright_temp5 double precision,
                            bright_temp6 double precision,
                            bright_temp7 double precision,
                            bright_temp8 double precision,
                            bright_temp9 double precision,
                            bright_temp10 double precision,
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
                            tau_dust double precision,
                            tau_dust_max double precision,
                            tau_dust_min double precision,
                            tau_dustscaled double precision,
                            tau_ice double precision,
                            tau_ice_max double precision,
                            tau_ice_min double precision,
                            tau_rms real,
                            tes_alb_avg double precision,
                            tes_alb_max double precision,
                            tes_alb_min double precision,
                            tes_alb_sigma double precision,
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
                            TES_b10_temp double precision,
                            THM_b10_temp double precision,
                            ti_deltaT real,
                            ti_avg real,
                            ti_max real,
                            ti_min real,
                            undersaturated double precision);

comment on table thmwork.irfrmsci is 'THEMIS (working) IR image derived science values table for all framelets';
comment on column thmwork.irfrmsci.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.irfrmsci.framelet_id is 'PK- Framelet count within image [0=entire image]';

comment on column thmwork.irfrmsci.bright_temp1 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 1; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp10 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 10; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp2 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 2; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp3 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 3; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp4 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 4; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp5 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 5; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp6 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 6; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp7 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 7; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp8 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 8; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.bright_temp9 is 'Average brightness temperature (K) of RDR->UDDW->RAD3TB band 9; temp=0 when all pixels translate to negative brightness temp values';
comment on column thmwork.irfrmsci.dropouts is 'Logical test for missing data [0=no dropouts; 1=dropouts]';
comment on column thmwork.irfrmsci.saturated is 'Ratio of number of saturated pixels to the total number of pixels; pixel is saturated if EDR dn=255';
comment on column thmwork.irfrmsci.TES_b10_temp is 'Brightness temperature for (last line, band10) of "TES data" correlated with this IR image during UDDW';
comment on column thmwork.irfrmsci.THM_b10_temp is 'Brightness temperature for (last line, band10) of THEMIS IR image obtained during UDDW';
comment on column thmwork.irfrmsci.undersaturated is 'Ratio of number of undersaturated pixels to the total number of pixels; pixel is undersaturated if EDR dn=0';

comment on column thmwork.irfrmsci.mola_avg is 'Average MOLA elevation value at center of framelet using THM3_info/MGS_maps/mola_2ppd';
comment on column thmwork.irfrmsci.mola_max is 'FRM=0 Maximum mola_avg value for all framelets in image';
comment on column thmwork.irfrmsci.mola_min is 'FRM=0 Minimum mola_avg value for all framelets in image';
comment on column thmwork.irfrmsci.mola_sigma is 'FRM=0 Standard deviation of mola_avg values for all framelets in image';
comment on column thmwork.irfrmsci.surf_pressure is 'Atmospheric pressure at the surface; framelet_id=0 is average of all valid framelets';
comment on column thmwork.irfrmsci.surf_temp_atm is 'Surface temperature with atmospheric attenuation effects removed; framelet_id=0 is average of all valid framelets';
comment on column thmwork.irfrmsci.surf_temp_avg is 'Average surface temperature (K) based on bright_temp3-9(warm) or bright_temp9 (cold)';
comment on column thmwork.irfrmsci.surf_temp_max is 'Maximum surface temperature (K) based on bright_temp3-9(warm) or bright_temp9 (cold)';
comment on column thmwork.irfrmsci.surf_temp_min is 'Minimum surface temperature (K) based on bright_temp3-9(warm) or bright_temp9 (cold)';
comment on column thmwork.irfrmsci.tau_dust is 'Dust opacity (9um); framelet_id=0 is average of all valid framelets';
comment on column thmwork.irfrmsci.tau_dustscaled is 'Dust opacity scaled for elevation (scaled to 6.1Mbars); framelet_id=0 is average of all valid framelets';
comment on column thmwork.irfrmsci.tau_dust_max is 'FRM=0 Maximum dust opacity (9um) value for all framelets in image';
comment on column thmwork.irfrmsci.tau_dust_min is 'FRM=0 Minimum dust opacity (9um) value for all framelets in image';
comment on column thmwork.irfrmsci.tau_ice is 'Water ice opacity (11um); framelet_id=0 is average of all valid framelets';
comment on column thmwork.irfrmsci.tau_ice_max is 'FRM=0 Maximum water ice opacity (11um) value for all framelets in image';
comment on column thmwork.irfrmsci.tau_ice_min is 'FRM=0 Minimum water ice opacity (11um) value for all framelets in image';
comment on column thmwork.irfrmsci.tau_rms is 'RMS error of spectral shape deconvolution used to calculate opacities; rms=0 if image okay, but opacity algorithm fails; framelet_id=0 is average of all valid framelets';
comment on column thmwork.irfrmsci.tes_alb_avg is 'Average TES albedo value at center of framelet using THM3_info/MGS_maps/albedo_2ppd [approx lat coverage:87N-87S]';
comment on column thmwork.irfrmsci.tes_alb_max is 'FRM=0 Maximum tes_alb_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_alb_min is 'FRM=0 Minimum tes_alb_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_alb_sigma is 'FRM=0 Standard deviation of tes_alb_avg values for all framelets in image';
comment on column thmwork.irfrmsci.tes_dust_avg is 'Average TES dust index value at center of framelet using THM3_info/MGS_maps/dci_lo_ice_2ppd [approx lat coverage:67N-85S]; higher index values indicate less surface dust and 0=null';
comment on column thmwork.irfrmsci.tes_dust_max is 'FRM=0 Maximum tes_dust_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_dust_min is 'FRM=0 Minimum tes_dust_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_dust_sigma is 'FRM=0 Standard deviation of tes_dust_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_emiss3 is 'TES emissivity convolved to THM band 3; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irfrmsci.tes_emiss4 is 'TES emissivity convolved to THM band 4; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irfrmsci.tes_emiss5 is 'TES emissivity convolved to THM band 5; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irfrmsci.tes_emiss6 is 'TES emissivity convolved to THM band 6; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irfrmsci.tes_emiss7 is 'TES emissivity convolved to THM band 7; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irfrmsci.tes_emiss8 is 'TES emissivity convolved to THM band 8; value at center of framelet using THM3_info/MGS_maps/b3_8_surf_emissivity_2ppd_sdust [approx lat coverage:70N-85S]; 0=null';
comment on column thmwork.irfrmsci.tes_ra_avg is 'Average rock abundance in framelet based on MGS_maps/rockabund_8ppd [lat coverage:60N-60S]; given in percent of rocky material with map_null=-10';
comment on column thmwork.irfrmsci.tes_ra_max is 'Maximum rock abundance in framelet based on MGS_maps/rockabund_8ppd [lat coverage:60N-60S]; given in percent of rocky material with map_null=-10';
comment on column thmwork.irfrmsci.tes_ra_min is 'Minimum rock abundance in framelet based on MGS_maps/rockabund_8ppd [lat coverage:60N-60S]; given in percent of rocky material with map_null=-10';
comment on column thmwork.irfrmsci.tes_ra_pix is 'Count of pixels with non-null rock abundance values in framelet';
comment on column thmwork.irfrmsci.tes_ra_sigma is 'Standard deviation of rock abundance values in framelet; if <2 map values per framelet then sigma=0';
comment on column thmwork.irfrmsci.tes_tau_dust is 'TES 9um dust opacity based on current Ls map (30 deg Ls range, 2ppd resolution)';
comment on column thmwork.irfrmsci.tes_tau_ice is 'TES 11um water ice opacity based on current Ls map (30 deg Ls range, 2ppd resolution)';
comment on column thmwork.irfrmsci.tes_ti_avg is 'Average TES thermal inertia value at center of framelet using THM3_info/MGS_maps/ti_map2ppd [lat coverage: 62N-77S]; 0=null';
comment on column thmwork.irfrmsci.tes_ti_max is 'FRM=0 Maximum tes_ti_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_ti_min is 'FRM=0 Minimum tes_ti_avg value for all framelets in image';
comment on column thmwork.irfrmsci.tes_ti_sigma is 'FRM=0 Standard deviation of tes_ti_avg values for all framelets in image';
comment on column thmwork.irfrmsci.ti_avg is 'Average thermal inertia of framelet; framelet_id=0 is average of all valid framelets; see THM3_info/TI_process.txt';
comment on column thmwork.irfrmsci.ti_deltaT is 'Temp difference between surf_temps and model kinetic surface temps; see THM3_info/TI_model.txt';
comment on column thmwork.irfrmsci.ti_max is 'Maximum thermal inertia of framelet; framelet_id=0 is max of all valid framelets; see THM3_info/TI_process.txt';
comment on column thmwork.irfrmsci.ti_min is 'Minimum thermal inertia of framelet; framelet_id=0 is min of all valid framelets; see THM3_info/TI_process.txt';


/*Watch for use of VIEWS*/
/*WORK (irsci=table)*/
create view thmwork.irfrmsci as select * from thmwork.irsci;
comment on view thmwork.irfrmsci is 'THEMIS (work) IR image derived science values table for all framelets - view of thmwork.irsci';
create view thmwork.irqubsci as select * from thmwork.irsci where framelet_id=0;
comment on view thmwork.irqubsci is 'THEMIS (work) IR image derived science values table for framlet_id=0 - view on thmwork.irsci';

/*TEAM+PUBLIC (irsci=view)*/
create view thmwork.irsci as select * from thmpub.irfrmsci;
comment on view thmwork.irsci is 'THEMIS (team) View same as irfrmsci';
create view thmpub.irsci as select * from thmpub.irfrmsci;
comment on view thmpub.irsci is 'THEMIS (team) View same as irfrmsci';
