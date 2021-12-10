package main

import "testing"

func TestNewPoint(t *testing.T) {
    a := NewPoint("1,2")
    e := Point{1, 2}
    if (a != e) {
        t.Errorf("points not equal, expected: %s, actual: %s", e, a)
    }
}

func TestExplode(t *testing.T) {
    h := Line{Point{0,0}, Point{5,0}}
    hLen := len(h.Explode())
    if (hLen!= 6) {
        t.Errorf("unexpected length, expected %d, actual %d", 6, hLen)
    }

    d := Line{Point{0, 2}, Point{2, 0}}
    t.Error(d.Explode())
}

func TestHash(t *testing.T) {
    var hash = make(map[Point]int)
    p1 := Point{0,0}
    if (hash[p1] != 0) {
        t.Errorf("entry not 0: %d", hash[p1])
    }
    hash[p1]++

    if (hash[p1] != 1) {
        t.Errorf("entry not 1: %d", hash[p1])
    }
    hash[p1]++

    if (hash[p1] != 2) {
        t.Errorf("entry not 2: %d", hash[p1])
    }
}

