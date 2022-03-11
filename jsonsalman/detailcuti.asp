<!-- #include file='../connection.asp' -->
<% 
nip = trim(Request.QueryString("nip"))
tahun = trim(Request.QueryString("tahun"))

set cuti = Server.CreateObject("ADODB.Command")
cuti.ActiveConnection = MM_Cargo_string

cuti.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_Nip = '"& nip &"' and year(ICS_StartDate) = '"& tahun &"' and year(ICS_EndDate) = '"& tahun &"' AND ICS_AktifYN = 'Y' ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"
set cuti = cuti.execute

status = ""
    response.ContentType = "application/json;charset=utf-8"    
    Response.Write "["
        do until cuti.eof
        if cuti("ICS_status") = "A" then
            status = "Alfa"
        elseIf cuti("ICS_status") = "B" then
            status = "Cuti Bersama"
        elseIf cuti("ICS_status") = "C" then
            status = "Cuti"
        elseIf cuti("ICS_status") = "G" then
            status = "Dispensasi"
        elseIf cuti("ICS_status") = "I" then
            status = "Izin"
        elseIf cuti("ICS_status") = "K" then
            status = "Klaim Obat"
        elseIf cuti("ICS_status") = "S" then
            status = "Sakit"
        else
            status = ""
        end if
            Response.Write "{" 

                Response.Write """ID""" & ":" & """" & cuti("ICS_ID") & """" & ","
                Response.Write """MULAI""" & ":" & """" & cuti("ICS_StartDate") & """" & ","
                Response.Write """AKHIR""" & ":" & """" & cuti("ICS_EndDate") & """" & ","
                response.write """STATUS""" & ":" & """" & status & """" & ","
                response.write """KETERANGAN""" & ":" & """" & cuti("ICS_Keterangan") & """" & "," 
                Response.Write """POTONGGAJI""" & ":" & """" & cuti("ICS_PotongGaji") & """" & ","
                Response.Write """POTONGTITID""" & ":" & """" & cuti("ICS_PotongCuti")  & """" & ","
                Response.Write """BIAYA""" & ":" & """" & cuti("ICS_Obat") & """" & ","
                Response.Write """AKTIF""" & ":" & """" & cuti("ICS_AktifYN") & """" & ","
                Response.Write """FORM""" & ":" & """" & cuti("ICS_FormYn") & """" & ","
                Response.Write """SURAT""" & ":" & """" & cuti("ICS_SuratDokterYN") & """" 

            Response.Write "}"

        cuti.movenext
            if cuti.eof = false then
                response.write ","
            end if 
        loop
    Response.Write "]"

 %>
