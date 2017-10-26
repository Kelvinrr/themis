/*10/2010: mars.thmwork.status
  10/2017: CEdwards sync'ing to NAU
*/

create table thmwork.status (file_id varchar(9) primary key,
                             status varchar(12) constraint status_list check (status in ('PLANNED','UPLINKED','DOWNLINKED','RDRPROC','TEAM','PUBLIC','FAILED')),
                             EDR smallint,
                             RDR smallint,
                             ABR smallint,
                             BTR smallint,
                             SMP smallint,
                             SNU smallint,
                             POL smallint,
                             ALB smallint,
                             PBT smallint,
                             DCS smallint,
                             BWS smallint,
                             BWS2 smallint,
                             RGB smallint,
                             product_cnt smallint,
                             processing_note text);

comment on table thmwork.status is 'THEMIS (working) Image product availability table';
comment on column thmwork.status.file_id is 'PK/FK- Unique identification of THEMIS image';

comment on column thmwork.status.EDR is 'Logical test for avilable EDR product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.RDR is 'Logical test for avilable RDR product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.ABR is 'Logical test for avilable VIS-ABR product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.BTR is 'Logical test for avilable IR-BTR product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.SMP is 'Logical test for avilable SMP product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.SNU is 'Logical test for avilable SNU product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.POL is 'Logical test for avilable POL product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.ALB is 'Logical test for avilable VIS-ALB product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.PBT is 'Logical test for avilable IR-PBT product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.DCS is 'Logical test/count of avilable IR-DCS products [null=NA; 0=expected but NA; 1-4=available]';
comment on column thmwork.status.BWS is 'Logical test/count of avilable BWS+THB product [null=NA; 0=expected but NA; 2=available]';
comment on column thmwork.status.BWS2 is 'Logical test for avilable BWS2 product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.RGB is 'Logical test for avilable VIS-RGB product [null=NA; 0=expected but NA; 1=available]';
comment on column thmwork.status.product_cnt is 'Total count of products available for this image';

comment on column thmwork.status.status is 'Status of image: PLANNED, UPLINKED, DOWNLINKED, RDRPROC, TEAM, PUBLIC, FAILED';
comment on column thmwork.status.processing_note is 'Comments and anomalies encountered during routine processing of this image';


/* Watch foreign keys:
             constraint qgeomfid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action)
             constraint fgeomfid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action)
              constraint iidxfid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action,
             constraint iprocfid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action)
             constraint irscifid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action)
             constraint pgeomfid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action,
             constraint stagefid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action)
               constraint tlmfid_fk foreign key (file_id) references thmwork.status (file_id) on delete no action on update no action)
 ... and views
     thm3_qube
     thm3_quality
*/
