<%@ Language=VBScript %>
<!-- #include file="../connection.asp"-->
<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Daftar karyawan "& Request.QueryString("bulan") &"/"& Request.QueryString("tahun") &" .xls"

dim urut, area, pegawai, status, bulan, tahun
dim agen_cmd, agen
dim karyawan_cmd, karyawan 
dim aktifarea, aktifarea_cmd
dim divisi_cmd, divisi
dim salary_cmd, salary
dim pendidikan_cmd,pendidikan
dim orderby

urut = Request.QueryString("urut") 
tgla =  Request.QueryString("tgla") 
' tahun = Request.QueryString("tahun") 
area = Request.QueryString("area") 
pegawai = Request.QueryString("pegawai")
status = Request.QueryString("status") 

bulan = month(tgla)
tahun = year(tgla)

' Cek Order by
if urut = "nama" then
    orderby = "ORDER BY Kry_nama ASC"
elseIf urut = "nip" then
    orderby = "ORDER BY Kry_Nip ASC"
else 
    orderby = "ORDER BY Kry_nama ASC"
end if

' area kerja
set aktifarea_cmd = Server.CreateObject("ADODB.Command")
aktifarea_cmd.ActiveConnection = MM_Cargo_string

if area <> "" then
    aktifarea_cmd.commandText = "SELECT GLB_M_Agen.agen_nama, GLB_M_Agen.agen_ID FROM HRD_T_Salary_convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_salary_convert.Sal_NIP = HRD_M_Karyawan.Kry_NIp LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.Agen_ID = "& area &" and GLB_M_Agen.Agen_AktifYN = 'Y' AND Month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' AND YEAR(HRD_T_Salary_convert.Sal_StartDate) = '"& tahun &"' ORDER BY GLB_M_Agen.Agen_Nama"
    ' Response.Write aktifarea_cmd.commandText & "<br>"
    set aktifarea = aktifarea_cmd.execute
else
    aktifarea_cmd.commandText = "SELECT dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID FROM dbo.HRD_T_Salary_convert LEFT OUTER JOIN dbo.HRD_M_Karyawan ON dbo.HRD_T_Salary_convert.Sal_NIP = dbo.HRD_M_Karyawan.Kry_NIP LEFT OUTER JOIN dbo.GLB_M_Agen ON dbo.HRD_M_Karyawan.Kry_AgenID = dbo.GLB_M_Agen.Agen_ID WHERE (dbo.HRD_M_Karyawan.Kry_AktifYN = 'Y') AND (dbo.GLB_M_Agen.Agen_Nama <> '') AND Month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and YEAR(HRD_T_Salary_convert.Sal_StartDate) = '"& tahun &"' GROUP BY dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID ORDER BY dbo.GLB_M_Agen.Agen_Nama"
    ' Response.Write aktifarea_cmd.commandText & "<br>"
    set aktifarea = aktifarea_cmd.execute
end if

