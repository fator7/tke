case "{1}":
   when "dev" then connect value("-db dbs -ld dev -H srvhpi -S dbsd -U costa -P gis").
   when "dbsu" then connect value("-db dbsu -ld gus -H srvhpu -S 7010").
   when "f7" then connect value("-db c:\Users\giuliano.borowski\wrk\db\dbsf7.db -ld f7 -1").
   when "prod" then connect value("-db dbs -ld prod -H srvhpi -S dbs -U costa -P gis").
   when "sdt" then connect value("-db sdt -H srvhpi -S sdt").
end case.
