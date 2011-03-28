# Copyright (C) 2007-2009 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(luaex C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(dist.cmake)

# LuaEx modules
IF(WIN32 AND NOT CYGWIN)
	INCLUDE_DIRECTORIES(w32api)

	SET (WIN_SRC w32api/ex.c w32api/spawn.c w32api/pusherror.c w32api/dirent.c)
	ADD_DEFINITIONS(-DWIN32_LEAN_AND_MEAN -DNOGDI)
    IF (MSVC)
        ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS)
    ENDIF (MSVC)

	# Build
	ADD_LUA_MODULE(ex ${WIN_SRC} ex.def)
ELSE()
	INCLUDE(CheckFunctionExists)
	INCLUDE (CheckSymbolExists)

#~ 	CHECK_FUNCTION_EXISTS(posix_spawn HAVE_POSIX_SPAWN)
#~ 	IF(NOT HAVE_POSIX_SPAWN)
#~ 		MESSAGE(">>>>>>")
		ADD_DEFINITIONS(-DMISSING_POSIX_SPAWN)
		SET(EXTRA_SRC posix/posix_spawn.c)
#~ 	ELSE()
#~ 		MESSAGE(${HAVE_POSIX_SPAWN})
#~ 	ENDIF()

	IF (APPLE)
		ADD_DEFINITIONS(-DAPPLE)
	ENDIF()

	INCLUDE_DIRECTORIES(posix)
	ADD_DEFINITIONS(-D_XOPEN_SOURCE=600)

	SET(POSIX_SRC posix/ex.c posix/spawn.c ${EXTRA_SRC})

	# Build
	ADD_LUA_MODULE(ex ${POSIX_SRC})
ENDIF()

# Install all files and documentation
INSTALL(TARGETS ex DESTINATION ${INSTALL_CMOD})
INSTALL(FILES COPYRIGHT Changelog JUST TODO README DESTINATION ${INSTALL_DATA})

