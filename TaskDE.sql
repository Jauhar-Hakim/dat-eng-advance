USE Data_Tabungan;

--Task 1
SELECT nama_customer, no_rekening FROM Customers;

--Task 2
SELECT cst.nama_customer, mdt.no_rekening 
FROM Master_Data_Tabungan mdt
LEFT JOIN Customers cst
ON mdt.customer_id = cst.customer_id;

--Task 3
SELECT sst.no_rekening, sst.id_trasaksi, ts.waktu_transaksi
FROM saldo_sisa_tabungan sst
LEFT JOIN transaksi_simpanan ts
ON sst.id_trasaksi=ts.id_transaksi
WHERE DATE_FORMAT(ts.waktu_transaksi, '%d/%m/%Y')='10/05/2021';

--Task 4
SELECT mdt.no_rekening, cst.Tanggal_lahir, cst.jenis_kelamin
FROM Master_Data_Tabungan mdt
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE cst.jenis_kelamin="P";

--Task 5
SELECT id_transaksi, jumlah_transaksi 
FROM transaksi_simpanan
ORDER BY jumlah_transaksi DESC;

SELECT id_transaksi, jumlah_transaksi 
FROM transaksi_simpanan
ORDER BY jumlah_transaksi ASC;

--Task 6
SELECT mdt.* FROM Master_Data_Tabungan mdt
WHERE mdt.customer_id NOT IN
(SELECT DISTINCT mdp.customer_id FROM Master_Data_Pinjaman mdp);

--Task 7
SELECT cst.nama_customer, mdt.customer_id, lu.kantor_wilayah
FROM Master_Data_Tabungan mdt
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
LEFT JOIN lokasi_unit lu
ON mdt.lokasi_pembuatan_rekening=lu.id_unit
WHERE lu.kantor_wilayah="Jakarta";

--Task 8
SELECT sst.id_trasaksi, mdt.customer_id, cst.status_nikah
FROM saldo_sisa_tabungan sst
LEFT JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE cst.status_nikah="K";

--Task 9
SELECT sst.id_trasaksi, mdt.customer_id, cst.Provinsi_alamat
FROM saldo_sisa_tabungan sst
LEFT JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE cst.Provinsi_alamat LIKE "Jawa%";

--Task 10
SELECT DISTINCT cst.nama_customer, DATE_FORMAT(ts.waktu_transaksi, '%d/%m/%Y') waktu_transaksi
FROM saldo_sisa_tabungan sst
INNER JOIN transaksi_simpanan ts
ON sst.id_trasaksi=ts.id_transaksi
LEFT JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE DATE_FORMAT(ts.waktu_transaksi, '%d/%m/%Y')='09/05/2021';

--Task 11
SELECT cst.nama_customer, mdp.no_rekening_pinjaman, lu.kantor_wilayah
FROM Master_Data_Pinjaman mdp
INNER JOIN Customers cst
ON mdp.customer_id=cst.customer_id
LEFT JOIN Master_Data_Tabungan mdt
ON cst.customer_id=mdt.customer_id
LEFT JOIN lokasi_unit lu
ON mdt.lokasi_pembuatan_rekening=lu.id_unit
WHERE lu.kantor_wilayah="Jakarta";


--Task 12
SELECT mdp.customer_id, mdp.tanggal_buka_pinjaman
FROM Master_Data_Pinjaman mdp
INNER JOIN Customers cst
ON mdp.customer_id = cst.customer_id
LEFT JOIN Master_Data_Tabungan mdt
ON cst.customer_id=mdt.customer_id
INNER JOIN saldo_sisa_tabungan sst
ON mdt.no_rekening=sst.no_rekening
WHERE mdt.status_rekening="1" AND sst.tipe_transaksi="Debit";

--Task 13
SELECT *
FROM (
    SELECT 
        id_transaksi, 
        waktu_transaksi, 
        jumlah_transaksi,
        ROW_NUMBER() OVER(PARTITION BY CAST(waktu_transaksi AS DATE) ORDER BY waktu_transaksi) AS rn
    FROM transaksi_simpanan
) AS subquery
WHERE rn = 2;

--Task 14
SELECT MAX(cst.gaji)
FROM Customers cst
INNER JOIN Master_Data_Tabungan mdt
ON cst.customer_id=mdt.customer_id
INNER JOIN saldo_sisa_tabungan sst
ON mdt.no_rekening=sst.no_rekening
INNER JOIN transaksi_simpanan ts
ON sst.id_trasaksi=ts.id_transaksi
WHERE DATE_FORMAT(ts.waktu_transaksi, '%d/%m/%Y')='10/05/2021';
