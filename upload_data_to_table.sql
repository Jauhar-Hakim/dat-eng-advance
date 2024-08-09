USE Data_Tabungan;

LOAD DATA INFILE './data/customers_Sheet1.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE './data/detail_status_rekening_Sheet1.csv'
INTO TABLE detail_status_rekening
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE './data/lokasi_unit_Sheet1.csv'
INTO TABLE lokasi_unit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE './data/master_data_pinjaman_Sheet1.csv'
INTO TABLE Master_Data_Pinjaman
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE './data/master_data_tabungan_Sheet1.csv'
INTO TABLE Master_Data_Tabungan
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE './data/saldo_sisa_tabungan_Sheet1.csv'
INTO TABLE saldo_sisa_tabungan
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE './data/transaksi_simpanan_Sheet1.csv'
INTO TABLE transaksi_simpanan
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;