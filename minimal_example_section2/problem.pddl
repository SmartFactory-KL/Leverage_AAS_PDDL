(define (problem turnOffSwitch)
	(:domain on_off_switch)

(:objects 
    on_off_switch - switch
)

(:init
    (on on_off_switch)
)

(:goal (and
    (not (on on_off_switch))
)))



