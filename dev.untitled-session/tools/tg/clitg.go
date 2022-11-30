// main
package main

import (
	"encoding/json"
	"fmt"
	"testing"
)

// A Represents some data
type A struct {
	F1 string `json:"f_1" default:"10"`
	F2 int    `json:"f_2"`
	C  string
}

func TestSimple(t *testing.T) {
	t.Logf("simple message")
}

func main() {
	fmt.Println(1, A{
		F1: "",
		F2: 0,
		C:  "",
	})
	r := make(map[string]interface{})
	err := json.Unmarshal([]byte("{}"), &r)
	fmt.Println(err)
}
