# scripts/global.gd
extends Node

var score: int = 0
var wave: int = 0
var best_wave: int = 0

signal enemy_killed
signal player_died
signal wave_started(new_wave)
signal wave_cleared
signal upgrade_selected(upgrade_name)
