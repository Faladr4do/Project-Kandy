extends VBoxContainer

@export var nome_bus : String

@onready var titulo = $Label
@onready var slider = $HSlider

var index_bus

func _ready():
	titulo.text = nome_bus
	if titulo.text == "Master":
		titulo.text = "Volume Geral"
	index_bus = AudioServer.get_bus_index(nome_bus)
	slider.value_changed.connect(ao_mudar_valor)
	slider.value = db_to_linear(
		AudioServer.get_bus_volume_db(index_bus)
	)
	print_debug(nome_bus, slider.value)
	print_available_buses()

func ao_mudar_valor(valor):
	AudioServer.set_bus_volume_db(
		index_bus,
		linear_to_db(valor)
	)

func print_available_buses():
	var bus_count = AudioServer.get_bus_count()
	print("Available buses:")
	for i in range(bus_count):
		var bus_name = AudioServer.get_bus_name(i)
		print(i, ": ", bus_name)
