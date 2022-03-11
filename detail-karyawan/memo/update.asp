<!-- #include file='../../connection.asp' -->

<% 
dim update, id
dim data(9)

id = Request.Form("id")

set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_String

update.commandText = "SELECT * FROM HRD_T_Memo WHERE Memo_Id = '"& id &"'"
' Response.Write update.commandText
set update = update.execute

data(0)= update("Memo_ID")
data(1)= update("Memo_status")
data(2)= update("Memo_Tanggal")
data(3)= update("Memo_Subject") 
data(4)= update("Memo_Isi") 
data(5)= update("Memo_AktifYN") 
data(6)= update("Memo_nip")


for each x in data
    Response.Write (x) &","
Next

 %>
