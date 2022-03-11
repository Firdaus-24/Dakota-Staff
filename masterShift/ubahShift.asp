<!--#include file="../connection.asp"-->
<% 
if session("username") = "" then
    Response.Redirect("../login.asp")
end if
dim id, status

id = request.queryString("id")
status = request.queryString("status")

set ubahShift = server.createObject("ADODB.Command")
ubahShift.activeConnection = MM_Cargo_String

if status = "Y" then
    ubahShift.commandText = "UPDATE HRD_M_Shift SET Sh_AktifYN = 'N' WHERE Sh_ID = '"& id &"'"
    ubahShift.execute
else
    ubahShift.commandText = "UPDATE HRD_M_Shift SET Sh_AktifYN = 'Y' WHERE Sh_ID = '"& id &"'"
    ubahShift.execute
end if

Response.redirect("index.asp?id=" & trim(id))

 %> 