package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"strconv"
)

type Histogram struct {
	sum     int    // sum of samples
	offset  int    // array index pointing to the 0-th bin
	buckets [9]int // one bucket per element
}

func (h *Histogram) add(bucket, value int) {
	h.sum += value
	h.buckets[h.bucketToIndex(bucket)] += value
}

func (h *Histogram) bucketToIndex(bucket int) int {
	return (bucket + h.offset) % len(h.buckets)
}

func (h *Histogram) shiftLeft() {
	h.offset = (h.offset + 1) % len(h.buckets)
}
func (h *Histogram) print() {
	fmt.Printf("sum: %d\n", h.sum)
	// fmt.Printf("offset: %d\n", h.offset)
	for bucket, _ := range h.buckets {
		idx := h.bucketToIndex(bucket)
		fmt.Printf("%d: %d\n", bucket, h.buckets[idx])
	}
}

func (h *Histogram) tick() {
	spawn := h.buckets[h.bucketToIndex(0)]
	h.shiftLeft()
	h.add(6, spawn)
}
func main() {
	state := Histogram{}
	file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
	defer file.Close()
	reader := csv.NewReader(file)
	records, _ := reader.ReadAll()
	for _, strVal := range records[0] {
		val, _ := strconv.Atoi(strVal)
		state.add(val, 1)
	}

	fmt.Println("Initial state:")
	state.print()
	for day := 1; day <= 80; day++ {
		state.tick()
	}

	fmt.Println("State after 80 days: ")
	state.print()
}
