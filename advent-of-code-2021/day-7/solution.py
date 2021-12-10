import sys

def fuel(start, end):
    return abs(start - end)

def fuel_2(start, end):
    return ((fuel(start, end)) * (fuel(start, end) + 1))/ 2

input_file = open(sys.argv[1], "r+")
input_lines = input_file.readlines()
positions = map(lambda x: int(x), input_lines[0].split(','))
print positions
# positions = [16,1,2,0,4,2,7,1,2,14]
min_input = min(positions)
max_input = max(positions)
result = dict()
for X in range(min_input, max_input + 1):
    acc = 0
    for i in positions:
        acc += fuel_2(X, i)
    result[acc] = X

min_fuel = min(result.keys())
print min_fuel
print result[min_fuel]

