(define (domain on_off_switch)

(:requirements :adl :typing)
(:types switch)
(:predicates (on ?s1 - switch))

(:action turnOff
	:parameters (?s1 - switch)
	:precondition (on ?s1)
	:effect (not (on ?s1))
)
(:action turnOn
	:parameters (?s1 - switch)
	:precondition (not (on ?s1))
	:effect (on ?s1)
))




