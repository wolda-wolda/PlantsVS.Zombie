extends Node


# DIRECTORIES

const dirPlants: String = "res://Plants/"
const dirZombies: String = "res://Zombies/"

# Returns an array with the paths of the found entities
func getEntities(directory: String) -> Array:
	return findFiles(directory, "_Object.tres")

# Finds files with a file name that include a given text
# in a given directory and return their path
func findFiles(startDir: String, regex: String, excludedFolders: Array = []) -> Array:
	var foundFiles: Array = []
	var dir: Directory = Directory.new()
	if dir.open(startDir) == OK:
		dir.list_dir_begin()
		var fileName: String = dir.get_next()
		while fileName != "":
			if dir.current_is_dir() and !_isParentOrCurrent(fileName) and !excludedFolders.has(fileName):
				foundFiles.append_array(findFiles(startDir + fileName + "/", regex, excludedFolders))
			else:
				if fileName.ends_with(regex):
					foundFiles.push_back(startDir + "/" + fileName)
			fileName = dir.get_next()
		return foundFiles
	return foundFiles

# Checks if a found directory is either a parent or the current directory
func _isParentOrCurrent(fileName: String) -> bool:
	return fileName == "." or fileName == ".."
