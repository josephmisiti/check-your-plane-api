CREATE EXTENSION postgis;

CREATE TABLE events
(
    id integer PRIMARY KEY,
    acft_make text NOT NULL,
    ev_month integer,
    ev_year integer,
    ev_type text,
    ev_id text,
    regis_no text,
    ntsb_no text
);


