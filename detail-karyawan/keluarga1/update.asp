<!-- #include file='../../connection.asp' -->
<% 
dim keluarga, id, nama

id = Request.Form("id")
nama = Request.Form("nama")

set keluarga = Server.CreateObject("ADODB.Command")
keluarga.activeConnection = MM_Cargo_String

keluarga.commandText = "SELECT * FROM HRD_T_Keluarga1 WHERE Kel1_Nip = '"& id &"' and Kel1_nama = '"& nama &"'"
set keluarga = keluarga.execute

dim data(9)

data(0)= keluarga("Kel1_nip")
data(1)= keluarga("Kel1_nama")
data(2)= keluarga("Kel1_Hubungan")
data(3)= keluarga("Kel1_TempatLahir") 
data(4)= keluarga("Kel1_tglLahir") 
data(5)= keluarga("Kel1_Sex") 
data(6)= keluarga("Kel1_JDdkID")
data(7)= keluarga("Kel1_UshID")
data(8)= keluarga("Kel1_JbtID")
data(9)= keluarga("Kel1_SttKelID")


for each x in data
    Response.Write (x) &","
Next

 %>