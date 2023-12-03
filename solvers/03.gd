extends Day


func solve_first() -> String:
	var sum := 0
	
	for line_idx in input.size():
		var current_line: String = input[line_idx]
		var lines_idx: Array[int] = _get_adjacent_lines_idx(line_idx)
		var numbers = _extract_numbers(current_line)

		# For each number, find the position of every characters around
		for number_idx in numbers:
			var number_str: String = numbers[number_idx]
			var number_int: int = number_str.to_int()

			# Get the indices to check on previous, current and next line (if any)
			var adjacent_indices: Array[int] = []
			for i in range(number_idx - 1, number_idx + number_str.length() + 1):
				adjacent_indices.push_back(i)
			
			var is_part := false
			for l_idx in lines_idx:
				for idx in adjacent_indices:
					if _is_part_symbol(input[l_idx], idx):
						is_part = true
						break
				if is_part:
					break
			
			if is_part:
				sum += number_int
	
	return str(sum)


func solve_second() -> String:
	var sum := 0
	var gears := {}
	
	for line_idx in input.size():
		var current_line: String = input[line_idx]
		var lines_idx: Array[int] = _get_adjacent_lines_idx(line_idx)
		var numbers = _extract_numbers(current_line)
		
		for number_idx in numbers:
			var number_str = numbers[number_idx]
			var number_int = number_str.to_int()
			
			# Find the adjacent * symbols
			var adjacent_gears: Array[Vector2i] = []
			
			# Get the indices to check on previous, current and next line (if any)
			var adjacent_indices: Array[int] = []
			for i in range(number_idx - 1, number_idx + number_str.length() + 1):
				adjacent_indices.push_back(i)
			
			for l_idx in lines_idx:
				for idx in adjacent_indices:
					if _is_gear_symbol(input[l_idx], idx):
						adjacent_gears.push_back(Vector2i(l_idx, idx))

			for g in adjacent_gears:
				if not gears.has(g):
					gears[g] = []
				gears[g].push_back(number_int)
	
	for g in gears:
		var values: Array = gears[g]
		if values.size() != 2:
			continue
		sum += values[0] * values[1]
		
	return str(sum)


func _is_part_symbol(line: String, idx: int) -> bool:
	if idx < 0 or idx >= line.length():
		return false
	
	var char: String = line[idx]
	return not (char == "." or char.is_valid_int())


func _is_gear_symbol(line: String, idx: int) -> bool:
	if idx < 0 or idx >= line.length():
		return false
	
	return line[idx] == "*"


func _extract_numbers(line: String) -> Dictionary:
	var numbers := {}
	var position := 0
	var current_number := ""
	
	for i in line.length():
		var char: String = line[i]
		if char.is_valid_int():
			if current_number.is_empty():
				position = i
			current_number += char
		elif not current_number.is_empty():
			numbers[position] = current_number
			current_number = ""
	
	if current_number.is_valid_int():
		numbers[position] = current_number
	
	return numbers


# Returns the previous, current and next line (if any)
func _get_adjacent_lines_idx(line_idx: int) -> Array[int]:
	var lines: Array[int] = []
	if line_idx > 0: # Previous
		lines.push_back(line_idx - 1)

	lines.push_back(line_idx) # Current
	
	if line_idx < input.size() - 1: # Next
		lines.push_back(line_idx + 1)
	
	return lines