'nilai urutan
dim i, k, usia, fromdate, todate, umur
i = 1
k = 1
'karyawan
set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_Cargo_string

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN KARYAWAN</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
        th{
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <table>
        <tr>
            <td colspan="3">PT.Dakota Buana Semesta</td>
        </tr>
        <tr>
            <td colspan="3">JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</td>
        </tr>
        <tr>
            <td colspan="3">BEKASI</td>
        </tr>
        <tr>
            <td colspan="26" style="text-align:center;">
                DAFTAR KARYAWAN
            </td>
        </tr>
        <tr>
                <td colspan="26" style="text-align:center;">PRIODE <%= monthName(month(tgla)) %><%= space(1) %><%= year(tgla) %></td>
        </tr>
        <tr>
            <td colspan="26" style="font-size:10px;">
                Tanggal Cetak <%= (Now) %>
            </td>
        </tr>
    </table>
        <div class='col col-md' >
        <% if area <> "" then 
        id = aktifarea("Agen_ID")%>
        <table class="table" style="font-size: 12px;">
        <%= aktifarea("agen_nama")%>
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">Nip</th>
                    <th scope="col">Nama</th>
                    <th scope="col">Jenis Kelamin</th>
                    <th scope="col">Alamat</th>
                    <th scope="col">Kota</th>
                    <th scope="col">Tempat Lahir</th>
                    <th scope="col">Tgl Lahir</th>
                    <th scope="col">Status Sosial</th>
                    <th scope="col">Jumlah Anak</th>
                    <th scope="col">Jumlah Tanggungan</th>
                    <th scope="col">Usia</th>
                    <th scope="col">Pendidikan</th>
                    <th scope="col">Tgl Masuk</th>
                    <th scope="col">Tgl Keluar</th>
                    <th scope="col">Masa Kerja</th>
                    <th scope="col">No KTP</th>
                    <th scope="col">Jabatan</th>
                    <th scope="col">Divisi</th>
                    <th scope="col">SIM</th>
                    <th scope="col">Tgl Berlaku</th>
                    <th scope="col">Status</th>
                    <th scope="col">No Rek</th>
                    <th scope="col">No BPJS Kes</th>
                    <th scope="col">No BPJS TK</th>
                    <th scope="col">NPWP</th>
                </tr>
            </thead>
            <tbody>
            <%     
            if  pegawai = "" AND status = "" then
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_T_Salary_convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_Id LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE HRD_M_Karyawan.Kry_AgenID = '"& id &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' and month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_convert.Sal_StartDate)= '"& tahun &"' "& orderby &""
                ' Response.Write karyawan_cmd.commandText & "<br>"
                set karyawan = karyawan_cmd.execute
            elseIf pegawai <> "" then
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_T_Salary_convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_Id LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE HRD_M_Karyawan.Kry_AgenID = '"& id &"' AND HRD_M_Karyawan.Kry_Pegawai = '"& pegawai &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' and month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_convert.Sal_StartDate)= '"& tahun &"' "& orderby &""
                ' Response.Write karyawan_cmd.commandText & "<br>"
                set karyawan = karyawan_cmd.execute
            else 
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_T_Salary_convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_Id LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE HRD_M_Karyawan.Kry_AgenID = '"& id &"' AND HRD_M_Karyawan.Kry_Pegawai = '"& pegawai &"' and and HRD_M_Karyawan.Kry_SttKerja = '"& status &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' and month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_convert.Sal_StartDate)= '"& tahun &"' "& orderby &""
                ' Response.Write karyawan_cmd.commandText & "<br>"
                set karyawan = karyawan_cmd.execute
            end if

            do until karyawan.eof
            '  'cek peria dan wanita
                pl = ""
                if karyawan("Kry_Sex") = "W" then
                    pl = "Wanita"
                else 
                    pl = "Laki-Laki"
                end if

            'cek status sosial
                ssos = ""
                if karyawan("Kry_SttSosial") = 0 then
                    ssos = "Belum Menikah"
                elseIf karyawan("Kry_SttSosial") = 1 then
                    ssos = "Menikah"
                elseIf karyawan("Kry_SttSosial") = 2 then
                    ssos = "Janda/Duda"
                else
                    ssos = ""
                end if

            'untuk umur
                fromdate = karyawan("Kry_TglLahir")
                todate = date
                umur = DateDiff("YYYY",fromdate,todate) 

            'cek pendidikan data yang kosong
                vpend_nama=""
                vdiv_nama=""
                if not karyawan.eof then
                    vpend_nama=karyawan("JDdk_Nama")
                    vdiv_nama=karyawan("Div_Nama")
                else 
                    vpend_nama = ""
                end if 

            'untuk masa kerja
                dim mulai
                mulai = ""
                'cek karyawan masa kerja
                if karyawan("Kry_TglKeluar") = "" OR karyawan("Kry_TglKeluar") = "1/1/1900" then
                    mulai = DateDiff("YYYY",karyawan("Kry_TglMasuk"),todate)
                else
                    mulai = DateDiff("YYYY",karyawan("Kry_TglMasuk"),karyawan("Kry_TglKeluar"))
                end if
            ' Response.Write karyawan("Kry_TglMasuk")

            'jenis sim
                jsim = ""
                if karyawan("Kry_JnsSIM") = 4 then
                    jsim = "B2 Umum"
                elseIf karyawan("Kry_JnsSIM") = 0 then
                    jsim = "A"
                elseIf karyawan("Kry_JnsSIM") = 1 then
                    jsim = "B1"
                elseIf karyawan("Kry_JnsSIM") = 2 then
                    jsim = "B1Umum"
                elseIf karyawan("Kry_JnsSIM") = 3 then
                    jsim = "B2"
                elseIf karyawan("Kry_JnsSIM") = 5 then
                    jsim = "C"
                else
                    jsim = ""
                end if

            'status kerja
                sttkerja = ""
                if karyawan("Kry_SttKerja") = 0 then
                    sttkerja = "Borongan"
                elseIf karyawan("Kry_SttKerja") = 1 then
                    sttkerja = "Harian"
                elseIf karyawan("Kry_SttKerja") = 2 then 
                    sttkerja = "Kontrak"
                elseIf karyawan("Kry_SttKerja") = 3 then
                    sttkerja = "Magang"
                elseIf karyawan("Kry_SttKerja") = 4 then
                    sttkerja = "Tetap"
                else 
                    sttkerja = ""
                end if

            'hilangkan tanggal keluar 
            tglkeluar = ""
            if karyawan("Kry_TglKeluar") = "1/1/1900" then  
                tglkeluar = ""
            else
                tglkeluar = karyawan("Kry_TglKeluar")
            end if
            validsim = ""
            if karyawan("Kry_SIMValidDate") = "1/1/1900" then  
                validsim = ""
            else
                validsim = karyawan("Kry_SIMValidDate")
            end if

            %>
                <tr>
                    <th scope="row"><%=k%></th>
                    <th style="mso-number-format:\@;"><%= karyawan("Kry_Nip") %></th>
                    <td><%=karyawan("Kry_nama")%></td>
                    <td><%=pl%></td>
                    <td><%=karyawan("Kry_Addr1")%></td>
                    <td><%=karyawan("Kry_Kota")%></td>
                    <td><%=karyawan("Kry_TmpLahir")%></td>
                    <td><%=karyawan("Kry_TglLahir")%></td>
                    <td><%=ssos%></td>
                    <td><%=karyawan("Kry_JmlAnak")%></td>
                    <td><%=karyawan("Kry_JmlTanggungan")%></td>
                    <td><%=umur%></td>
                    <td><%=vpend_nama%></td>
                    <td><%=karyawan("Kry_TglMasuk")%></td>
                    <td><%=tglkeluar%></td>
                    <td><%=mulai%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoID")%></td>
                    <td><%=karyawan("Kry_JabCode")%></td>
                    <td><%=vdiv_nama%></td>              
                    <td><%=jsim%></td>
                    <td><%=validsim%></td>
                    <td><%=sttkerja%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoRekening")%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoBPJS")%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoJamsostek")%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NPWP")%></td>
                </tr>
            <% 
            Response.flush
            karyawan.movenext
            k = k + 1
            loop
            k = 1
            %>
        <%
        else 
        do until aktifarea.eof
        ' Response.Write aktifarea("Agen_ID") & "<br>"
        id = aktifarea("Agen_ID")
        
         %>
        <table class="table" style="font-size: 12px;">
        <%= aktifarea("agen_nama")%>
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">Nip</th>
                    <th scope="col">Nama</th>
                    <th scope="col">Jenis Kelamin</th>
                    <th scope="col">Alamat</th>
                    <th scope="col">Kota</th>
                    <th scope="col">Tempat Lahir</th>
                    <th scope="col">Tgl Lahir</th>
                    <th scope="col">Status Sosial</th>
                    <th scope="col">Jumlah Anak</th>
                    <th scope="col">Jumlah Tanggungan</th>
                    <th scope="col">Usia</th>
                    <th scope="col">Pendidikan</th>
                    <th scope="col">Tgl Masuk</th>
                    <th scope="col">Tgl Keluar</th>
                    <th scope="col">Masa Kerja</th>
                    <th scope="col">No KTP</th>
                    <th scope="col">Jabatan</th>
                    <th scope="col">Divisi</th>
                    <th scope="col">SIM</th>
                    <th scope="col">Tgl Berlaku</th>
                    <th scope="col">Status</th>
                    <th scope="col">No Rek</th>
                    <th scope="col">No BPJS Kes</th>
                    <th scope="col">No BPJS TK</th>
                    <th scope="col">NPWP</th>
                </tr>
            </thead>
            <tbody>
            <%     
            if  pegawai = "" AND status = "" then
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_Salary_convert ON HRD_M_Karyawan.Kry_Nip = HRD_T_Salary_convert.Sal_Nip LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_Id LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE HRD_M_Karyawan.Kry_ActiveAgenID = '"& id &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' and month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_convert.Sal_StartDate)= '"& tahun &"' "& orderby &""
                ' Response.Write karyawan_cmd.commandText & "<br>"
                set karyawan = karyawan_cmd.execute
            elseIf status = "" then
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_Salary_convert ON HRD_M_Karyawan.Kry_Nip = HRD_T_Salary_convert.Sal_Nip LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_Id LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code  WHERE HRD_M_Karyawan.Kry_ActiveAgenID = '"& id &"' and HRD_M_Karyawan.Kry_Pegawai = '"& pegawai &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' and month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_convert.Sal_StartDate) = '"& tahun &"' "& orderby &""
                'Response.Write karyawan_cmd.commandText
                set karyawan = karyawan_cmd.execute
            else 
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_Salary_convert ON HRD_M_Karyawan.Kry_Nip = HRD_T_Salary_convert.Sal_Nip LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_Id LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code  WHERE HRD_M_Karyawan.Kry_ActiveAgenID = '"& id &"' and HRD_M_Karyawan.Kry_SttKerja = '"& status &"' and HRD_M_Karyawan.Kry_Pegawai = '"& pegawai &"' and month(HRD_T_Salary_convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_convert.Sal_StartDate) = '"& tahun &"' "& orderby &""
                'Response.Write karyawan_cmd.commandText
                set karyawan = karyawan_cmd.execute
            end if

            do until karyawan.eof
            '  'cek peria dan wanita
                pl = ""
                if karyawan("Kry_Sex") = "W" then
                    pl = "Wanita"
                else 
                    pl = "Laki-Laki"
                end if

            'cek status sosial
                ssos = ""
                if karyawan("Kry_SttSosial") = 0 then
                    ssos = "Belum Menikah"
                elseIf karyawan("Kry_SttSosial") = 1 then
                    ssos = "Menikah"
                elseIf karyawan("Kry_SttSosial") = 2 then
                    ssos = "Janda/Duda"
                else
                    ssos = ""
                end if

            'untuk umur
                fromdate = karyawan("Kry_TglLahir")
                todate = date
                umur = DateDiff("YYYY",fromdate,todate) 

            'cek pendidikan data yang kosong
                vpend_nama=""
                vdiv_nama=""
                if not karyawan.eof then
                    vpend_nama=karyawan("JDdk_Nama")
                    vdiv_nama=karyawan("Div_Nama")
                else 
                    vpend_nama = ""
                end if 

            'untuk masa kerja
               
                mulai = ""
                'cek karyawan masa kerja
                if karyawan("Kry_TglKeluar") = "" OR karyawan("Kry_TglKeluar") = "1/1/1900" then
                    mulai = DateDiff("YYYY",karyawan("Kry_TglMasuk"),todate)
                else
                    mulai = DateDiff("YYYY",karyawan("Kry_TglMasuk"),karyawan("Kry_TglKeluar"))
                end if
            ' Response.Write karyawan("Kry_TglMasuk")

            'jenis sim
                jsim = ""
                if karyawan("Kry_JnsSIM") = 4 then
                    jsim = "B2 Umum"
                elseIf karyawan("Kry_JnsSIM") = 0 then
                    jsim = "A"
                elseIf karyawan("Kry_JnsSIM") = 1 then
                    jsim = "B1"
                elseIf karyawan("Kry_JnsSIM") = 2 then
                    jsim = "B1Umum"
                elseIf karyawan("Kry_JnsSIM") = 3 then
                    jsim = "B2"
                elseIf karyawan("Kry_JnsSIM") = 5 then
                    jsim = "C"
                else
                    jsim = ""
                end if

            'status kerja
                sttkerja = ""
                if karyawan("Kry_SttKerja") = 0 then
                    sttkerja = "Borongan"
                elseIf karyawan("Kry_SttKerja") = 1 then
                    sttkerja = "Harian"
                elseIf karyawan("Kry_SttKerja") = 2 then 
                    sttkerja = "Kontrak"
                elseIf karyawan("Kry_SttKerja") = 3 then
                    sttkerja = "Magang"
                elseIf karyawan("Kry_SttKerja") = 4 then
                    sttkerja = "Tetap"
                else 
                    sttkerja = ""
                end if

            'hilangkan tanggal keluar 
            tglkeluar = ""
            if karyawan("Kry_TglKeluar") = "1/1/1900" then  
                tglkeluar = ""
            else
                tglkeluar = karyawan("Kry_TglKeluar")
            end if
            validsim = ""
            if karyawan("Kry_SIMValidDate") = "1/1/1900" then  
                validsim = ""
            else
                validsim = karyawan("Kry_SIMValidDate")
            end if

            %>
                <tr>
                    <th scope="row"><%=k%></th>
                    <th style="mso-number-format:\@;"><%= karyawan("Kry_Nip") %></th>
                    <td><%=karyawan("Kry_nama")%></td>
                    <td><%=pl%></td>
                    <td><%=karyawan("Kry_Addr1")%></td>
                    <td><%=karyawan("Kry_Kota")%></td>
                    <td><%=karyawan("Kry_TmpLahir")%></td>
                    <td><%=karyawan("Kry_TglLahir")%></td>
                    <td><%=ssos%></td>
                    <td><%=karyawan("Kry_JmlAnak")%></td>
                    <td><%=karyawan("Kry_JmlTanggungan")%></td>
                    <td><%=umur%></td>
                    <td><%=vpend_nama%></td>
                    <td><%=karyawan("Kry_TglMasuk")%></td>
                    <td><%=tglkeluar%></td>
                    <td><%=mulai%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoID")%></td>
                    <td><%=karyawan("Kry_JabCode")%></td>
                    <td><%=vdiv_nama%></td>              
                    <td><%=jsim%></td>
                    <td><%=validsim%></td>
                    <td><%=sttkerja%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoRekening")%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoBPJS")%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NoJamsostek")%></td>
                    <td style="mso-number-format:\@;"><%=karyawan("Kry_NPWP")%></td>
                </tr>
            <% 
            Response.flush
            karyawan.movenext
            k = k + 1
            loop
            k = 1
            %>
        <% 
        Response.flush
        aktifarea.movenext
        i = i + 1
        loop
        end if
        %>
            </tbody>
        </table>
        </div>
    </div>
    


<!-- #include file='../layout/footer.asp' -->