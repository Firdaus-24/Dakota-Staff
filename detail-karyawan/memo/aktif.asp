<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<% 
dim id, aktif, update, q

id = Request.QueryString("id")
aktif = Request.QueryString("p")
q = Request.QueryString("q")
Response.Write q
set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_String

if aktif = "Y" then
    update.commandText = "UPDATE HRD_T_Memo SET Memo_AktifYN = 'N' WHERE Memo_ID = '"& id &"'"
    ' Response.Write update.commandText
    update.execute
else
    update.commandText = "UPDATE HRD_T_Memo SET Memo_AktifYN = 'Y' WHERE Memo_ID = '"& id &"'"
    ' Response.Write update.commandText
    update.execute
end if

Response.Redirect(url&"/detail-karyawan/memo.asp?nip="& q)
 %>