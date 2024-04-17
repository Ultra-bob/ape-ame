extends LineEdit

@export var pattern = ""
@onready var regex = RegEx.create_from_string(pattern)

func check(tet):
	if len(text) > 1:
		text = text[0]
	print("Checking!")
	print(regex.search(text))
	if regex.search(text) == null:
		text = ""
