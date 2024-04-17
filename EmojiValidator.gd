extends LineEdit

@export var pattern = ""
@onready var regex = RegEx.create_from_string(pattern)

func check(tet):
	if text == "":
		return
	print("Checking!")
	print(text[0].unicode_at(0))
	if OS.get_name() == "Web":
		if text[0].unicode_at(0) < 100_000:
			text = ""
	else:
		print(regex.search(text))
		if regex.search(text) == null:
			text = ""
