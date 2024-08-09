CREATE DATABASE Data_Tabungan;

USE Data_Tabungan;

CREATE TABLE `Master_Data_Pinjaman` (
  `no_rekening_pinjaman` integer PRIMARY KEY,
  `tanggal_buka_pinjaman` timestamp,
  `tanggal_berakhir_pinjaman` timestamp,
  `customer_id` integer
);

CREATE TABLE `Customers` (
  `customer_id` integer PRIMARY KEY,
  `nama_customer` char(50),
  `Tanggal_lahir` timestamp,
  `Provinsi_alamat` char(30),
  `jenis_kelamin` char(1),
  `status_nikah` char(1),
  `gaji` integer
);

CREATE TABLE `detail_status_rekening` (
  `id_status` integer PRIMARY KEY,
  `deskripsi_status` char(20)
);

CREATE TABLE `lokasi_unit` (
  `id_unit` integer PRIMARY KEY,
  `nama_unit` char(20),
  `nama_cabang` char(20),
  `kantor_wilayah` char(20)
);

CREATE TABLE `Master_Data_Tabungan` (
  `no_rekening` integer PRIMARY KEY,
  `jenis_rekening` char(20),
  `tanggal_buka_rekening` timestamp,
  `status_rekening` integer,
  `customer_id` integer,
  `lokasi_pembuatan_rekening` integer
);

CREATE TABLE `saldo_sisa_tabungan` (
  `no_rekening` integer,
  `id_trasaksi` integer,
  `tipe_transaksi` char(10),
  `sisa_saldo` decimal(19,2),
  PRIMARY KEY (`no_rekening`, `id_trasaksi`)
);

CREATE TABLE `transaksi_simpanan` (
  `id_transaksi` integer PRIMARY KEY,
  `jumlah_transaksi` decimal(19,2),
  `waktu_transaksi` timestamp
);

ALTER TABLE `Customers` ADD FOREIGN KEY (`customer_id`) REFERENCES `Master_Data_Pinjaman` (`customer_id`);

ALTER TABLE `Master_Data_Tabungan` ADD FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`);

ALTER TABLE `Master_Data_Tabungan` ADD FOREIGN KEY (`status_rekening`) REFERENCES `detail_status_rekening` (`id_status`);

ALTER TABLE `Master_Data_Tabungan` ADD FOREIGN KEY (`lokasi_pembuatan_rekening`) REFERENCES `lokasi_unit` (`id_unit`);

ALTER TABLE `saldo_sisa_tabungan` ADD FOREIGN KEY (`no_rekening`) REFERENCES `Master_Data_Tabungan` (`no_rekening`);

ALTER TABLE `saldo_sisa_tabungan` ADD FOREIGN KEY (`id_trasaksi`) REFERENCES `transaksi_simpanan` (`id_transaksi`);