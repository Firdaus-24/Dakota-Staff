<!-- #include file='../../connection.asp' -->
<% 
dim pekerjaan, id, nama

id = Request.Form("id")
nama = Request.Form("nama")

set pekerjaan = Server.CreateObject("ADODB.Command")
pekerjaan.activeConnection = MM_Cargo_String

pekerjaan.commandText = "SELECT * FROM HRD_T_HistKerja WHERE HK_Nip = '"& id &"' and HK_namaPT = '"& nama &"'"
set pekerjaan = pekerjaan.execute

dim data(9)

data(0)= pekerjaan("HK_nip")
data(1)= pekerjaan("HK_namaPT")
data(2)= pekerjaan("HK_UshID")
data(3)= pekerjaan("HK_JbtID") 
data(4)= pekerjaan("HK_Bulan1") 
data(5)= pekerjaan("HK_Tahun1") 
data(6)= pekerjaan("HK_Bulan2")
data(7)= pekerjaan("HK_Tahun2")
data(8)= pekerjaan("HK_Referensi")
data(9)= pekerjaan("HK_AlasanKeluar")


for each x in data
    Response.Write (x) &","
Next

 %>