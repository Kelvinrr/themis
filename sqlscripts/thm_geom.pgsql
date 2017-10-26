/*10/2010: mars.thmwork.qubgeom
  11/09/10: added FK=status.file_id
  01/2013: changes to address ISIS3 loadgeometry issues
  02/2014: idexes to improve web-servelet performance
  06/2015: added pixel_dn, pixel_x, pixel_y for use with ISIS3.4.9
  10/2017: CEdwards sync'ing to NAU
 */

create table thmwork.qubgeom (file_id varchar(9),
                              point_id char(2) constraint qgeom_point check (point_id in ('CT','UL','UR','LL','LR')),
                              band_idx integer,
                              geometry_level varchar(3),
                              aspect_ratio double precision,
                              band integer,
                              emission_angle double precision,
                              incidence_angle double precision,
                              lat double precision,
                              line_res_km double precision,
                              local_solar_time double precision,
                              lon double precision,
                              north_azimuth_angle double precision,
                              phase_angle double precision,
                              pixel_res_km double precision,
                              pixel_dn integer,
                              pixel_x integer,
                              pixel_y integer,
                              sample_res_km double precision,
                              slant_distance double precision,
                              solar_distance double precision,
                              solar_longitude double precision,
                              sun_azimuth double precision);

create index qgeom_Ilat on thmwork.qubgeom (lat);
create index qgeom_Ilon on thmwork.qubgeom (lon);
create index qgeom_Isoldist on thmwork.qubgeom (solar_distance);
create index qgeom_Isollon on thmwork.qubgeom (solar_longitude);
create index qgeom_Iincang on thmwork.qubgeom (incidence_angle);
create index qgeom_Isoltime on thmwork.qubgeom (local_solar_time);
create index qgeom_Iemsang on thmwork.qubgeom (emission_angle);
create index qgeom_Ireskm on thmwork.qubgeom (line_res_km);

comment on table thmwork.qubgeom is 'THEMIS (working) Image geometry table with qube details';
comment on column thmwork.qubgeom.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.qubgeom.point_id is 'PK- Identification of 5 point locations in the image: CT-UL-UR-LL-LR ';
comment on column thmwork.qubgeom.band is 'Band (band_bin_band_number) identification of geometry parameters; band is null for Trackserver-Predicted geometry';

comment on column thmwork.qubgeom.aspect_ratio is 'Ratio of the height to the width (line_res_km/sample_res_km) of this point_id when projected on the surface of Mars (derived from ISIS3)';
comment on column thmwork.qubgeom.band_idx is 'PK- Index count of available bands in order of ascending band number; band_idx=0 for Trackserver-PREDICTED geometry';
comment on column thmwork.qubgeom.emission_angle is 'Angle between Themis and a normal vector to the surface at the time the image was acquired; emission_angle=0 for nadir observations; given in degrees';
comment on column thmwork.qubgeom.geometry_level is 'PK- Abbreviation for type of kernel files used to generate the geometry parameters available for this QUBE; T=Trackserver-predicted, P=Predicted, R=Reconstructed, N=Nadir, U=Unknown geometry (can not be calculated)';
comment on column thmwork.qubgeom.incidence_angle is 'Angle between the Sun and a normal vector to the surface at the time the image was acquired; incidence_angle=0 implies that the Sun was directly overhead; given in degrees';
comment on column thmwork.qubgeom.lat is 'Latitude of this point_id on the planet Mars';
comment on column thmwork.qubgeom.solar_distance is 'Distance between the Sun and Mars at time of image acquisition; given in AU';
comment on column thmwork.qubgeom.line_res_km is 'Vertical size of this pixel projected onto the surface of Mars; given in km (derived from ISIS3)';
comment on column thmwork.qubgeom.pixel_res_km is 'Size of this pixel projected onto the surface of Mars; given in km (ISIS3)';
comment on column thmwork.qubgeom.local_solar_time is 'Local time on Mars relative to a division of the Martian day into 24 equal parts';
comment on column thmwork.qubgeom.lon is 'Longitude of this point_id on the planet Mars using an east positive coordinate system';
comment on column thmwork.qubgeom.north_azimuth_angle is 'Clockwise angle from an imaginary 3-oclock axis to the North polar axis with the origin of both axes a this point_id; given in degrees';
comment on column thmwork.qubgeom.phase_angle is 'Angle between Sun - surface - Themis at the time the image was acquired; given in degrees';
comment on column thmwork.qubgeom.sample_res_km is 'Horizontal size of this pixel projected onto the surface of Mars; given in km (derived from ISIS3)';
comment on column thmwork.qubgeom.slant_distance is 'A measure of the distance from the spacecraft to the target body; this is the spacecraft altitude when emission_angle=0';
comment on column thmwork.qubgeom.solar_longitude is 'Heliocentric longitude; Position of Mars relative to the Sun as measured in degrees from the vernal equinox';
comment on column thmwork.qubgeom.sun_azimuth is 'Clockwise angle from an imaginary 3-oclock axis to the Sun with the origin of both axes at this point_id';
comment on column thmwork.qubgeom.pixel_dn is 'EDR-DN value of pixel of this point_id in image; may be null';
comment on column thmwork.qubgeom.pixel_x is 'Sample location of this point_id in EDR image';
comment on column thmwork.qubgeom.pixel_y is 'Line location of this point id in EDR image';


/*10/2010: mars.thmwork.frmgeom*/
/*11/09/10: added FK=status.file_id */

