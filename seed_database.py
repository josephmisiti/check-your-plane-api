# -*- coding: utf-8 -*-

import os
import sys
import json
import pandas as pd
import pprint
import psycopg2
import glob

config = {
    'HOST': 'localhost',
    'USER': 'josephmisiti',
    'PORT': 5432,
    'PASSWORD': '',
    'NAME': 'plane'
}

def load():
    
    conn = psycopg2.connect(
        host=config['HOST'], 
        user=config['USER'], 
        port=config['PORT'], 
        password=config['PASSWORD'], 
        dbname=config['NAME'])
    cur = conn.cursor()
    
    aircraft = pd.read_csv("data/aircraft.txt")
    events = pd.read_csv("data/events.txt")
    events = pd.merge(events, aircraft, on='ev_id', how='outer')
    events = events.dropna(subset=['owner_acft'], how='all')
    events.fillna("None", inplace=True)
    index = 1
    for e in events.iterrows():
        event = e[1]            
        sql_statement = """INSERT INTO
                            events (id,
                                    acft_make,
                                    ev_month,
                                    ev_year,
                                    ev_type,
                                    ev_id,
                                    regis_no,
                                    ntsb_no,
                                    owner_acft,
                                    ev_highest_injury,
                                    ev_city,
                                    afm_hrs,
                                    afm_hrs_last_insp,
                                    date_last_insp,
                                    commercial_space_flight)
                           VALUES ({index},
                                   '{acft_make}',
                                   {ev_month},
                                   {ev_year},
                                   '{ev_type}',
                                   '{ev_id}',
                                   '{regis_no}',
                                   '{ntsb_no}',
                                   '{owner_acft}',
                                   '{ev_highest_injury}',
                                   '{ev_city}',
                                   '{afm_hrs}',
                                   '{afm_hrs_last_insp}',
                                   '{date_last_insp}',
                                   {commercial_space_flight}
                                   )""".format(
                               index=index,
                               acft_make=(str(event['acft_make']) or "").strip().replace("'",""),
                               ev_month=event['ev_month'],
                               ev_year=event['ev_year'],
                               ev_type=event['ev_type'].strip().replace("'",""),
                               ev_id=event['ev_id'],
                               regis_no=event['regis_no'],
                               ntsb_no=event['ntsb_no_x'],
                               owner_acft=(event.get('owner_acft') or '').strip().replace("'",""),
                               ev_highest_injury=event['ev_highest_injury'],
                               ev_city=(str(event['ev_city']) or "").replace("'",""),
                               commercial_space_flight=event['commercial_space_flight'],
                               afm_hrs=event['afm_hrs'],
                               afm_hrs_last_insp=event['afm_hrs_last_insp'],
                               date_last_insp=event['date_last_insp'],
                           )
    
        try:
            cur.execute(sql_statement.decode("ascii","ignore"))
            conn.commit()
        except Exception, e:
            print("could not process %s %s" % (index, str(e)))
            index += 1
            continue
            
        
        index += 1
        if index % 5000 == 0: print("processed %s" % index)

  
    

if __name__ == "__main__":
    sys.exit(load())