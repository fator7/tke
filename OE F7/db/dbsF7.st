#
#  dbsF7.st - Estrutura do banco de dados dbsF7
#

# Before-image

b ./dbsF7.b1 f 500032
b ./dbsF7.b2 

# Database Files

# Schema Area
d "Schema Area":6,64 ./dbsF7.d1 

# Table Area
d "Table Area":7,64 ./dbsF7_7.d1  f 500032
d "Table Area":7,64 ./dbsF7_7.d2


# Index Area
d "Index Area":8,64 ./dbsF7_8.d1  f 500032
d "Index Area":8,64 ./dbsF7_8.d2

