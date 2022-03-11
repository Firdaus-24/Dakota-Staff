<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<% 
dim id, nip
dim kesehatan

nip = Request.form("nip")
id = Request.form("id")

set kesehatan = Server.CreateObject("ADODB.Command")
kesehatan.ActiveConnection = MM_cargo_STRING

kesehatan.commandText = "SELECT * FROM HRD_T_Kesehatan WHERE Kes_NIP = '"& nip &"' and Kes_ID = '"& id &"'"
set kesehatan = kesehatan.execute

dim data(6)

data(0) = kesehatan("Kes_ID")
data(1) = kesehatan("Kes_Nip")
data(2) = kesehatan("Kes_PenyID")
data(3) = kesehatan("Kes_Bulan")
data(4) = kesehatan("Kes_Tahun")
data(5) = kesehatan("Kes_Lama")
data(6) = kesehatan("Kes_Satuan")

for each x in data 
    Response.Write (x) &","
Next
 %>