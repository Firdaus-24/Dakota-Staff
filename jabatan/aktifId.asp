<!--#include file="includes/query.asp"-->
<% 

dim id, p

code = trim(Request.form("code"))
aktif = trim(Request.form("aktif"))

if aktif = "N" then
    jabatan_cmd.commandText = "UPDATE HRD_M_Jabatan SET Jab_AktifYN = 'Y' WHERE Jab_Code = '" & code & "' "
    ' Response.Write jabatan_cmd.commandTExt & "<br>"
    set jabatan = jabatan_cmd.execute
else
    jabatan_cmd.commandText = "UPDATE HRD_M_Jabatan SET Jab_AktifYN = 'N' WHERE Jab_Code = '" & code & "' "
    ' Response.Write jabatan_cmd.commandTExt & "<br>"
    set jabatan = jabatan_cmd.execute
end if

 %> 