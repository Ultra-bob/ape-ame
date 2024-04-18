extends LineEdit

@export var pattern = ""
@onready var regex = RegEx.create_from_string(pattern)

func check(tet):
	if text == "":
		return
	print("Checking!")
	if text.to_upper() != text:
		var cursor = caret_column
		text = text.to_upper()
		caret_column = cursor
	var result = regex.search(text)
	if result == null:
		text = ""
	elif len(text) != result.get_end() and result.get_end() != 3:
		var cursor = caret_column
		text = text.substr(0, result.get_end())
		caret_column = cursor
