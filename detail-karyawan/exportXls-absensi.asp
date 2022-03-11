<!-- #include file="../connection.asp"-->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
 
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Laporan Absensi " &  Request.QueryString("nip") & " " & now() & ".xls"

'on error resume next
dim karyawan_cmd, karyawan, sqlAwal
dim awal, akhir
dim sqlFilter, urut
dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter
dim nip, cabang, tgl, tgla, tgle, ketm, ketk, shiftm, shiftk, bedai, offset

dim telat, tidakAbsen, tidakAbsenKeluar

'make paggination
nip = trim(Request.QueryString("nip"))
cabang = trim(request.querystring("cabang"))
tgl= trim(Request.QueryString("tgl"))
tgla = trim(Request.QueryString("tgla"))
tgle = trim(Request.QueryString("tgle"))

set shift_cmd = Server.CreateObject("ADODB.COmmand")
shift_cmd.ActiveConnection = MM_Cargo_string
' label nama dan nip
shift_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE Kry_Nip = '"& nip &"'"
set karyawan = shift_cmd.execute
'query shift
shift_cmd.commandText = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& nip &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"
' Response.Write shift_cmd.commandText & "<br>"
set karyawanshift = shift_cmd.execute
 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Absensi</title>
    <!--#include file="../layout/header.asp"-->
    <style>
    table{
        font-size:14px;
    }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class='col-lg-12'>
        <table>
            <tr>
                <th>
                    Nip
                </th>
                <th>
                    <%= nip %> 
                </th>
            </tr>
            <tr>
                <th>
                    Nama
                </th>
                <th>
                    <%= karyawan("Kry_Nama") %> 
                </th>
            </tr>
            <tr>
                <th>
                    Divisi
                </th>
                <th>
                    <%= karyawan("Div_nama") %> 
                </th>
            </tr>
        </table>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg-12'>
        <table class="table table-striped lg-12 " cellpadding="10" cellspacing="0">
            <thead class="bg-secondary text-light text-center">
                    <tr>
                        <th scope="col">NIP</th>
                        <th scope="col">CABANG ABSEN</th>
                        <th scope="col">TANGGAL</th>
                        <th scope="col">ABSEN MASUK</th>
                        <th scope="col">ABSEN KELUAR</th>
                        <th scope="col">KETERANGAN MASUK</th>
                        <th scope="col">KETERANGAN KELUAR</th>
                        <th scope="col">MASUK SHIFT</th>
                        <th scope="col">KELUAR SHIFT</th>
                        <th scope="col">JAM KERJA</th>
                        <th scope="col">BEDA HARI</th>
                        <th scope="col">Longitude</th>
                        <th scope="col">Latitude</th>
                        <th scope="col">WFH/WFO</th>
                        <th scope="col">STATUS</th>
                    </tr>
                </thead>
                <% 
                    ketMasuk = 0
                    ketKeluar = 0
                    tabsenMasuk = 0
                    tabsenKeluar = 0
                    alfa = 0
                    do until karyawanshift.eof

                    'jam masuk dan keluar di absensi
                    shift_cmd.commandText = "SELECT top 1  HRD_T_Absensi.abs_datetime, GLB_M_Agen.Agen_Nama, HRD_T_Absensi.ABS_Lat, HRD_T_Absensi.ABS_Lon, HRD_T_Absensi.ABS_SyncToAdempiere FROM HRD_T_Absensi LEFT OUTER JOIN GLB_M_Agen ON HRD_T_Absensi.Abs_AgenId = GLB_M_Agen.Agen_ID where ABS_Nip = '"& karyawanshift("Kry_NIP") &"' and day(abs_datetime) = '"& day(karyawanshift("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(karyawanshift("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(karyawanshift("Shf_Tanggal")) &"'  order by abs_datetime ASC"
                    ' Response.Write shift_cmd.commandText & "<br>"
                    set jamMasuk = shift_cmd.execute

                    ShiftJamMasuk = right("00" & karyawanshift("Sh_JamIn"),2) & ":" & right("00" & karyawanshift("Sh_MenitIn") ,2)
                    
                    'jam keluar
                    shift_cmd.commandText = "SELECT TOP 1 ABS_Datetime, GLB_M_Agen.Agen_Nama, HRD_T_Absensi.ABS_Lat, HRD_T_Absensi.ABS_Lon FROM HRD_T_Absensi LEFT OUTER JOIN GLB_M_Agen ON HRD_T_Absensi.Abs_AgenID = GLB_M_Agen.Agen_ID where ABS_Nip = '"& karyawanshift("Kry_NIP") &"' and day(abs_datetime) = '"& day(karyawanshift("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(karyawanshift("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(karyawanshift("Shf_Tanggal")) &"'  order by abs_datetime DESC"

                    set jamKeluar = shift_cmd.execute

                    ShiftJamKeluar = right("00" & karyawanshift("Sh_JamOut"),2) & ":" & right("00" & karyawanshift("Sh_MenitOut") ,2)

                    'definisi jam masuk dan keluar jika sama kosongkan
                    if not jamMasuk.eof then
                        masuk = jamMasuk("Abs_datetime") 
                        longitude = jamMasuk("Abs_Lon")
                        'cek wfh dan wfo 
                    else
                        masuk = "TIDAK ABSEN"
                        longitude = "-"
                    end if 

                    if not jamKeluar.eof then 
                        keluar = jamKeluar("Abs_Datetime")
                        latitude = jamMasuk("Abs_Lat")
                    else
                        keluar = "TIDAK ABSEN"
                        latitude = "-"
                    end if 

                    'cek jika tidak absen masuk/pulang
                    if masuk = keluar then
                        masuk = "TIDAK ABSEN"
                    end if
                    
                    'cek absen di cabang mana masuk/pulang
                    if not jamMasuk.eof then
                        absenCabangMasuk = jamMasuk("Agen_Nama")
                    else
                        absenCabangMasuk = "-"
                    end if
                    
                    'cek waktu jam kerja
                    if masuk <> "TIDAK ABSEN" AND keluar <> "TIDAK ABSEN" then
                        jamKerja = dateDiff("h",formatDateTime(masuk),formatDateTime(keluar))
                    else
                        jamKerja = "-"
                    end if 

                    'cek wfh dan wfo
                    if wfh > 1 then
                        if longitude <> "-" And latitude <> "-" then
                            if not jamMasuk.eof then
                                if jamMasuk("ABS_SyncToAdempiere") = "H" then
                                    pwfh = "DILUAR KANTOR"
                                else
                                    pwfh = "DI KANTOR"
                                end if
                            end if
                        else
                            pwfh = "-"
                        end if
                    end if

                    'cek status karyawan absen sesuai dengan izincutisakit
                    if masuk = "TIDAK ABSEN" And keluar = "TIDAK ABSEN" And longitude = "-" And latitude = "-" then
                        shift_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.Ics_Status FROM HRD_T_IzinCutiSakit INNER JOIN HRD_M_Karyawan ON HRD_T_IzinCutiSakit.ICS_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND HRD_T_IzinCutiSakit.ICS_StartDate BETWEEN '"& karyawanshift("Shf_Tanggal") &"' AND '"& karyawanshift("Shf_Tanggal") &"' AND HRD_T_IzinCutiSakit.ICS_EndDate BETWEEN '"& karyawanshift("Shf_Tanggal") &"' AND '"& karyawanshift("Shf_Tanggal") &"' AND HRD_T_IzinCutiSakit.ICS_Nip = '"& karyawanshift("Kry_NIP") &"'" 

                        set status = shift_cmd.execute

                        if not status.eof then
                            if status("ics_status") = "A" then
                                icskaryawan = "ALFA"
                            elseIf status("ics_status") = "B" then
                                icskaryawan = "CUTI BERSAMA"
                            elseIf status("ics_status") = "C" then
                                icskaryawan = "CUTI"
                            elseIf status("ics_status") = "G" then
                                icskaryawan = "DISPENSASI"
                            elseIf status("ics_status") = "I" then
                                icskaryawan = "IZIN"
                            elseIf status("ics_status") = "K" then
                                icskaryawan = "KLAIM OBAT"
                            else
                                icskaryawan = "SAKIT"
                            end if
                        else
                            icskaryawan = "ALFA"
                        end if
                    else    
                        icskaryawan = "-"
                    end if
                        
                %>
                <tbody>
                    <tr>
                        <td>
                            <%= karyawanshift("Kry_Nip") %>
                        </td>
                        <!--set cabang -->
                        <td class="text-center">
                            <%=absenCabangMasuk%>
                        </td>
                        <!--end cabang -->  
                        <td>
                            <%= karyawanshift("Shf_Tanggal") %>
                        </td>
                        <!--jam masuk -->
                        <% 
                        if masuk = "TIDAK ABSEN"  then
                        tabsenMasuk = tabsenMasuk + 1
                        %>
                            <td class="text-danger">
                                <%= masuk %>
                            </td>
                        <% else %>
                            <td>
                                <%= masuk %>
                            </td>
                        <% end if %>
                        <!--jam keluar -->
                        <%
                        if keluar = "TIDAK ABSEN" then
                        tabsenKeluar = tabsenKeluar + 1
                        %>
                            <td class="text-danger">
                                <%= keluar %>
                            </td>
                        <% else %>
                            <td>
                                <%= keluar %>
                            </td>
                        <%end if%>
                        <!--keterangan masuk-->
                        <% 
                        if masuk <> "TIDAK ABSEN" then
                            if shiftJamMasuk < formatDateTime(masuk,4) then
                            ketMasuk = ketMasuk + 1
                         %>
                                <td class="text-danger">
                                    TERLAMBAT
                                </td>
                            <% else %>
                                <td>
                                    TEPAT WAKTU
                                </td>
                            <% end if %>
                        <% else %>
                            <td class="text-danger">
                                TIDAK ABSEN
                            </td>
                        <% end if %>
                        <!--keterangan keluar -->
                        <% 
                        if keluar <> "TIDAK ABSEN" then
                            if shiftJamKeluar > formatDateTime(keluar,4) then
                            ketKeluar = ketKeluar + 1
                        %>
                                <td class="text-danger">
                                    PULANG CEPAT
                                </td>
                            <% else %>
                                <td>
                                    TEPAT WAKTU
                                </td>
                            <% end if %>
                        <% else %>
                            <td class="text-danger">
                                TIDAK ABSEN
                            </td>
                        <% end if %>
                        <td>
                            <%= shiftJamMasuk %>
                        </td>
                        <td>
                            <%= ShiftJamKeluar %>
                        </td>
                        <!--jam kerja -->
                        <td class="text-center">
                            <%= jamKerja %>
                        </td>
                        <td>
                            <%= karyawanshift("Sh_iHari") %>
                        </td>
                        <!--longitude & latitude -->
                        <td class="text-center">
                            <%= longitude %>
                        </td>
                        <td class="text-center">
                            <%= latitude %>
                        </td>
                        <td class="text-center">
                            <%= pwfh %>
                        </td>
                        <!--cek status -->
                        <% 
                        if icskaryawan = "ALFA" then
                        alfa = alfa + 1
                         %>
                            <td class="text-danger text-center">
                                <%= icskaryawan %>
                            </td>
                        <% else %>
                            <td class="text-center">
                                <%= icskaryawan %>
                            </td>
                        <% end if %>
                    </tr>
                </tbody>
                <% 
                karyawanshift.movenext
				loop
                 %>
            </table>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg'>
            <label><b>KETERANGAN</b></label>
            <ul>
                <li>
                    TIDAK ABSEN MASUK = <%= tabsenMasuk %>
                </li>
                <li>
                    TIDAK ABSEN KELUAR = <%= tabsenKeluar %>
                </li>
                <li>
                    TERLAMBAT MASUK = <%= ketMasuk %>
                </li>
                <li>
                    PULANG CEPAT = <%= ketKeluar %>
                </li>
                <li>
                    ALFA = <%= alfa %>
                </li>
            </ul>
        </div>
    </div>
</div>
<!--#include file="../layout/footer.asp"-->
