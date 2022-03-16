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
        set jabatan = getData_cmd.execute

        nama = ""
        id = ""
        if not jabatan.eof then
            nama = jabatan("jab_nama")
            id = jabatan("Jab_code")
        end if

        if s = "nama" then
            Response.Write nama
        else
            Response.Write id
        end if
    end sub

    function getDivisi(div,s)
        getData_cmd.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Divisi WHERE Div_Code = "& div &""
        Response.Write getData_cmd.commandText & "<br>"
        set divisi = getData_cmd.execute

        nama = ""
        id = ""
        if not divisi.eof then
            nama = divisi("Div_nama")
            id = divisi("Div_Code")
        end if

        if s = "nama" then
            Response.Write nama
        else
            Response.Write id
        end if
    end function

    sub getLastMutasi (nip,s)
        getData_cmd.commandText = "SELECT Mut_AsalDDBID, Mut_AsalJabCode, Mut_asalAgenID FROM HRD_T_Mutasi WHERE Mut_Nip = '"& nip &"' ORDER BY MUt_Tanggal DESC"

        set lastMutasi = getData_cmd.execute

        if not lastMutasi.eof then
            if s = "jab" then
                Response.Write lastMutasi("Mut_AsalJabCode") 
            elseIf s = "div" then
                Response.Write lastMutasi("Mut_AsalDDBID") 
            else
                Response.Write lasMutasi("Mut_AsalAGenID") 
            end if
        else
            Response.Write "Belum Ada Data Yang Terdaftar"
        end if
    end sub
%>