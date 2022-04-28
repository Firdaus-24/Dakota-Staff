<%
    set getData_cmd = Server.CreateObject("ADODB.Command")
    getData_cmd.activeConnection = MM_Cargo_String

    sub getAgen(e,s)
        getData_cmd.commandText = "SELECT Agen_Nama, Agen_ID FROM GLB_M_Agen WHERE Agen_ID = '"&e&"'"
        set agen = getData_cmd.execute

        nama = ""
        id = ""
        if not agen.eof then
            nama = agen("Agen_Nama")
            id = agen("Agen_ID")
        end if

        if s = "nama" then
            Response.Write nama
        else
            Response.Write id
        end if
    end sub

    sub getJabatan(jab,s)
        getData_cmd.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan WHERE Jab_COde = '"& jab &"'"
        set jabcode = getData_cmd.execute

        nama = ""
        id = ""
        if not jabcode.eof then
            nama = jabcode("jab_nama")
            id = jabcode("Jab_code")
        end if

        if s = "nama" then
            Response.Write nama
        else
            Response.Write id
        end if
    end sub

    function getDivisi(div,s)
        getData_cmd.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Divisi WHERE Div_Code = "& div &""
        ' Response.Write getData_cmd.commandText & "<br>"
        set divisi = getData_cmd.execute

        if not divisi.eof then
            nama = divisi("Div_nama")
            id = divisi("Div_Code")
        else
            nama = ""
            id = ""
        end if

        if s = "nama" then
            Response.Write nama
        else
            Response.Write id
        end if
    end function

    sub getJenjang(jj,s)
        getData_cmd.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE JJ_ID = "& jj &""
        ' Response.Write getData_cmd.commandText & "<br>"
        set jenjang = getData_cmd.execute

        nama = ""
        id = ""
        if not jenjang.eof then
            nama = jenjang("JJ_nama")
            id = jenjang("JJ_ID")
        end if

        if s = "nama" then
            Response.Write nama
        else
            Response.Write id
        end if
    end sub
%>