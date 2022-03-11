<% 
if session("username") = "" then
response.Redirect("../../login.asp")
end if
 %>
<!-- #include file='../../connection.asp' -->
<% 
dim p,i,aktif

p = Request.QueryString("p")
i = Request.QueryString("i")

set aktif = Server.CreateObject("ADODB.Command")
aktif.activeConnection = mm_cargo_string

if i = "Y" then
    aktif.commandText = "UPDATE HRD_T_BK SET TPK_AktifYN = 'N' WHERE TPK_ID = '"& p &"'"
    ' Response.Write aktif.commandText
    aktif.execute
else
    aktif.commandText = "UPDATE HRD_T_BK SET TPK_AktifYN = 'Y' WHERE TPK_ID = '"& p &"'"
    ' Response.Write aktif.commandText
    aktif.execute
end if

Response.Redirect("pembayaran.asp")
 %>