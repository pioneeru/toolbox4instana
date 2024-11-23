#!/usr/bin/bash

function checkPostgres {

    case "$2" in
        fullvacuum)
            pgsql "vacuum (FULL, ANALYZE, VERBOSE);" $3
            ;;
        status)
            pg pg_isready
            ;;
        size)
            pgsql "\l+"
            ;;
        vacuum)
            pgsql "vacuum (ANALYZE, VERBOSE);" $3
            ;;
        *|help)
            echo "Usage: swat postgres [OPTION]"
            echo "postgres (short: pg) options:"
            echo "   pg help                       - show this help"
            echo "   pg fullvacuum <DB_NAME>       - locks and copies all tables of the DB_NAME to a new ones and if succeed, deletes the old tables. TAKES MORE TIME THEN VACUUM!"
            echo "   pg size                       - list databases and size"
            echo "   pg status                     - check if connections accepted"
            echo "   pg vacuum <DB_NAME>           - shrink disk space for all tables in db DB_NAME"
            exit 1
            ;;
    esac 
}

