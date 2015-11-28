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

type Accident struct {
	RegistrationNumber string
}

type Accidents []Accident

func (l *Accidents) addElement(registrationNumber string) {
	e := &Accident{
		RegistrationNumber: registrationNumber,
	}
	*l = append(*l, *e)
}

func AccidentView(w http.ResponseWriter, r *http.Request) {

	reg_num := r.FormValue("regis_no")

	QUERY := "SELECT id,regis_no FROM events"
	if reg_num != "" {
		QUERY = fmt.Sprintf("SELECT id,regis_no FROM events where regis_no ~* '%s'", reg_num)
	}

	accidents := Accidents{}
	db, err := sql.Open("postgres", "user='' dbname=plane sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}

	var (
		id       int
		regis_no string
	)

	rows, err := db.Query(QUERY)
	if err != nil {
		fmt.Println(err)
		return
	}

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&id, &regis_no)
		if err != nil {
			log.Fatal(err)
		}
		accidents.addElement(regis_no)
		fmt.Println(id, regis_no)
	}

	json.NewEncoder(w).Encode(accidents)

}

func main() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/api/v1/accidents", AccidentView).Methods("GET")
	fmt.Println("Your webserver is running on port 8000")
	log.Fatal(http.ListenAndServe(":8000", router))
}
