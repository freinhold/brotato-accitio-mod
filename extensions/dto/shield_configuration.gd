class_name ShieldConfiguration

var base_interval: int
var stat: String
var scaling: float
var min_interval: int
var valid: bool = false

func _init(base_interval: int, stat: String, scaling: float, min_interval: int):
	self.base_interval = base_interval
	self.stat = stat
	self.scaling = scaling
	self.min_interval = min_interval
	self.valid = true
