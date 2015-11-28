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
	REGISTRATION_QUERY = "SELECT id,regis_no,ev_id FROM events WHERE regis_no = '%s'"
	ACCIDENTS_QUERY    = "SELECT id,regis_no FROM events where regis_no ~* '%s'"
	DESCRIPTION_URL    = "http://www.ntsb.gov/_layouts/ntsb.aviation/brief.aspx?ev_id=%s"
)

type Accident struct {
	RegistrationNumber string
	EventId            string
	Description        string
}

type Accidents []Accident

func (l *Accidents) addElement(registrationNumber string, eventId string) {
	e := &Accident{
		RegistrationNumber: registrationNumber,
		EventId:            eventId,
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
	QUERY := fmt.Sprintf(REGISTRATION_QUERY, accidentId)

	accidents := Accidents{}
	db, err := sql.Open("postgres", "user='' dbname=plane sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}

	var (
		id       int
		regis_no string
		ev_id    string
	)

	rows, err := db.Query(QUERY)
	if err != nil {
		fmt.Println(err)
		return
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&id, &regis_no, &ev_id)
		if err != nil {
			log.Fatal(err)
		}
		accidents.addElement(regis_no, ev_id)
	}
	json.NewEncoder(w).Encode(accidents)

}

func AccidentQueryEndPoint(w http.ResponseWriter, r *http.Request) {

	reg_num := r.FormValue("regis_no")

	QUERY := "SELECT id,regis_no,ev_id FROM events"
	if reg_num != "" {
		QUERY = fmt.Sprintf(ACCIDENTS_QUERY, reg_num)
	}

	accidents := Accidents{}
	db, err := sql.Open("postgres", "user='' dbname=plane sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}

	var (
		id       int
		regis_no string
		ev_id    string
	)

	rows, err := db.Query(QUERY)
	if err != nil {
		fmt.Println(err)
		return
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&id, &regis_no, &ev_id)
		if err != nil {
			log.Fatal(err)
		}
		accidents.addElement(regis_no, ev_id)
	}

	json.NewEncoder(w).Encode(accidents)
}

func main() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/api/v1/accidents", AccidentQueryEndPoint).Methods("GET")
	router.HandleFunc("/api/v1/accidents/{accident_id}", AccidentEventEndpoint).Methods("GET")

	fmt.Println("Your webserver is running on port 8000")
	log.Fatal(http.ListenAndServe(":8000", router))
}
