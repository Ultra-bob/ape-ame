extends Resource

class_name Wave

@export var enemies: Array[WaveEnemy]
@export var quantities: Array[int]
@export var spawning_duration: float = 1
@export var wait: float = 1
@export var wait_for_killed = true
