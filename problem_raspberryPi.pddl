(define (problem ricaip_assemble) (:domain demonstrator_kuba)
(:objects 
    raspberry_pi - product
    case_top - product
    case_bottom - product
    circuit_board - product
    fan - product
    top_with_fan - product
    bottom_with_board - product

    assembly_station - module
    station_assembly - location
    assembly_stage - storage
    temporary_raw_part_storage_bottom - storage; Assembly holt sich bottoms
    temporary_raw_part_storage_fan - storage; Assembly holt sich fans
    temporary_raw_part_storage_board - storage; Assembly holt sich boards
    temporary_raw_part_storage_top - storage; Assembly holt sich case tops
    temporary_final_product_storage - storage; Assembly legt hier ab
    
    amr - module
    amr_storage - storage

    raw_part_provision - module
    bin_picking - location
    final_product_storage - storage
    raw_part_storage_bottom - storage
    raw_part_storage_fan - storage
    raw_part_storage_board - storage
    raw_part_storage_top - storage
    final_raw_part_storage - storage


    type_raw_parts_temporal_storage - external_storage_type
    type_finished_parts_temporal_storage - external_storage_type
    type_finished_parts_storage - external_storage_type
    type_raw_parts_storage - external_storage_type
    type_assembly_stage - internal_storage_type
    type_amr_storage - internal_storage_type

    storage_resource - storage_resource
    transport_resource - transport_resource
    assemble_resource - assemble_resource
)

(:init
    ;Assembly Station Modul Initialisierung
    (accessibleBy assembly_station station_assembly)
    (contains assembly_station temporary_raw_part_storage_bottom)
    (contains assembly_station temporary_raw_part_storage_fan)
    (contains assembly_station temporary_raw_part_storage_board)
    (contains assembly_station temporary_raw_part_storage_top)
    (contains assembly_station temporary_final_product_storage)
    (contains assembly_station assembly_stage)

    (storage_type_of_storage type_assembly_stage assembly_stage)
    (storage_type_of_storage type_raw_parts_temporal_storage temporary_raw_part_storage_bottom)
    (storage_type_of_storage type_raw_parts_temporal_storage temporary_raw_part_storage_fan)
    (storage_type_of_storage type_raw_parts_temporal_storage temporary_raw_part_storage_board)
    (storage_type_of_storage type_raw_parts_temporal_storage temporary_raw_part_storage_top)
    (storage_type_of_storage type_finished_parts_temporal_storage temporary_final_product_storage)

    ;Bin-Picking Modul Initialisierung
    (accessibleBy raw_part_provision bin_picking)
    (contains raw_part_provision final_product_storage)
    (contains raw_part_provision raw_part_storage_bottom)
    (contains raw_part_provision raw_part_storage_fan)
    (contains raw_part_provision raw_part_storage_board)
    (contains raw_part_provision raw_part_storage_top)

    (storage_type_of_storage type_finished_parts_storage final_product_storage)
    (storage_type_of_storage type_raw_parts_storage raw_part_storage_bottom)
    (storage_type_of_storage type_raw_parts_storage raw_part_storage_fan)
    (storage_type_of_storage type_raw_parts_storage raw_part_storage_board)
    (storage_type_of_storage type_raw_parts_storage raw_part_storage_top)

    ;Initialisierung AMR
    (accessibleBy amr bin_picking)
    (accessibleBy amr station_assembly)
    (contains amr amr_storage)
    (storage_type_of_storage type_amr_storage amr_storage)

    
    (storage_type_of_storage type_assembly_stage assembly_stage)

    (involveProduct amr transport_resource raspberry_pi); amr is transport_resource
    (involveProduct amr transport_resource case_top); amr is transport_resource
    (involveProduct amr transport_resource case_bottom); amr is transport_resource
    (involveProduct amr transport_resource circuit_board); amr is transport_resource
    (involveProduct amr transport_resource fan); amr is transport_resource
    (involveProduct amr storage_resource raspberry_pi); amr is storage_resource
    (involveProduct amr storage_resource case_top); amr is storage_resource
    (involveProduct amr storage_resource case_bottom); amr is storage_resource
    (involveProduct amr storage_resource circuit_board); amr is storage_resource
    (involveProduct amr storage_resource fan); amr is storage_resource
    (involveProduct assembly_station assemble_resource raspberry_pi); amr is transport_resource
    (involveProduct assembly_station assemble_resource case_top); amr is transport_resource
    (involveProduct assembly_station assemble_resource case_bottom); amr is transport_resource
    (involveProduct assembly_station assemble_resource circuit_board); amr is transport_resource
    (involveProduct assembly_station assemble_resource fan); amr is transport_resource
    (involveProduct assembly_station assemble_resource top_with_fan); amr is transport_resource
    (involveProduct assembly_station assemble_resource bottom_with_board); amr is transport_resource
    (involveProduct assembly_station storage_resource bottom_with_board); amr is storage_resource
    (involveProduct assembly_station storage_resource top_with_fan); amr is storage_resource
    (involveProduct assembly_station storage_resource fan); amr is storage_resource
    (involveProduct assembly_station storage_resource circuit_board); amr is storage_resource
    (involveProduct assembly_station storage_resource case_bottom); amr is storage_resource
    (involveProduct assembly_station storage_resource case_top); amr is storage_resource
    (involveProduct assembly_station storage_resource raspberry_pi); amr is storage_resource
    (involve amr transport_resource); amr is storage_resource


    (part-of case_top top_with_fan)
    (part-of case_bottom bottom_with_board)
    (part-of fan top_with_fan)
    (part-of circuit_board bottom_with_board)
    (part-of bottom_with_board raspberry_pi)
    (part-of top_with_fan raspberry_pi)

    (assemble-order case_bottom circuit_board bottom_with_board)
    (assemble-order case_top fan top_with_fan)
    (assemble-order bottom_with_board top_with_fan raspberry_pi)


    (capacity amr_storage raspberry_pi)
    (capacity amr_storage case_top)
    (capacity amr_storage case_bottom)
    (capacity amr_storage circuit_board)
    (capacity amr_storage fan)

    (capacity raw_part_storage_bottom case_bottom)
    (capacity raw_part_storage_fan fan)
    (capacity raw_part_storage_board circuit_board)
    (capacity raw_part_storage_top case_top)
    (capacity final_product_storage raspberry_pi)

    (capacity temporary_raw_part_storage_bottom case_bottom)
    (capacity temporary_raw_part_storage_fan fan)
    (capacity temporary_raw_part_storage_board circuit_board)
    (capacity temporary_raw_part_storage_top case_top)
    (capacity temporary_final_product_storage raspberry_pi)
    (capacity assembly_stage case_bottom)
    (capacity assembly_stage fan)
    (capacity assembly_stage circuit_board)
    (capacity assembly_stage case_top)
    (capacity assembly_stage bottom_with_board)
    (capacity assembly_stage top_with_fan)
    (capacity assembly_stage raspberry_pi)

    (stock raw_part_storage_bottom case_bottom)
    (stock raw_part_storage_fan fan)
    (stock raw_part_storage_board circuit_board)
    (stock raw_part_storage_top case_top)
    
    (stock amr_storage case_top)
    (stock amr_storage case_bottom)
)

(:goal (and
    (stock temporary_raw_part_storage_top case_top)
    (stock temporary_raw_part_storage_bottom case_bottom)
    ;(at case_top station_assembly amr_storage)
    ;(stock final_product_storage raspberry_pi)
    ;(forall (?l1 - location) (imply (accessibleBy raw_part_provision ?l1) (not (freeAt ?l1))))
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
