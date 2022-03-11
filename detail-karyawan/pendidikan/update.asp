<!-- #include file='construct.asp' -->
<% 
dim nama, nip, tahun

nip = Request.Form("nip")
nama = Request.Form("nama")
tahun = Request.Form("tahun")

tambah.commandText = "SELECT * FROM HRD_T_Didik1 WHERE Ddk1_Nip = '"& nip &"' and Ddk1_Nama = '"& nama &"' and Ddk1_Tahun1 = '"& tahun &"'"
set tambah = tambah.execute

dim data(10)

data(0) = tambah("Ddk1_NIP")
data(1) = tambah("Ddk1_JDdkID")
data(2) = tambah("Ddk1_Nama")
data(3) = tambah("Ddk1_JrsID")
data(4) = tambah("Ddk1_Kota")
data(5) = tambah("Ddk1_Bulan1")
data(6) = tambah("Ddk1_Tahun1")
data(7) = tambah("Ddk1_Bulan2")
data(8) = tambah("Ddk1_Tahun2")
data(9) = tambah("Ddk1_TamatYN")

for each x in data 
     Response.Write (x) &","
Next

 %>