create table CUSTOMER( 
CUSTNUMBER                  bigint,
COMPANY                     varchar(20),
FIRSTNAME                   varchar(20),
LASTNAME                    varchar(20),
ADDRESS                     varchar(20),
CITY                        varchar(20),
STATE                       varchar(2),
ZIPCODE                     bigint);



create table ORDERS( 
CUSTNUMBER                  bigint,
ORDERNUMBER                 bigint,
INVOICEAMOUNT               DECIMAL(7,2),
ORDERDATE                   timestamp,
ORDERNOTE                   varchar(80)
);

create table STATES(              
State                       varchar(2),
StateName                   varchar(30)
);


// notice jclarion uses following

// JDBC url connection(0):connection(3)/connection(1)  user=connection(0) password=connection(0)

localhost:54321/tutor1  user=tutor1 pass=tutor1



CREATE USER tutor1 WITH PASSWORD 'tutor1';
ALTER USER Postgres WITH PASSWORD 'tutor1';

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tutor1;