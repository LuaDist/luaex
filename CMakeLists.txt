# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luaex C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# LuaEx modules
if ( WIN32 AND NOT CYGWIN )
  include_directories ( w32api )
  set ( SRC w32api/ex.c w32api/spawn.c w32api/pusherror.c w32api/dirent.c ex.def )
  add_definitions ( -DWIN32_LEAN_AND_MEAN -DNOGDI )
else ( )
  # posix_spawn_* not implemented in Cygwin 1.7: http://cygwin.com/cygwin-api/std-notimpl.html
  include ( CheckSymbolExists )
  check_symbol_exists ( posix_spawn spawn.h HAVE_POSIX_SPAWN )
  if ( NOT HAVE_POSIX_SPAWN )
    message ( ">>>>>>" )
    add_definitions ( -DMISSING_POSIX_SPAWN )
    set ( EXTRA_SRC posix/posix_spawn.c )
  endif ( )

  if ( APPLE )
    add_definitions ( -DAPPLE )
  endif ( )
  add_definitions ( -D_XOPEN_SOURCE=600 )
  set ( SRC posix/ex.c posix/spawn.c ${EXTRA_SRC} )
endif ( )

install_lua_module ( ex ${SRC} )
install_data ( COPYRIGHT Changelog JUST TODO README )
add_lua_test ( test.lua )
