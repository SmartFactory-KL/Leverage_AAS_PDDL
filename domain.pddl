;Header and description

(define (domain demonstrator_kuba)

;remove requirements that are not needed
;(:requirements :strips :typing :conditional-effects :fluents :disjunctive-preconditions :negative-preconditions)
(:requirements :action-costs :adl :equality :typing)

(:types module
		product
		storage
		internal_storage_type - storage_type
		external_storage_type - storage_type
		location
		transport_resource - resource
		assemble_resource - resource
		camera_resource - resource
		storage_resource - resource
)

; un-comment following line if constants are needed
;(:constants )

(:predicates
    (at ?p1 - product ?l1 - location ?s1 - storage)
    (freeAt ?l1 - location ?s1 - storage)
	(part-of ?p1 ?p2 - product)
    (qualityOk ?p1 - product)
    (capacity ?s1 - storage ?p1 - product)
	(involveProduct ?m1 - module ?r1 - resource ?p1 - product)
	(involve ?m1 - module ?r1 - resource)
    (stock ?s1 - storage ?p1 - product)
	(integrated ?p1 ?p2 - product)
	(assemble-order ?p1 ?p2 ?p3 - product)
    (accessibleBy ?m1 - module ?l1 - location)
    (contains ?m1 - module ?s1 - storage)
	(storage_type_of_storage ?st1 - storage_type ?s1 - storage)
	(enable_qc)
)
;(:functions)

;define actions here
(:action getTransport
	:parameters (?p1 - product ?r1 - transport_resource ?m1 - module ?l1 - location ?s1 - storage)
	:precondition (and
		(involveProduct ?m1 ?r1 ?p1)
        (stock ?s1 ?p1)
    	(contains ?m1 ?s1)
		(accessibleBy ?m1 ?l1)
        (forall (?l2 - location) (imply (accessibleBy ?m1 ?l2) (not (at ?p1 ?l2 ?s1))))
		(not (freeAt ?l1 ?s1))
        (forall (?p2 - product) (imply (stock ?s1 ?p2) (not (at ?p2 ?l1 ?s1))))
    )
	:effect (
        at ?p1 ?l1 ?s1
	)
)

;define actions here
(:action getEmptyTransport
	:parameters (?m1 - module ?l1 - location ?s1 - storage ?r1 - transport_resource)
	:precondition (and
		(involve ?m1 ?r1)
		(accessibleBy ?m1 ?l1)
		(contains ?m1 ?s1)
        ;(forall (?l2 - location) (imply (accessibleBy ?m1 ?l2) (not (freeAt ?l2 ?s1))))
        (forall (?p1 - product) (imply (stock ?s1 ?p1) (not (at ?p1 ?l1 ?s1))))
    )
	:effect (
		freeAt ?l1 ?s1
	)
)

(:action releaseTransport
	:parameters (?p1 - product ?r1 - transport_resource ?m1 - module ?l1 - location ?s1 - storage)
	:precondition (and
		(accessibleBy ?m1 ?l1)
        (stock ?s1 ?p1)
    	(contains ?m1 ?s1)
		(involveProduct ?m1 ?r1 ?p1)
		(at ?p1 ?l1 ?s1)
    )
	:effect (
        not (at ?p1 ?l1 ?s1)
	)
)

(:action releaseEmptyTransport
	:parameters (?m1 - module ?l1 - location ?r1 - transport_resource ?s1 - storage)
	:precondition (and
		(involve ?m1 ?r1)
		(accessibleBy ?m1 ?l1)
    	(contains ?m1 ?s1)
		(freeAt ?l1 ?s1)
    )
	:effect (
		not (freeAt ?l1 ?s1)
	)
)

(:action assemble
	:parameters (?p1 ?p2 - product ?m1 - module ?r1 - assemble_resource ?s1 - storage)
	:precondition (and
		(involveProduct ?m1 ?r1 ?p1)
		(involveProduct ?m1 ?r1 ?p2)
		(and (stock ?s1 ?p1) (contains ?m1 ?s1) (capacity ?s1 ?p2))
    	(imply (enable_qc) (qualityOk ?p1))
        (part-of ?p1 ?p2)
		(not (integrated ?p1 ?p2))
		(forall (?p3 - product)
			(imply (assemble-order ?p3 ?p1 ?p2)
				(integrated ?p3 ?p2)))
    )
	:effect (and
		(integrated ?p1 ?p2)
		(not (stock ?s1 ?p1))
		(when (not (exists (?p4 - product)
		    (and (part-of ?p4 ?p2)
	    		(not (= ?p4 ?p1))
				(not (integrated ?p4 ?p2)))))
		(and (stock ?s1 ?p2)
			(not (qualityOk ?p2))))
	)
)

(:action checkQuality
	:parameters (?p1 - product ?m1 - module ?l1 - location ?s1 - storage ?r1 - camera_resource)
	:precondition (and
		(accessibleBy ?m1 ?l1)
		(and (at ?p1 ?l1 ?s1) (involveProduct ?m1 ?r1 ?p1))
    )
	:effect (and
        (qualityOk ?p1)
	)
)

(:action store
	:parameters (?p1 - product ?m1 ?m2 - module ?l1 - location ?s1 ?s2 - storage ?est1 - external_storage_type ?r1 - storage_resource ?r2 - transport_resource)
	:precondition (and
		(and (accessibleBy ?m1 ?l1) (contains ?m1 ?s2))
        (and (accessibleBy ?m2 ?l1) (contains ?m2 ?s1))
		(imply (involve ?m1 ?r2) (or (freeAt ?l1 ?s2) (exists (?p2 - product) (at ?p2 ?l1 ?s2))))
		(imply (involve ?m2 ?r2) (at ?p1 ?l1 ?s1))
		(involveProduct ?m1 ?r1 ?p1)
        (and (stock ?s1 ?p1) (capacity ?s2 ?p1))
		(storage_type_of_storage ?est1 ?s1)
    )
	:effect (and
		(when (involve ?m1 ?r2) (and (not (freeAt ?l1 ?s2)) (at ?p1 ?l1 ?s2)))
		(when (involve ?m2 ?r2) (and (freeAt ?l1 ?s1) (not (at ?p1 ?l1 ?s1))))
        (stock ?s2 ?p1)
		(not (stock ?s1 ?p1))
	)
)

(:action deplete
	:parameters (?p1 - product ?m1 ?m2 - module ?l1 - location ?s1 ?s2 - storage ?est1 - external_storage_type ?r1 - storage_resource ?r2 - transport_resource)
	:precondition (and
		(and (accessibleBy ?m1 ?l1) (contains ?m1 ?s2))
        (and (accessibleBy ?m2 ?l1) (contains ?m2 ?s1))
		(imply (involve ?m1 ?r2) (at ?p1 ?l1 ?s2))
		(imply (involve ?m2 ?r2) (or (freeAt ?l1 ?s1) (exists (?p2 - product) (at ?p2 ?l1 ?s1))))
		(involveProduct ?m1 ?r1 ?p1)
        (and (stock ?s2 ?p1) (capacity ?s1 ?p1))
		(storage_type_of_storage ?est1 ?s1)
    )
	:effect (and
		(when (involve ?m2 ?r2) (and (not (freeAt ?l1 ?s1)) (at ?p1 ?l1 ?s1)))
		(when (involve ?m1 ?r2) (and (not (at ?p1 ?l1 ?s2)) (freeAt ?l1 ?s2)))
		;(when (and (forall (?p2 - product) (not (at ?p2 ?l1 ?s2))) (involve ?m1 ?r2)) (freeAt ?l1 ?s2))
    	(stock ?s1 ?p1)
		(not (stock ?s2 ?p1))
	)
)
)