// Memuat data planet
LOAD CSV WITH HEADERS FROM 'file:///Planet_Data.csv' AS row
MERGE (p:Planet {id: row.id_planet})
SET p.nama = row.nama_planet,
    p.tipe = row.tipe,
    p.urutan_dari_matahari = toInteger(row.urutan_dari_matahari),
    p.diameter_km = toInteger(row.diameter_km),
    p.komposisi_udara = row.komposisi_udara,
    p.jumlah_satelit = toInteger(row.jumlah_satelit);

// Memuat data satelit
LOAD CSV WITH HEADERS FROM 'file:///Satelit_Data.csv' AS row
CREATE (s:Satelit {id: row.id_planet})
SET s.nama = row.nama_satelit,
    s.jenis = row.jenis_satelit,
    s.jarak_ke_planet = row.jarak_satelit_ke_planet;

// Membuat relasi berdasarkan id_planet dari kedua dataset
MATCH (p:Planet), (s:Satelit)
WHERE p.id = s.id
CREATE (p)-[:MEMILIKI_SATELIT]->(s);
