extends Day


func solve_first() -> String:
	var sum := 0
	for line in input:
		var card := _parse_card(line)
		var winning_numbers := card.get_winning_number_count()
		if winning_numbers > 0:
			sum += pow(2, winning_numbers - 1)

	return str(sum)


func solve_second() -> String:
	var duplicates: Array[int] = []
	duplicates.resize(input.size())
	duplicates.fill(1)
	
	for line_idx in input.size():
		var line: String = input[line_idx]
		var card := _parse_card(line)
		var winning_numbers := card.get_winning_number_count()

		for _d in duplicates[line_idx]:
			for i in winning_numbers:
				var next_idx = line_idx + i + 1
				if next_idx >= duplicates.size():
					break
				duplicates[next_idx] += 1
	
	print(duplicates)
	var total_cards := 0
	for d in duplicates:
		total_cards += d
	
	return str(total_cards)


func _parse_card(line: String) -> Card:
	var card := Card.new()
	
	var s1 := line.split(":", false)
	card.id = s1[0].split(" ", false)[1].to_int()
	
	var s2 := s1[1].split("|", false)
	
	for c in s2[0].split(" ", false):
		card.winning.push_back(c.to_int())
		
	for c in s2[1].split(" ", false):
		card.numbers.push_back(c.to_int())
	
	return card


class Card:
	var id: int
	var winning: PackedInt32Array
	var numbers: PackedInt32Array
	
	func _init() -> void:
		winning = PackedInt32Array()
		numbers = PackedInt32Array()

	func _to_string() -> String:
		return str(id) + ': ' + str(winning) + ' | ' + str(numbers)
	
	func get_winning_number_count() -> int:
		var count := 0
		for n in numbers:
			if n in winning:
				count += 1
		return count
