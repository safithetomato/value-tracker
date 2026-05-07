extends Control
class_name ValueTracker

@export var MaxSeprates: int = 60
@export var AlwaysClamp: bool = false
@export var UseCustom: bool = false
@export var CustomMax: float = 100
@export var CustomMin: float = 0

@onready var color_rect: ColorRect = $ColorRect
@onready var max_label: Label = $MaxLabel
@onready var min_label: Label = $MinLabel

var down_left_corner: Vector2
var up_right_corner: Vector2

var values_array: Array = []

var max_value: float = 0.0
var min_value: float = 0.0

var line: Line2D = null
var new_line: Line2D

func _ready() -> void:
	down_left_corner = color_rect.get_begin()
	up_right_corner = color_rect.get_end()
	if UseCustom:
		max_value = CustomMax
		min_value = CustomMin
		max_label.text = str(int(max_value))
		min_label.text = str(int(min_value))
	new_line = Line2D.new()
	new_line.width = 5
	
	
	##testing
	#var smooth_value = 50.0
	#for i in range(500):
		#smooth_value = lerp(smooth_value,randf_range(smooth_value - 100,smooth_value + 100),0.1)
		#add_value(smooth_value)
		#await get_tree().create_timer(0.1).timeout
		#if i%12 == 1:
			#reset_tracker()

func add_value(value: float):
	values_array.append(value)
	if values_array.size() > MaxSeprates:
		values_array.remove_at(0)
	if !UseCustom:
		if AlwaysClamp:
			max_value = values_array.max()
			min_value = values_array.min()
			
			max_label.text = str(int(max_value))
			min_label.text = str(int(min_value))
		else:
			max_value = max(max_value, value)
			min_value = min(min_value, value)
			
			max_label.text = str(int(max_value))
			min_label.text = str(int(min_value))
	_update_line()

func reset_tracker():
	values_array.clear()
	for child in get_children():
		if child is Line2D:
			child.queue_free()
	max_value = 0.0
	min_value = 0.0
	max_label.text = "Max"
	min_label.text = "Min"

func _update_line():
	
	var new_points: PackedVector2Array
	
	if line == null:
		new_line = Line2D.new()
		new_line.width = 5
		add_child(new_line)
		line = new_line
		
	line.clear_points()
	
	var values_range: float = max_value - min_value
	
	for point in values_array.size():
		
		var distance_from_start = float(point) / float(values_array.size())
		var percentage_from_max = 1-clampf((values_array[point] - min_value) / values_range, 0.0, 1.0)
		var new_x = lerp(down_left_corner.x,up_right_corner.x,distance_from_start)
		var new_y = lerp(down_left_corner.y,up_right_corner.y,percentage_from_max)
		print(new_y)
		new_points.append(Vector2(new_x,new_y))
	line.points = new_points
	
