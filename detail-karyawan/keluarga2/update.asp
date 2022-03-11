<!-- #include file='../../connection.asp' -->
<% 
dim keluarga, id, nama

id = Request.Form("id")
nama = Request.Form("nama")

set keluarga = Server.CreateObject("ADODB.Command")
keluarga.activeConnection = MM_Cargo_String

keluarga.commandText = "SELECT * FROM HRD_T_Keluarga2 WHERE Kel2_Nip = '"& id &"' and Kel2_nama = '"& nama &"'"
set keluarga = keluarga.execute

dim data(9)

data(0)= keluarga("Kel2_nip")
data(1)= keluarga("Kel2_nama")
data(2)= keluarga("Kel2_Hubungan")
data(3)= keluarga("Kel2_TempatLahir") 
data(4)= keluarga("Kel2_tglLahir") 
data(5)= keluarga("Kel2_Sex") 
data(6)= keluarga("Kel2_JDdkID")
data(7)= keluarga("Kel2_UshID")
data(8)= keluarga("Kel2_JbtID")
data(9)= keluarga("Kel2_SttKelID")


for each x in data
    Response.Write (x) &","
Next

 %>