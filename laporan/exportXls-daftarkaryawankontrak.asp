<%@ Language=VBScript %>
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<!-- #include file="../connection.asp"-->
<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Daftar karyawan Kontrak "& Request.QueryString("tgla") &"/"& Request.QueryString("tgle") &" .xls"
%>

<% 
dim laporan, urut, area, pegawai, bank, status, tgla, tgle
dim agen_cmd, agen
dim karyawan_cmd, karyawan 
dim aktifarea, aktifarea_cmd
dim divisi_cmd, divisi
dim salary_cmd, salary
dim pendidikan_cmd,pendidikan
dim orderby

urut = Request.QueryString("urut") 
tgla =  Request.QueryString("tgla") 
tgle = Request.QueryString("tgle") 
area = Request.QueryString("area") 
pegawai = Request.QueryString("pegawai")

bulan = month(tgla)
tahun = year(tgla)
karyawanout = ""
simvalid = "" 

bulan = month(tgla)
tahun = year(tgla)

bulane = month(tgle)
tahune = month(tgle)

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
    aktifarea_cmd.commandText = "SELECT GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_KARyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.Agen_AktifYN = 'Y' AND Month(HRD_M_Karyawan.Kry_TglMasuk) BETWEEN '"& bulan &"' AND '"& bulane &"' and YEAR(HRD_M_Karyawan.Kry_TglMasuk) = '"& tahun &"' AND (HRD_M_Karyawan.Kry_TglMasuk <> '') AND GLB_M_Agen.Agen_ID = '"& area &"' AND HRD_M_Karyawan.Kry_nip NOT LIKE '%H%' AND HRD_M_KAryawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' GROUP BY dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID ORDER BY GLB_M_Agen.Agen_Nama ASC "
    ' Response.Write aktifarea_cmd.commandText & "<br>"
    set aktifarea = aktifarea_cmd.execute
else
    aktifarea_cmd.commandText = "SELECT GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_KARyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.Agen_AktifYN = 'Y' AND Month(HRD_M_Karyawan.Kry_TglMasuk) BETWEEN '"& bulan &"' AND '"& bulane &"' and YEAR(HRD_M_Karyawan.Kry_TglMasuk) = '"& tahun &"' AND (HRD_M_Karyawan.Kry_TglMasuk <> '') AND HRD_M_Karyawan.Kry_nip NOT LIKE '%H%' AND HRD_M_KAryawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' GROUP BY dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID ORDER BY GLB_M_Agen.Agen_Nama ASC "
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
    <title>LAPORAN KARYAWAN KONTRAK</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>
    <div class='row'>
        <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
            <p>PT.Dakota Buana Semesta</p>
            <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
            <p>BEKASI</p>
        </div>
    </div>
    <div class='row'>
        <div class='col text-center judul'>
            <label class="text-center">DAFTAR KARYAWAN KONTRAK</label></br>
            <b>PRIODE <%= uCase(monthName(month(tgla))) & " " %><%= year(tgle) %> - <%= UCase(MonthName(month(tgle))) & " " %><%= year(tgle) %></b>
        </div>
    </div>
    <div class='row'>
        <div class='col col-sm' style="font-size: 10px;">
            <p>Tanggal Cetak <%= (Now) %></p>
        </div>
    </div>
    <div class='row'>
        <div class='col' >
        <table class="table" style="font-size: 10px; display: block;width: 100%;overflow: scroll;">
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
        id = ""
        do until aktifarea.eof
         %>
            <tr>
                <th colspan="24">
                    <%=aktifarea("agen_nama")%>
                </th>
            </tr>
        <% 
            id = aktifarea("Agen_ID")       
            if  pegawai = "" then
              karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_ID LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE HRD_M_Karyawan.Kry_AgenID = "& id &" and month(HRD_M_Karyawan.Kry_TglMasuk) BETWEEN '"& bulan &"' AND '"& bulane &"' and year(HRD_M_Karyawan.Kry_TglMasuk) = '"& tahun &"' AND HRD_M_karyawan.Kry_Nip NOT LIKE '%H%' and HRD_M_Karyawan.Kry_AktifYN = 'Y' "& orderby &""
                ' Response.Write karyawan_cmd.commandText
                set karyawan = karyawan_cmd.execute
            else 
                karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.*, HRD_M_JenjangDidik.JDdk_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_M_Karyawan.Kry_JDdkID = HRD_M_JenjangDidik.JDdk_ID LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE HRD_M_Karyawan.Kry_AgenID = "& id &" and HRD_M_Karyawan.Kry_Pegawai = "& pegawai &" and month(HRD_M_Karyawan.Kry_TglMasuk) = '"& bulan &"' and year(HRD_M_Karyawan.Kry_TglMasuk) = '"& tahun &"' AND HRD_M_karyawan.Kry_Nip NOT LIKE '%H%' and HRD_M_Karyawan.Kry_AktifYN = 'Y' "& orderby &""
                ' Response.Write karyawan_cmd.commandText
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
                todate = now

                umur = DateDiff("YYYY",fromdate,todate) 
                 
            'cek pendidikan data yang kosong
                vpend_nama=""
                 vdiv_nama=""
                if not karyawan.eof then
                    vpend_nama=karyawan("JDdk_Nama")
                    vdiv_nama=karyawan("Div_Nama")
                else 
                    vpend_nama = ""
                     vdiv_nama=""
                end if 

            'untuk masa kerja
                
                mulai = ""
                'cek karyawan masa kerja
                if month(karyawan("Kry_TglMasuk")) < 12 then
                    if year(karyawan("Kry_tglmasuk")) < year(todate) then
                        mulai = DateDiff("YYYY",karyawan("Kry_TglMasuk"),todate) & "Thn"
                    else
                        mulai = DateDiff("m",karyawan("Kry_TglMasuk"),todate) & " Bln"
                    end if
                end if

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
            
                'cek tanggal keluar
                if karyawan("Kry_TglKeluar") = "1/1/1900" then
                    karyawanout = ""
                else
                    karyawanout = karyawan("Kry_TglKeluar")
                end if
                'cek sim valid yang kosong
                if karyawan("Kry_SIMValidDate") = "1/1/1900" then
                    simvalid = ""
                else
                    simvalid = karyawan("Kry_SIMValidDate")
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
                    <td><%= vpend_nama%></td>
                    <td><%=karyawan("Kry_TglMasuk")%></td>
                    <td><%=karyawanout%></td>
                    <td><%=mulai%></td>
                    <td><%=karyawan("Kry_NoID")%></td>
                    <td><%=karyawan("Kry_JabCode")%></td>
                    <td><%=vdiv_nama%></td>              
                    <td><%=jsim%></td>
                    <td><%=simvalid%></td>
                    <td><%=sttkerja%></td>
                    <td><%=karyawan("Kry_NoRekening")%></td>
                    <td><%=karyawan("Kry_NoBPJS")%></td>
                    <td><%=karyawan("Kry_NoJamsostek")%></td>
                    <td><%=karyawan("Kry_NPWP")%></td>
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
        %>
            </tbody>
        </table>
        </div>
    </div>
    


<!-- #include file='../layout/footer.asp' -->