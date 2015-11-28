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
    ntsb_no text,
    owner_acft text,
    ev_highest_injury text,
    ev_city text,
    afm_hrs  text,
    afm_hrs_last_insp text,
    date_last_insp text,
    commercial_space_flight integer
);


