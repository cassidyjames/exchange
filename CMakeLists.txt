    project (com.github.brandonlujan.exchange)

    cmake_minimum_required (VERSION 2.6)

    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/src)

    set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

    set (PKGDATADIR "${DATADIR}/com.github.brandonlujan.exchange")

    set (EXEC_NAME "com.github.brandonlujan.exchange")
    set (RELEASE_NAME "Exchange")
    set (VERSION "0.1")
    set (VERSION_INFO "A currency converter")

    find_package(PkgConfig)

    pkg_check_modules(DEPS REQUIRED gtk+-3.0)

    add_definitions(${DEPS_CFLAGS})
    link_libraries(${DEPS_LIBRARIES})
    link_directories(${DEPS_LIBRARY_DIRS})

    find_package(Vala REQUIRED)
    include(ValaVersion)
    ensure_vala_version("0.16" MINIMUM)

    include(ValaPrecompile)
    vala_precompile(VALA_C ${EXEC_NAME}
        src/exchange.vala

    PACKAGES
        gtk+-3.0
        libsoup-2.4
        json-glib-1.0
    )

    add_executable(${EXEC_NAME} ${VALA_C})

    install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)


    install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/com.github.brandonlujan.exchange.desktop DESTINATION ${DATADIR}/applications/)

    install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/com.github.brandonlujan.exchange.appdata.xml DESTINATION ${DATADIR}/metainfo/)
