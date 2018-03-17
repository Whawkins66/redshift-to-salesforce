REMOVE id column from staging table



select id firstid, * into temp temp1 from salesforce.category__c;
Create table salesforce.newcat as select * from temp1;
alter table salesforce.newcat drop column id;
alter table salesforce.newcat rename firstid to id;
alter table salesforce.newcat alter column id set default nextval('salesforce.category__c_id_seq'::regclass)
                                                                                                                                                                                         , attname            AS col                                                                                                                                                                                                                                                                             , atttypid::regtype  AS datatype                                                                                                                                                                                                                                                                          -- more attributes?                                                                                                                                                                                                                                                                              FROM   pg_attribute                                                                                                                                                                                                                                                                                     WHERE  attrelid = 'salesforce.category__c'::regclass  -- table name, optionally schema-qualified                                                                                                                                                                                                        AND    attnum > 0                                                                                                                                                                                                                                                                                       AND    NOT attisdropped                                                                                                                                                                                                                                                                                 ORDER  BY attnum;

    "catid__c_unq" UNIQUE CONSTRAINT, btree (catid__c)
    "hcu_idx_category__c_sfid" UNIQUE, btree (sfid)
    "hc_idx_category__c_systemmodstamp" btree (systemmodstamp)
    
    alter table salesforce.category__c rename to foo;
alter table salesforce.category__c add primary key (id);
alter table salesforce.foo alter column id SET DEFAULT 0;

ALTER SEQUENCE salesforce.category__c_id_seq OWNED BY NONE;
CREATE UNIQUE INDEX on salesforce.category__c(sfid);
ALTER TABLE salesforce.category__c 
   ADD CONSTRAINT catid__c_unq UNIQUE USING INDEX catid_unq_idx;
insert into salesforce.category__c select nextval('salesforce.category__c_id_seq'::regclass), * from category;