create table thmwork.frmgeom (file_id varchar(9),
                              framelet_id integer,
                              point_id char(2) constraint fgeom_point check (point_id in ('CT','UL','UR','LL','LR')),
                              band_idx integer,
                              geometry_level varchar(3),
                              aspect_ratio double precision,
                              band integer,
                              emission_angle double precision,
                              incidence_angle double precision,
                              lat double precision,
                              line_res_km double precision,
                              local_solar_time double precision,
                              lon double precision,
                              north_azimuth_angle double precision,
                              phase_angle double precision,
                              pixel_res_km double precision,
                              pixel_dn integer,
                              pixel_x integer,
                              pixel_y integer,
                              sample_res_km double precision,
                              slant_distance double precision,
                              solar_distance double precision,
                              solar_longitude double precision,
                              sun_azimuth double precision,
                              poly_idx integer);

comment on table thmwork.frmgeom is 'THEMIS (working) Image geometry table with framelet details';
comment on column thmwork.frmgeom.file_id is 'PK/FK- Unique identification of THEMIS image';
comment on column thmwork.frmgeom.framelet_id is 'PK- Framelet count within image [0=entire image]';
comment on column thmwork.frmgeom.point_id is 'PK- Identification of 5 point locations in the image: CT-UL-UR-LL-LR ';
comment on column thmwork.frmgeom.band is 'Band (band_bin_band_number) identification of geometry parameters; band=0 for PREDICTED geometry';
comment on column thmwork.frmgeom.geometry_level is 'PK- Abbreviation for type of kernel files used to generate the geometry parameters available for this QUBE; T=Trackserver-predicted, P=Predicted, R=Reconstructed, N=Nadir, U=Unknown geometry (can not be calculated)';

comment on column thmwork.frmgeom.aspect_ratio is 'Ratio of the height to the width (line_res_km/sample_res_km) of this point_id when projected on the surface of Mars';
comment on column thmwork.frmgeom.band_idx is 'PK- Index count of available bands in order of ascending band number';
comment on column thmwork.frmgeom.emission_angle is 'Angle between Themis and a normal vector to the surface at the time the image was acquired; emission_angle=0 for nadir observations; given in degrees';
comment on column thmwork.frmgeom.incidence_angle is 'Angle between the Sun and a normal vector to the surface at the time the image was acquired; incidence_angle=0 implies that the Sun was directly overhead; given in degrees';
comment on column thmwork.frmgeom.lat is 'Latitude of this point_id on the planet Mars';
comment on column thmwork.frmgeom.solar_distance is 'Distance between the Sun and Mars at time of image acquisition; given in AU';
comment on column thmwork.frmgeom.line_res_km is 'Vertical size of this pixel projected onto the surface of Mars; given in km';
comment on column thmwork.frmgeom.local_solar_time is 'Local time on Mars relative to a division of the Martian day into 24 equal parts';
comment on column thmwork.frmgeom.lon is 'Longitude of this point_id on the planet Mars using an east positive coordinate system';
comment on column thmwork.frmgeom.north_azimuth_angle is 'Clockwise angle from an imaginary 3-oclock axis to the North polar axis with the origin of both axes a this point_id; given in degrees';
comment on column thmwork.frmgeom.phase_angle is 'Angle between Sun - surface - Themis at the time the image was acquired; given in degrees';
comment on column thmwork.frmgeom.sample_res_km is 'Horizontal size of this pixel projected onto the surface of Mars; given in km';
comment on column thmwork.frmgeom.slant_distance is 'A measure of the distance from the spacecraft to the target body; this is the spacecraft altitude when emission_angle=0';
comment on column thmwork.frmgeom.solar_longitude is 'Heliocentric longitude; Position of Mars relative to the Sun as measured in degrees from the vernal equinox';
comment on column thmwork.frmgeom.sun_azimuth is 'Clockwise angle from an imaginary 3-oclock axis to the Sun with the origin of both axes at this point_id';
comment on column thmwork.frmgeom.poly_idx is 'Index that sorts the frame points into a clockwise outline around entire image, starting at UL';
comment on column thmwork.frmgeom.pixel_res_km is 'Size of this pixel projected onto the surface of Mars; given in km (ISIS3)';
comment on column thmwork.frmgeom.pixel_dn is 'EDR-DN value of pixel of this point_id in image; may be null';
comment on column thmwork.frmgeom.pixel_x is 'Sample location of this point_id in EDR image';
comment on column thmwork.frmgeom.pixel_y is 'Line location of this point id in EDR image';

/*
INSERT INTO thmwork.qubgeom_new (file_id, point_id, band_idx, geometry_level, aspect_ratio, band, emission_angle, incidence_angle, lat, line_res_km, local_solar_time, lon, north_azimuth_angle, phase_angle, sample_res_km, slant_distance, solar_longitude, sun_azimuth)
 SELECT file_id, point_id, band_idx, geometry_level, aspect_ratio, band, emission_angle, incidence_angle, lat, line_res_km, local_solar_time, lon, north_azimuth_angle, phase_angle, sample_res_km, slant_distance, solar_longitude, sun_azimuth FROM thmwork.qubgeom ;

INSERT INTO thmwork.frmgeom_new
(file_id, framelet_id, point_id, band_idx, geometry_level, aspect_ratio, band, emission_angle, incidence_angle, lat, line_res_km, local_solar_time, lon, north_azimuth_angle, phase_angle, sample_res_km, slant_distance, solar_longitude, sun_azimuth, poly_idx)
 SELECT file_id, framelet_id, point_id, band_idx, geometry_level, aspect_ratio, band, emission_angle, incidence_angle, lat, line_res_km, local_solar_time, lon, north_azimuth_angle, phase_angle, sample_res_km, slant_distance, solar_longitude, sun_azimuth, poly_idx FROM thmwork.frmgeom ;

*/
