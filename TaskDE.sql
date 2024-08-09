USE Data_Tabungan;

--Task 1
SELECT nama_customer, no_rekening FROM Customers;

--Task 2
SELECT cst.nama_customer, mdt.no_rekening 
FROM Master_Data_Tabungan mdt
LEFT JOIN Customers cst
ON mdt.customer_id = cst.customer_id;

--Task 3
