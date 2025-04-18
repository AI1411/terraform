package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Server starting on port 18081...")
	if err := http.ListenAndServe(":18081", nil); err != nil {
		panic(err)
	}
}
