class_name Partol_Path
extends Node2D
##Controls all the logic for the partol path node

var path_points = {}  ##Dictionary that contains all the points on a path

func get_path_points(): ##Fills path_point with every point on the line2d, and gives them a dictionary number
	var digit : int = 0 #Number that is given to each point in path_points as the key
	for i in get_parent().points: #Loop that fills path_points
		path_points[digit] = i #Assigns each point a key and a position corresponding to the key
		digit += 1  #Adds one for the next point in path_points
	print(path_points)

func get_next_point(current : int): ##Gets the next point in path_points
	var next_point #Contian the next point
	next_point = current + 1 #Defines next point as current point plus one
	if next_point == get_amount_of_points(): #If statement that defines next point as zero if  next point doesn't exist
		next_point = 0
	return next_point #Returns the next point

func get_closest_point(point : Vector2): ##Gets closest point from path_points to the point given
	var length_to_point : float = (point - path_points[0]).length() #Contains length to each point in path_points from point given by function
	var closest_point : int #Contains the number of the closest point
	
	for i in path_points: ##Loop that cycles through path_points and returns the closest
		var path_point = path_points[i] #Get a speific point from path_points
		
		if (point - path_point).length() < length_to_point: #Determines which point is the closest
			
			length_to_point = (point - path_point).length() #Sets length_to_point as the closet point to 
			closest_point = i
	return closest_point #returns the closest point

func get_point_position(point : int): ##Returns the position of a point
	return path_points[point]

func get_amount_of_points(): ##Returns the amount of points in the path_points
	var max_point = get_parent().get_point_count()
	return max_point
