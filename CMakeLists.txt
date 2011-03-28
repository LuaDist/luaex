# Copyright (C) 2007-2009 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luaex C )
cmake_minimum_required ( VERSION 2.6 )
include ( dist.cmake )

# LuaEx modules
if ( WIN32 AND NOT CYGWIN )
	include_directories ( w32api )
	set ( SRC w32api/ex.c w32api/spawn.c w32api/pusherror.c w32api/dirent.c ex.def )
	add_definitions ( -DWIN32_LEAN_AND_MEAN -DNOGDI )
else ()
#~	include ( CheckFunctionExists )
#~	include ( CheckSymbolExists )
#~ 	CHECK_FUNCTION_EXISTS(posix_spawn HAVE_POSIX_SPAWN)
#~ 	IF(NOT HAVE_POSIX_SPAWN)
#~ 		MESSAGE(">>>>>>")
	add_definitions ( -DMISSING_POSIX_SPAWN )
	set ( EXTRA_SRC posix/posix_spawn.c )
#~ 	ELSE()
#~ 		MESSAGE(${HAVE_POSIX_SPAWN})
#~ 	ENDIF()

	if ( APPLE )
		add_definitions ( -DAPPLE )
	endif ()
	include_directories ( posix )
	add_definitions ( -D_XOPEN_SOURCE=600 )

	set ( SRC posix/ex.c posix/spawn.c ${EXTRA_SRC} )
endif ()

install_lua_module ( ex ${SRC} )

install_data ( COPYRIGHT Changelog JUST TODO README )
