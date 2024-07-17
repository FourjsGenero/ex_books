# Book database sample

## Description

This demo shows how easy it is to program with Genero.

## Prerequisites

* Latest Genero version
* Database server: PostgreSQL 14+

## Quick start

* Create PostgreSQL database with library.sql
* Edit fglprofile to connect to the library database
* Set FGLPROFILE to ./fglprofile
* Set LD_LIBRARY_PATH (or PATH on Windows) to find libpq .so/.DLL
* export LC_ALL="en_US.utf8"; unset LANG
* fglcomp main.4gl
* fglform form.per
* fglrun main.42m

