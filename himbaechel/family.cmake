set(HIMBAECHEL_UARCHES "example;gowin;xilinx;ng-ultra")

set(HIMBAECHEL_UARCH "${HIMBAECHEL_UARCHES}" CACHE STRING "Microarchitectures for nextpnr-himbaechel build")
set_property(CACHE HIMBAECHEL_UARCH PROPERTY STRINGS ${HIMBAECHEL_UARCHES})

foreach (item ${HIMBAECHEL_UARCH})
    if (NOT item IN_LIST HIMBAECHEL_UARCHES)
        message(FATAL_ERROR "Microarchitecture '${item}' not in list of supported architectures")
    endif()
endforeach()

foreach (uarch ${HIMBAECHEL_UARCH})
	add_subdirectory(${family}/uarch/${uarch})
    aux_source_directory(${family}/uarch/${uarch} HM_UARCH_FILES)
    foreach (target ${family_targets})
        target_sources(${target} PRIVATE ${HM_UARCH_FILES})
    endforeach()
    if (BUILD_TESTS)
        foreach (target ${family_test_targets})
            aux_source_directory(${family}/uarch/${uarch}/tests/ HM_UARCH_TEST_FILES)
            target_sources(${target} PRIVATE ${HM_UARCH_TEST_FILES})
        endforeach()
    endif()
endforeach()
