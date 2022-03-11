<!--#include file="../connection.asp"-->
<% 
code = trim(Request.form("code"))
aktif = trim(Request.Form("aktif"))

set jenjang_cmd = Server.CreateObject("ADODB.Command")
jenjang_cmd.activeConnection = MM_Cargo_string

jenjang_cmd.commandText = "SELECT JJ_ID, JJ_AktifYN FROM HRD_M_Jenjang WHERE JJ_ID = '" & code & "' "
set jenjang = jenjang_cmd.execute

if not jenjang.eof then
    if jenjang("JJ_AktifYN") = "Y" then
        jenjang_cmd.commandText = "UPDATE HRD_M_Jenjang SET JJ_AktifYN = 'N' WHERE JJ_ID = '" & code & "' "
        jenjang_cmd.execute
    else
        jenjang_cmd.commandText = "UPDATE HRD_M_Jenjang SET JJ_AktifYN = 'Y' WHERE JJ_ID = '" & code & "' "
        jenjang_cmd.execute
    end if
end if

' Response.Redirect ("index.asp")

 %> 