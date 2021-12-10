package main

import (
    "bufio"
    "fmt"
    "os"
    "strconv"
    "strings"
)

type Point struct {
    X int
    Y int
}

func (p Point) String() string {
    return fmt.Sprintf("(%d, %d)", p.X, p.Y)
}

func NewPoint(s string) Point {
    parts := strings.Split(s, ",")
    start, _ := strconv.Atoi(parts[0])
    end, _ := strconv.Atoi(parts[1])
    return Point{start, end}
}
type Line struct {
    Start Point
    End Point
}

func (l *Line) horizontal() bool {
    return l.Start.Y == l.End.Y
}

func (l *Line) vertical() bool {
    return l.Start.X == l.End.X
}

func (l *Line) smallX() int {
    if l.Start.X < l.End.X {
        return l.Start.X
    } else {
        return l.End.X
    }
}

func (l *Line) largeX() int {
    if l.Start.X > l.End.X {
        return l.Start.X
    } else {
        return l.End.X
    }
}

func (l *Line) smallY() int {
    if l.Start.Y < l.End.Y {
        return l.Start.Y
    } else {
        return l.End.Y
    }
}

func (l *Line) largeY() int {
    if l.Start.Y > l.End.Y {
        return l.Start.Y
    } else {
        return l.End.Y
    }
}
func (l *Line) Explode() []Point {
    var result []Point
    if l.horizontal() {
        for x := l.smallX(); x <= l.largeX(); x++ {
            result = append(result, Point{x, l.Start.Y})
        }
    } else if l.vertical() {
        for y := l.smallY(); y <= l.largeY(); y++ {
            result = append(result, Point{l.Start.X, y})
        }
    } else {
        dx := 1
        if l.End.X < l.Start.X {
            dx = -1
        }
        dy := 1
        if l.End.Y < l.Start.Y {
            dy = -1
        }

        for i := l.largeX() - l.smallX(); i >= 0; i-- {
            result = append(result, Point{l.Start.X + i * dx, l.Start.Y + i * dy})
        }
    }
    return result
}

func main() {
    file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
	defer file.Close()
    
    var pointCount = make(map[Point]int)

    minX := 999999
    minY := 999999
    maxX := 0
    maxY := 0

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        parts := strings.Split(scanner.Text(), " -> ")
        start := NewPoint(parts[0])
        end := NewPoint(parts[1])
        line := Line{start, end}
        
        if line.smallX() < minX {
            minX = line.smallX()
        }

        if line.largeX() > maxX {
            maxX = line.largeX()
        }

        if line.smallY() < minY {
            minY = line.smallY()
        }

        if line.largeY() > maxY {
            maxY = line.largeY()
        }


        if !line.horizontal() && !line.vertical() {
        //    continue
        }
        for _, point := range line.Explode() {
            pointCount[point]++
        }
    }

    fmt.Printf("range: %d,%d -> %d,%d\n", minX, minY, maxX, maxY)

    intersectingPoints := 0
    for _, count := range pointCount {
        //fmt.Printf("point: %s, count: %d\n", p, count)
        if count > 1 {
            intersectingPoints++
        }
    }
    fmt.Println(intersectingPoints)

    if false {
        for y := minY; y <= maxY; y++ {
            for x := minX; x <= maxX; x++ {
                interCount := pointCount[Point{x,y}]
                if interCount > 0 {
                    fmt.Printf("%d", interCount)
                } else {
                    fmt.Printf(".")
                }
            }
            fmt.Printf("\n")
        }
    }

}
