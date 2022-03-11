<!-- #include file='../../connection.asp' -->
<% 

dim update 
dim id

id = Request.Form("id")

set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_string

update.commandText = "SELECT * FROM HRD_T_SPK WHERE SPK_ID = '"& id &"'"
set update = update.execute

dim data(14)

data(0)= update("SPK_ID")
data(1)= update("SPK_Nip")
data(2)= update("SPK_No")
data(3)= update("SPK_Tanggal")
data(4)= update("SPK_Perihal")
data(5)= update("SPK_AktifYN")

for each x in data
    Response.Write (x) &","
Next

 %>