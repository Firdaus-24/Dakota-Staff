<!--#include file="includes/query.asp"-->
<% 

    code = trim(Request.form("code"))
    Response.Write code & "<br>"

    divisi_cmd.commandText = "SELECT Div_AktifYN, div_code FROM HRD_M_Divisi WHERE Div_code = '"& code &"'"
    set divisi = divisi_cmd.execute

    if not divisi.eof then
        if divisi("Div_aktifYN") = "Y" then
            divisi_cmd.commandText = "UPDATE HRD_M_Divisi SET Div_AktifYN = 'N' WHERE Div_Code = '" & divisi("Div_Code") & "' "
            divisi_cmd.execute
        else
            divisi_cmd.commandText = "UPDATE HRD_M_Divisi SET Div_AktifYN = 'Y' WHERE Div_Code = '" & divisi("Div_Code") & "' "
            divisi_cmd.execute
        end if
    end if
%> 