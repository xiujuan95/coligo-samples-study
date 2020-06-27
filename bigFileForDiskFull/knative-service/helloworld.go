package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	log.Print("helloworld: received a request")
	target := os.Getenv("TARGET")
	if target == "" {
		target = "World"
	}

	log.Printf("Begin to create file........")
	i := 0
	size := 1024
	for i <= 3 {
		i++
		log.Printf("Create a file with size is %n", size)
		bigBuff := make([]byte, 10 * size)
		ioutil.WriteFile("bigfile.test", bigBuff, 0666)
		size = 1024 * size
		log.Printf("%n", i)
		time.Sleep(time.Duration(20)*time.Second)
	}
	log.Printf("end create.....")

	fmt.Fprintf(w, "Hello %s!\n", target)
}

func main() {
	log.Print("helloworld: starting server...")

	http.HandleFunc("/", handler)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("helloworld: listening on port %s", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}