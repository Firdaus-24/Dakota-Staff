<!-- #include file='../../connection.asp' -->
<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../../login.asp")
end if
dim id, p
dim Aktif

id = Request.QueryString("id")
p = Request.QueryString("p")

set aktif = Server.CreateObject("ADODB.Command")
aktif.activeConnection = mm_cargo_String

if p = "Y" then
    aktif.commandText = "UPDATE HRD_T_PK SET TPK_AktifYN = 'N' WHERE TPK_ID = '"& id &"'"
    ' Response.Write Aktif.commandText
    aktif.execute
else
    aktif.commandText = "UPDATE HRD_T_PK SET TPK_AktifYN = 'Y' WHERE TPK_ID = '"& id &"'"
    ' Response.Write Aktif.commandText
    aktif.execute
end if

Response.Redirect("pinjamanKaryawan.asp")
 %>