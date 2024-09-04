extends Node


const AUTHORNAME_MODNAME_DIR := "accitio-example"
const LOGGER := "accitio-example:Main"

var dir = ""

# Before v6.1.0
# func _init(modLoader = ModLoader) -> void:
func _init(modLoader = ModLoader) -> void:
	dir = ModLoaderMod.get_unpacked_dir().plus_file(AUTHORNAME_MODNAME_DIR) + "/"
	
	# Add extensions
	install_script_extensions()
	# Add translations
	add_translations()

func install_script_extensions() -> void:
	ModLoaderLog.info("Loading files from dir " + dir, LOGGER)
	ModLoaderMod.install_script_extension(dir + "extensions/singletons/run_data.gd")
	ModLoaderMod.install_script_extension(dir + "extensions/singletons/player_run_data.gd")
	ModLoaderMod.install_script_extension(dir + "extensions/singletons/item_service.gd")

func loadContent() -> void: 
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
	var content_dir = dir + "content_data/"
	
	ContentLoader.load_data(content_dir + "example1_characters.tres", LOGGER)


func add_translations() -> void:
	ModLoaderMod.add_translation(dir + "translations/mod_example_text.en.translation")


func _ready() -> void:	
	loadContent()
	ModLoaderLog.info("Ready!", LOGGER)
