<!-- #include file='../../connection.asp' -->
<% 

dim update 
dim id

id = Request.Form("id")
' Response.Write id

set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_string

update.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_ID = '"& id &"'"
set update = update.execute

dim data(14)

data(0)= update("Mut_ID")
data(1)= update("Mut_Nip")
data(2)= update("Mut_Tanggal")
data(3)= update("Mut_Status")
data(4)= update("Mut_NoSurat")
data(5)= update("Mut_Memo")
data(6)= update("Mut_AsalAgenID")
data(7)= update("Mut_AsalJabCode")
data(8)= update("Mut_AsalJJID")
data(9)= update("Mut_AsalDDBID")
data(10)= update("Mut_TujAgenID")
data(11)= update("Mut_TujJabCode")
data(12)= update("Mut_TujJJID")
data(13)= update("Mut_TujDDBID")
data(14)= update("Mut_AktifYN")

for each x in data
    Response.Write (x) &","
Next

 %>