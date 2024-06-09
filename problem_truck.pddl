(define (problem battery_pack) (:domain demonstrator_kuba)
(:objects 
    semitrailer_truck - product
    semitrailer - product
    truck - product

    p3 - module; QC module
    p24hbw - module; Storage Module high bay warehouse
    p24hbwrobot - module
    p24la - module; Transport Module linear axis in the high bay warehouse
    p14 - module; TSN Module
    p6 - module; SYLT
    t2 - module; AcoposTrack
    amr2 - module; Emrox-AMR

    t2xp3 - location
    t2xp6 - location
    t2xp14 - location
    amr2xt2 - location
    amr2xla - location
    laxrobi - location
    robixhbw - location
    hbw_storage - location

    p6_delivery_storage - storage
    assembly_storage - storage
    t2_storage - storage
    p24hbw_storage - storage
    p24la_storage - storage
    amr2_storage - storage
    p24hbw_robot_storage - storage

    type_external_storage - external_storage_type

    camera_resource - camera_resource
    transport_resource - transport_resource
    assemble_resource - assemble_resource
    storage_resource - storage_resource
)

(:init
    (accessibleBy t2 t2xp3)
    (accessibleBy p3 t2xp3)
    (accessibleBy p14 t2xp14)
    (accessibleBy t2 t2xp14)
    (accessibleBy amr2 amr2xt2)
    (accessibleBy t2 amr2xt2)
    (accessibleBy amr2 amr2xla)
    (accessibleBy p24la amr2xla)
    (accessibleBy p24la laxrobi)
    (accessibleBy p24hbwrobot laxrobi)
    (accessibleBy p24hbwrobot robixhbw)
    (accessibleBy p24hbw robixhbw)
    (accessibleBy hbw_storage p24hbw)
    (accessibleBy t2 t2xp6)
    (accessibleBy p6 t2xp6)

    (contains t2 t2_storage)
    (contains p24hbw p24hbw_storage)
    (contains p14 assembly_storage)
    (contains p6 p6_delivery_storage)
    (contains p24la p24la_storage)
    (contains amr2 amr2_storage)
    (contains p24hbwrobot p24hbw_robot_storage)


    (involveProduct p3 camera_resource truck)
    (involveProduct p3 camera_resource semitrailer_truck)
    (involveProduct p3 camera_resource semitrailer)
    (involveProduct p6 storage_resource semitrailer_truck)
    (involveProduct p6 storage_resource semitrailer)
    (involveProduct p6 storage_resource truck)
    (involveProduct t2 transport_resource truck)
    (involveProduct t2 transport_resource semitrailer)
    (involveProduct t2 transport_resource semitrailer_truck)
    (involveProduct amr2 transport_resource truck); amr is transport_resource
    (involveProduct amr2 transport_resource semitrailer); amr is transport_resource
    (involveProduct amr2 transport_resource semitrailer_truck); amr is transport_resource
    (involveProduct amr2 storage_resource semitrailer_truck); amr is storage_resource
    (involveProduct amr2 storage_resource semitrailer); amr is storage_resource
    (involveProduct amr2 storage_resource truck); amr is storage_resource
    (involveProduct p14 assemble_resource truck)
    (involveProduct p14 assemble_resource semitrailer)
    (involveProduct p14 assemble_resource semitrailer_truck)
    (involveProduct p14 storage_resource semitrailer_truck)
    (involveProduct p14 storage_resource semitrailer)
    (involveProduct p14 storage_resource truck)
    (involveProduct p24hbwrobot storage_resource truck)
    (involveProduct p24hbwrobot storage_resource semitrailer)
    (involveProduct p24hbwrobot storage_resource semitrailer_truck)
    (involveProduct p24hbw transport_resource semitrailer_truck)
    (involveProduct p24hbw transport_resource semitrailer)
    (involveProduct p24hbw transport_resource truck)
    (involveProduct p24hbw storage_resource truck); high bay warehouse in storage module is storage_resource
    (involveProduct p24hbw storage_resource semitrailer); high bay warehouse in storage module is storage_resource
    (involveProduct p24hbw storage_resource semitrailer_truck); high bay warehouse in storage module is storage_resource
    (involveProduct p24la transport_resource semitrailer_truck); linear axis in storage module is transport_resource
    (involveProduct p24la transport_resource semitrailer); linear axis in storage module is transport_resource
    (involveProduct p24la transport_resource truck); linear axis in storage module is transport_resource
    (involve p24la transport_resource)
    (involve p24hbw transport_resource)
    (involve amr2 transport_resource)
    (involve t2 transport_resource)

    ; Truck consists of semitrailer and semitrailer_truck
    (part-of semitrailer truck)
    (part-of semitrailer_truck truck)

    ;(assemble-order semitrailer_truck semitrailer truck); assemble semitrailer_truck and semitrailer to truck

    (capacity p6_delivery_storage truck)
    (capacity t2_storage semitrailer)
    (capacity t2_storage semitrailer_truck)
    (capacity t2_storage truck)
    (capacity assembly_storage semitrailer)
    (capacity assembly_storage semitrailer_truck)
    (capacity assembly_storage truck)
    ;capacities for all storage componentes 
    (capacity p24hbw_storage semitrailer)
    (capacity p24hbw_storage semitrailer_truck)
    (capacity p24la_storage semitrailer)
    (capacity p24la_storage semitrailer_truck)
    (capacity p24hbw_robot_storage semitrailer)
    (capacity p24hbw_robot_storage semitrailer_truck)
    (capacity amr2_storage semitrailer)
    (capacity amr2_storage semitrailer_truck)

    (stock p24hbw_storage semitrailer)
    (stock p24hbw_storage semitrailer_truck)

    (storage_type_of_storage type_external_storage p6_delivery_storage)
    (storage_type_of_storage type_external_storage assembly_storage)
    (storage_type_of_storage type_external_storage t2_storage)
    (storage_type_of_storage type_external_storage p24hbw_storage)
    (storage_type_of_storage type_external_storage p24la_storage)
    (storage_type_of_storage type_external_storage amr2_storage)
    (storage_type_of_storage type_external_storage p24hbw_robot_storage)
)

(:goal (and
    (stock p6_delivery_storage truck)
    (qualityOk truck)
    ;(forall (?l1 - location) (imply (accessibleBy p6 ?l1) (not (freeAt ?l1))))
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
