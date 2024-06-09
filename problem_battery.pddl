(define (problem battery_pack) (:domain demonstrator_kuba)
(:objects 
    battery_pack - product
    battery_case - product
    battery_red - product
    battery_black - product

    p3 - module
    p5 - module
    p6 - module
    t2 - module
    
    temporary_assembly_storage - storage
    temporary_labelPrinter_storage - storage
    storage_5G - storage
    delivery_storage_LabelPrinter - storage
    t2_storage - storage

    t2xp3 - location
    t2xp5 - location
    t2xp6 - location

    type_external_storage - external_storage_type

    camera_resource - camera_resource
    transport_resource - transport_resource
    assemble_resource - assemble_resource
    storage_resource - storage_resource
)

(:init

    (accessibleBy t2 t2xp3)
    (accessibleBy p3 t2xp3)
    (accessibleBy t2 t2xp5)
    (accessibleBy p5 t2xp5)
    (accessibleBy t2 t2xp6)
    (accessibleBy p6 t2xp6)

    (contains t2 t2_storage)
    (contains p5 storage_5G)
    (contains p6 temporary_assembly_storage)
    (contains p6 temporary_labelPrinter_storage)
    (contains p6 delivery_storage_LabelPrinter)

    (involveProduct p3 camera_resource battery_pack)
    (involveProduct t2 transport_resource battery_pack)
    (involveProduct t2 transport_resource battery_case)
    (involveProduct p6 assemble_resource battery_pack)
    (involveProduct p6 assemble_resource battery_case)
    (involveProduct p6 assemble_resource battery_red)
    (involveProduct p6 assemble_resource battery_black)
    (involveProduct p6 storage_resource battery_pack)
    (involveProduct p6 storage_resource battery_case)
    (involveProduct p6 storage_resource battery_red)
    (involveProduct p6 storage_resource battery_black)
    (involveProduct p5 storage_resource battery_case)
    (involveProduct p5 storage_resource battery_pack)
    (involve t2 transport_resource)

    (part-of battery_case battery_pack)
    (part-of battery_red battery_pack)
    (part-of battery_black battery_pack)

    (assemble-order battery_case battery_red battery_pack)
    (assemble-order battery_case battery_black battery_pack)

    (capacity temporary_assembly_storage battery_pack)
    (capacity temporary_assembly_storage battery_case)
    (capacity storage_5G battery_pack)
    (capacity t2_storage battery_case)
    (capacity t2_storage battery_pack)
    (stock storage_5G battery_case)
    (stock temporary_assembly_storage battery_black)
    (stock temporary_assembly_storage battery_red)

    (storage_type_of_storage type_external_storage temporary_assembly_storage)
    (storage_type_of_storage type_external_storage temporary_labelPrinter_storage)
    (storage_type_of_storage type_external_storage storage_5G)
    (storage_type_of_storage type_external_storage delivery_storage_LabelPrinter)
    (storage_type_of_storage type_external_storage t2_storage)

    (qualityOk battery_case)
    (qualityOk battery_red)
    (qualityOk battery_black)
    (enable_qc)
)

(:goal (and
    (stock storage_5G battery_pack)
    (qualityOk battery_pack)
    ;(forall (?l1 - location) (imply (accessibleBy p5 ?l1) (not (freeAt ?l1))))
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
