<!-- #include file="connection.asp"-->
<% 
    if session("HA2AA") = false then
        Response.Redirect("shift_view.asp")
    end if
    
    dim histori_cmd, histori       
    dim nipbaru
    dim jnip, jtgl
    dim tampil
    dim tampilData

    dim shiftName, str, datatgl, karyawan, nip 
    dim shift, arry

    shiftName = trim(request.form("shiftName"))
    str = trim(request.form("myrosterdate"))
    nip = trim(request.form("karyawan"))

    'set add data
    set shift = server.createobject("ADODB.Command")
    shift.activeConnection = MM_Cargo_string

    set tampilData = server.createobject("ADODB.Command")
    tampilData.activeConnection = MM_Cargo_string
    
    'cek tgl skarang dan notiv
    tglNow = date
    notiv = ""

    'Split dara form
    datatgl = Split(str,",")
    nip = Split(nip,",")
    for i = 0 to ubound(datatgl)
        jtgl = Cdate(trim(datatgl(i)))
        
        if i = 0 then
            filterTglStart = " SHF_Tanggal = '"& jtgl &"'"
        else
            filterTgl = filterTgl & " or Shf_Tanggal = '"& jtgl &"'"
        end if

        if session("Server-id") <> 1 then
            if tglNow > jtgl then
                notiv = "Pastikan Tanggal Yang di setting tidak mundur"
                Exit For
            end if
        end if

        for x = 0 to ubound(nip)
            jnip = trim(nip(x))
            
            if x = 0 then
                filterNipStart = " SHF_Nip = '"& jnip &"'"
            else
                filterNip = filterNip & " or SHF_Nip = '"& jnip &"'"
            end if

            tampilData.commandText = "SELECT Shf_NIP, SH_ID, Shf_Tanggal FROM HRD_T_Shift WHERE Shf_Nip = '"& jnip &"' and Shf_Tanggal = '"& jtgl &"'"
            set tampil = tampilData.execute

            if tampil.eof = true then 

                shift.commandText = "exec sp_ADDHRD_T_Shift'"& shiftName &"','"& jnip &"','"& jtgl &"','"& session("username") &"'"

                shift.execute
            else 
                Response.redirect("updateShiftKerja.asp?update=id")
            end if
        next
    next

    if notiv = "" then
        set histori_cmd = server.createobject("ADODB.Command")
        histori_cmd.activeConnection = MM_Cargo_string

        histori_cmd.commandText = "SELECT dbo.HRD_T_Shift.Shf_GSCode, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.Sh_ID, dbo.HRD_M_Shift.Sh_Name, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.shf_UpdateTime, dbo.HRD_T_Shift.Shf_updateID, HRD_M_Karyawan.Kry_Nama FROM dbo.HRD_T_Shift LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Shift.Shf_Nip = HRD_M_Karyawan.Kry_Nip where HRD_M_Shift.Sh_ID <> '' and (" & filterTglStart & filterTGL & ") and (" & filterNipStart & filterNip & ") order by shf_nip, shf_tanggal ASC "

        set histori = histori_cmd.execute
    end if
%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HISTORI DATA SHIFT</title>
    <!--#include file="layout/header.asp"-->
</head>
<body>
<div class="container">
    <%if notiv <> "" then%>
        <div class="row d-flex align-content-center flex-wrap">
            <div class="col-sm-12">
                <div class='notiv-gagal' data-aos='fade-up'><span>Tanggal Tidak Valid</span><img src='logo/gagal_dakota.PNG'><a href='tambahShiftkerja.asp' class='btn btn-primary'>kembali</a></div>
            </div>
        </div>
    <%else%>
        <div class='row'>
            <div class='col-sm text-center mt-3'>
                <h3>HISTORI SHIFT KERJA </h3>
            </div>
        </div>
        <div class='row'>
            <div class='col-lg'>
                <button type="button" class="btn btn-danger mb-2" onclick="window.location.href='tambahShiftkerja.asp'">Kembali</button>
            </div>
        </div>
        <div class='row'>
            <div class='col-lg'>
                <table class="table table-striped table-hover">
                    <thead class="bg-secondary text-light">
                        <tr>
                            <td>Jam masuk</td>
                            <td>Jam keluar</td>
                            <td>Beda hari</td>
                            <td>NIP</td>
                            <td>Nama</td>
                            <td>Tanggal</td>
                            <td>Update ID</td>
                            <td>Tanggal Update</td>
                        </tr>
                    </thead>
                    </tbody>
                        <% 
                        do until histori.eof 
                            ' definisi jam masuk dan keluar 
                            jamMasuk = right("00"&histori("SH_JamIn"),2)&":"&right("00"&histori("Sh_MenitIn"),2)
                            jamKeluar = right("00"&histori("Sh_JamOut"),2)&":"&right("00"&histori("Sh_MenitOut"),2)

                            ' cek beda hari 
                            if histori("SH_iHari") = "N" then   
                                bhari = "No"
                            else
                                bhari = "Yes"
                            end if
                        %> 
                            <tr>
                                <td><%= jamMasuk %> </td>
                                <td><%= jamKeluar %> </td>
                                <td><%= bhari %> </td>
                                <td><%= histori("Shf_NIP") %> </td>
                                <td><%= histori("Kry_Nama") %> </td>
                                <td><%= histori("Shf_Tanggal") %> </td>
                                <td><%= histori("Shf_updateID") %> </td>
                                <td><%= histori("shf_UpdateTime") %> </td>
                            </tr>
                        <% histori.movenext
                        loop 
                        %> 
                    </tbody>
                </table>
            </div>
        </div>
    <%end if%>
</div>
<!--#include file="layout/footer.asp"-->
