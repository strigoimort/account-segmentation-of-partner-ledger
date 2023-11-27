-- OBJECTIVE
-- Please create a partner ledger that have due date in 2022 (receivable and payable created in 1 table with column customer/vendor name, due date, balance, payment status) by analyzing the data that has been provided. Make it using SQL queries, do analysis, and provide new conclusions or insight

-- QUERY
WITH tabel AS(
  SELECT
  CASE
    WHEN partner LIKE '%Beda Corporate%' THEN 'Beda Corporate'
    WHEN partner LIKE '%TOKOPEDIA%' THEN 'Tokopedia'
    WHEN partner LIKE '%BLIBLI%' THEN 'Blibli'
    WHEN partner LIKE '%ABCD%' THEN 'Usaha ABCD'
    WHEN partner LIKE '%Cab. Kota%' THEN 'Cabang Kota'
    WHEN partner = 'CORPORATE2' THEN 'Corporate'
    WHEN partner = 'CORPORATE' THEN 'Corporate'
    WHEN partner = 'Dwi Satriyo Wahyu utomo1' THEN 'Dwi Satriyo'
    WHEN partner = 'USAHA ABCD TELECOM' THEN 'Usaha ABCD Telecom'
    WHEN partner = 'USAHA ABCD INDONESIA' THEN 'Usaha ABCD Indonesia'
    WHEN partner = 'Digital TEST LANTAI 4' THEN 'Digital Test'
    WHEN partner = 'BLIBLI MARKET PLACE' THEN 'Blibli Marketplace'
    WHEN partner = 'NANANANA' THEN 'Nananana'
    WHEN partner = 'jsehfs' THEN 'Other'
    WHEN partner = 'PT UNILLEVER INDONESIA' THEN 'PT. Unilever Indonesia'
    WHEN partner = 'USAHA ANEKA TAMBANG' THEN 'Usaha Aneka Tambang'
    ELSE partner
  END AS partner,
  SUM(balance) AS balance,
  due_date,
  CASE
    WHEN (balance < 0 and payment_state = 'UNPAID') THEN 'PAYABLE'
    WHEN (balance < 0 and payment_state = 'PAID') THEN 'PAID'
    WHEN (balance > 0 and payment_state = 'UNPAID') THEN 'RECEIVABLE'
    WHEN (balance > 0 and payment_state = 'PAID') THEN 'RECEIVED'
  END AS status
  FROM `bitlabs-dab.I_CID_01.journal_items`
  --WHERE due_date BETWEEN '2022-01-01' AND '2022-12-31' 
  GROUP BY 1,3,4
)
SELECT
partner,
CASE
  WHEN partner = 'Customer Top Up' THEN 'Customer Top UP'
  WHEN partner = 'Usaha ABCD' THEN 'Usaha ABCD'
  WHEN partner = 'DigitalMarket Big' THEN 'Digital Marketplace'
  WHEN partner = 'Tokopedia' THEN 'Digital Marketplace'
  WHEN partner = 'Goto Tbk' THEN 'Digital Marketplace'
  WHEN partner = 'Blibli' THEN 'Digital Marketplace'
	ELSE 'Other'
END AS segment_partner,
ROUND(balance,2) AS balance,
ROUND(ABS(balance),2) AS abs_balance,
due_date,
status
FROM tabel
WHERE status = 'PAYABLE' OR status = 'RECEIVABLE'
ORDER BY balance

-- ANALISIS
-- Dalam query yang dilakukan, didapatkan hasil bahwa terdapat payable dan receivable balance. Payable balance dapat diartikan sebagai dana yang seharusnya dibayarkan oleh perusahaan sedangkan receivable balance dapat diartikan sebagai dana yang seharusnya diterima oleh perusahaan. Dari hasil tersebut, diketahui bahwa pada rentang 2022 hanya terdapat balance dengan status receivable. Dari beberapa partner yang melakukan transaksi, diketahui bahwa Customer Top Up memiliki receivable balance tertinggi. Hal tersebut menunjukkan bahwa diperlukan pengawasan yang lebih baik pada parner Customer Top Up. 
