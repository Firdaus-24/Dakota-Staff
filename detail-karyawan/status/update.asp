<!-- #include file='../../connection.asp' -->
<% 
dim update 
dim id, tgl

id = Request.Form("id")
tgl = Request.Form("tgl")
' Response.Write id

set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_string

update.commandText = "SELECT * FROM HRD_T_StatusKaryawan WHERE SK_ID = '"& id &"' and SK_tglIn = '"& tgl &"'"
set update = update.execute


dim data(3)

data(0)= update("SK_ID")
data(1)= update("SK_tglIn")
data(2)= update("SK_TglOut")
data(3)= update("SK_Status")

for each x in data
    Response.Write (x) &","
Next
 %>