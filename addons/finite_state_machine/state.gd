@icon("res://addons/finite_state_machine/action.png")
@abstract extends Node
class_name State

signal transitioned

@abstract func enter()
@abstract func exit()
@abstract func process(delta: float)
@abstract func physics_process(delta: float)
