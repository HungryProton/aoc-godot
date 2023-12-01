extends Day


var digits: Array[String]


func solve_first() -> String:
	digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
	return _solve()


func solve_second() -> String:
	digits = [
		"1", "2", "3", "4", "5", "6", "7", "8", "9",
		"one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
	]
	return _solve()


func _solve() -> String:
	var sum := 0
	for line in input:
		if line.is_empty():
			continue
		
		var first: String = find_first(line, false)
		var last: String = find_first(line, true)
		sum += (first + last).to_int()

	return str(sum)


func find_first(line: String, reverse: bool = false) -> String:
	if reverse:
		line = line.reverse()
	
	var first: String
	var first_index = line.length() + 1
	
	for number_idx in digits.size():
		var number: String = digits[number_idx]
		if reverse:
			number = number.reverse()
		
		var index: int = line.find(number)
		if index == -1:
			continue
		
		if index < first_index:
			first_index = index
			if number_idx > 8:
				first = digits[number_idx - 9]
			else:
				first = digits[number_idx]

	return first
