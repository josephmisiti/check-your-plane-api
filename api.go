package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"database/sql"
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

const (
	ACCIDENTS_QUERY = `SELECT id,regis_no,ev_id,acft_make,afm_hrs,afm_hrs_last_insp,date_last_insp,owner_acft FROM events WHERE regis_no ~* '%s'`
	EVENTS_QUERY    = `SELECT id,regis_no,ev_id,acft_make,afm_hrs,afm_hrs_last_insp,date_last_insp,owner_acft 
                       FROM events`
	DESCRIPTION_URL = "http://www.ntsb.gov/_layouts/ntsb.aviation/brief.aspx?ev_id=%s"
)

type Accident struct {
	RegistrationNumber           string
	EventId                      string
	Description                  string
	AircraftMake                 string
	LastInspectedDate            string
	AmountHrsSinceLastInspection string
	AmountOfHours                string
	Owner                        string
}

type Accidents []Accident

type AccidentResponse struct {
	Success bool
	Objects Accidents
}

func (l *Accidents) addElement(registrationNumber string, eventId string, aircraftMake string, lastInspectedDate string, amountHrsSinceLastInspection string, amountOfHours string, owner string) {
	e := &Accident{
		RegistrationNumber:           registrationNumber,
		EventId:                      eventId,
		AircraftMake:                 aircraftMake,
		LastInspectedDate:            lastInspectedDate,
		AmountHrsSinceLastInspection: amountHrsSinceLastInspection,
		AmountOfHours:                amountOfHours,
		Owner:                        owner,
	}

	e.getDescription()

	*l = append(*l, *e)
}

func (l *Accident) getDescription() {
	l.Description = "Test"
}

func AccidentEventEndpoint(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	accidentId := vars["accident_id"]
	QUERY := fmt.Sprintf(ACCIDENTS_QUERY, accidentId)

	accidents := Accidents{}
	db, err := sql.Open("postgres", "user='' dbname=plane sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}

	var (
		id                int
		regis_no          string
		ev_id             string
		acft_make         string
		date_last_insp    string
		afm_hrs_last_insp string
		afm_hrs           string
		owner_acft        string
	)

	rows, err := db.Query(QUERY)
	if err != nil {
		fmt.Println(err)
		return
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&id, &regis_no, &ev_id, &acft_make, &afm_hrs, &afm_hrs_last_insp, &date_last_insp, &owner_acft)
		if err != nil {
			log.Fatal(err)
		}
		accidents.addElement(regis_no, ev_id, acft_make, date_last_insp, afm_hrs_last_insp, afm_hrs, owner_acft)
	}

	response := AccidentResponse{
		Success: true,
		Objects: accidents,
	}

	json.NewEncoder(w).Encode(response)

}

func AccidentQueryEndPoint(w http.ResponseWriter, r *http.Request) {

	reg_num := r.FormValue("regis_no")

	QUERY := EVENTS_QUERY
	if reg_num != "" {
		QUERY = fmt.Sprintf(ACCIDENTS_QUERY, reg_num)
	}

	accidents := Accidents{}
	db, err := sql.Open("postgres", "user='' dbname=plane sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}

	var (
		id                int
		regis_no          string
		ev_id             string
		acft_make         string
		date_last_insp    string
		afm_hrs_last_insp string
		afm_hrs           string
		owner_acft        string
	)

	rows, err := db.Query(QUERY)
	if err != nil {
		fmt.Println(err)
		return
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&id, &regis_no, &ev_id, &acft_make, &afm_hrs, &afm_hrs_last_insp, &date_last_insp, &owner_acft)
		if err != nil {
			log.Fatal(err)
		}
		accidents.addElement(regis_no, ev_id, acft_make, date_last_insp, afm_hrs_last_insp, afm_hrs, owner_acft)
	}

	response := AccidentResponse{
		Success: true,
		Objects: accidents,
	}

	json.NewEncoder(w).Encode(response)
}

func main() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/api/v1/accidents", AccidentQueryEndPoint).Methods("GET")
	router.HandleFunc("/api/v1/accidents/{accident_id}", AccidentEventEndpoint).Methods("GET")

	fmt.Println("Your webserver is running on port 8000")
	log.Fatal(http.ListenAndServe(":8000", router))
}
