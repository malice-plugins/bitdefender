package main

import (
	"fmt"
	"io/ioutil"
	"testing"
)

// TestParseResult tests the ParseFSecureOutput function.
func TestParseResult(t *testing.T) {

	r, err := ioutil.ReadFile("tests/av_scan.out")
	if err != nil {
		fmt.Print(err)
	}

	results := ParseBitdefenderOutput(string(r), nil)

	if true {
		t.Log("results: ", results)
	}

}
