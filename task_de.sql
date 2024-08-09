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

--Task 15
SELECT mdt.no_rekening, dsr.deskripsi_status,Year(cst.Tanggal_lahir)
FROM Master_Data_Tabungan mdt
LEFT JOIN detail_status_rekening dsr
ON mdt.status_rekening=dsr.id_status
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE Year(cst.Tanggal_lahir)<1995 AND
cst.customer_id IN (SELECT DISTINCT mdp.customer_id FROM Master_Data_Pinjaman mdp);

--Task 16
SELECT cst.customer_id, cst.nama_customer, SUM(ts.jumlah_transaksi) Total_Transaksi_Debit, COUNT(sst.id_trasaksi) Frekuensi_Total_Transaksi_Debit
FROM saldo_sisa_tabungan sst
LEFT JOIN transaksi_simpanan ts
ON sst.id_trasaksi=ts.id_transaksi
LEFT JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE sst.tipe_transaksi="Debit"
GROUP BY cst.customer_id,cst.nama_customer;

--Task 17
SELECT cst.nama_customer, cst.Tanggal_lahir
FROM saldo_sisa_tabungan sst
LEFT JOIN transaksi_simpanan ts
ON sst.id_trasaksi=ts.id_transaksi
LEFT JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
WHERE DATE_FORMAT(ts.waktu_transaksi, '%d/%m/%Y')='09/05/2021'
AND sst.sisa_saldo<"1000000";

--Task 18
SELECT  cst.nama_customer,
        mdt.no_rekening,
        COALESCE(mdp.tanggal_buka_pinjaman, "Tidak_Punya_Rekening_Pinjaman") AS tanggal_buka_pinjaman
FROM    Customers cst
LEFT JOIN Master_Data_Pinjaman mdp
ON cst.customer_id=mdp.customer_id
INNER JOIN Master_Data_Tabungan mdt
ON cst.customer_id=mdt.customer_id;

--Task 19
SELECT ts.id_transaksi, ts.jumlah_transaksi, cst.nama_customer, cst.Tanggal_lahir
FROM transaksi_simpanan ts
INNER JOIN saldo_sisa_tabungan sst
ON ts.id_transaksi=sst.id_trasaksi
INNER JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
INNER JOIN Customers cst
ON mdt.customer_id=cst.customer_id
ORDER BY cst.Tanggal_lahir DESC;

--Task 20
SELECT cst.nama_customer, MIN(sst.sisa_saldo) AS Saldo_Akhir_Terkecil
FROM saldo_sisa_tabungan sst
LEFT JOIN Master_Data_Tabungan mdt
ON sst.no_rekening=mdt.no_rekening
LEFT JOIN Customers cst
ON mdt.customer_id=cst.customer_id
GROUP BY cst.nama_customer;