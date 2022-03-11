<%@ Language=VBScript %>

<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Laporan Gaji Perdivisi " &  Request.QueryString("bulan") & " " & Request.QueryString("tahun") & ".xls"
%>
<!-- #include file='../connection.asp' -->
<% 
response.Buffer=true
server.ScriptTimeout=1000000000

dim laporan, urut, area, pegawai, status, bulan, tahun
dim salary_cmd, salary
dim aktifarea, aktifarea_cmd
dim agen_cmd, agen
dim karyawan, karyawan2, karyawan_cmd, karyawan2_cmd
dim jmlkaryawan, Divnama, divcode

bulan = Request.QueryString("bulan")
tahun = Request.QueryString("tahun")

'cek order by
if urut = "nama" then
    orderby = "ORDER BY Kry_nama"
elseIf urut = "nip" then
    orderby = "ORDER BY Kry_Nip"
else 
    orderby = "ORDER BY Kry_nama"
end if 

'karyawan
set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_Cargo_string

'karyawan2
set karyawan2_cmd = Server.CreateObject("ADODB.Command")
karyawan2_cmd.ActiveConnection = MM_Cargo_string

'salary
set salary_cmd = Server.CreateObject("ADODB.Command")
salary_cmd.ActiveConnection = MM_Cargo_string     

'area aktif
set aktifarea_cmd = Server.CreateObject("ADODB.Command")
aktifarea_cmd.ActiveConnection = MM_Cargo_string

aktifarea_cmd.commandText = "SELECT TOP (100) PERCENT dbo.GLB_M_Agen.Agen_ID, dbo.GLB_M_Agen.Agen_Nama FROM            dbo.HRD_T_Salary_Convert LEFT OUTER JOIN dbo.HRD_M_Karyawan ON dbo.HRD_T_Salary_Convert.Sal_NIP = dbo.HRD_M_Karyawan.Kry_NIP LEFT OUTER JOIN dbo.GLB_M_Agen ON dbo.HRD_M_Karyawan.Kry_AgenID = dbo.GLB_M_Agen.Agen_ID WHERE (dbo.GLB_M_Agen.Agen_ID IS NOT NULL) AND (MONTH(dbo.HRD_T_Salary_Convert.Sal_StartDate) = '"& bulan &"') AND (YEAR(dbo.HRD_T_Salary_Convert.Sal_StartDate) = '"& tahun &"') GROUP BY dbo.GLB_M_Agen.Agen_ID, dbo.GLB_M_Agen.Agen_Nama ORDER BY dbo.GLB_M_Agen.Agen_Nama ASC"

set aktifarea = aktifarea_cmd.execute

if bulan = 1 then
    lbln = 12
else
    lbln = bulan - 1
end if

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    tr {
        width: 1%;
        white-space: nowrap;
    }
    </style>
</head>
<body>
<!--button navigation -->
<div class="btn-group position-absolute top-0 end-0" role="group" aria-label="Basic outlined example">
  <button type="button" class="btn btn-outline-primary btn-sm" onclick="window.location.href='index.asp'">Kembali</button>
  <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-laporanperdivisi.asp?bulan=<%=bulan%>&tahun=<%=tahun%>','_self')">EXPORT</button>
</div>
<!--end button -->
<div class='row'>
    <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
        <p>PT.Dakota Buana Semesta</p>
        <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
        <p>BEKASI</p>
    </div>
</div>
<div class='row'>
    <div class='col text-center judul'>
        <label class="text-center">REKAP GAJI PERDIVISI</label>
    </div>
</div>
<div class='row'>
    <div class='col col-sm' style="font-size: 10px;">
        <p>Tanggal Cetak <%= (Now) %></p>
    </div>
</div>
<div class='row'>
    <div class='col col-sm' style="font-size:14px;">
<% 
namaagen = ""
idagen = ""

do until aktifarea.eof

if not aktifarea.eof then
    namaagen = aktifarea("agen_nama")
    idagen = aktifarea("Agen_id")
else 
    namaagen = ""
    idagen = ""
end if
%>
        <p><%=namaagen%></p>
    <div>
</div>

<table class="table table-striped" style="font-size:12px;">
    <tr>
        <th>Divisi</th>
        <th>Gapok</th>
        <th>Insentif</th>
        <th>Pengembalian.Pot</th>
        <th>insentif PPh 21 DTP</th>
        <th>Transport</th>
        <th>Kesehatan</th>
        <th>Keluarga</th>
        <th>Jabatan</th>
        <th>Jamsostek</th>
        <th>PPH21</th>
        <th>Pinjaman</th>
        <th>Koperasi</th>
        <th>Klaim</th>
        <th>Asuransi</th>
        <th>Persekot</th>
        <th>Absen</th>
        <th>Lain</th>
        <th>THR</th>
    </tr>
    <% 
    'grup karyawan berdasarkan divisi dan jabatan
    karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_DDBID, HRD_M_Divisi.Div_Nama, SUM(ISNULL(HRD_T_Salary_Convert.Sal_GaPok, 0)) AS totalgapok, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Insentif, 0)) AS totalinsentif, SUM(ISNULL(HRD_T_Salary_Convert.Sal_PengembalianPot, 0)) AS pengembalianpot, SUM(ISNULL(HRD_T_Salary_Convert.Sal_InsentifPPh21DTP , 0)) AS pphdtp, SUM(ISNULL(HRD_T_Salary_Convert.Sal_TunjTransport, 0)) AS totaltransport, SUM(ISNULL(HRD_T_Salary_Convert.Sal_TunjKesehatan, 0)) AS totalkesehatan, SUM(ISNULL(HRD_T_Salary_Convert.Sal_TunjKeluarga, 0)) AS totalkeluarga, SUM(ISNULL(HRD_T_Salary_Convert.Sal_TunjJbt, 0)) AS totaljabatan, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Jamsostek, 0)) AS totaljamsostek, SUM(ISNULL(HRD_T_Salary_Convert.Sal_PPh21, 0)) AS totalpph21, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Pinjaman, 0)) AS totalpinjaman, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Koperasi, 0)) AS totalkoperasi, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Klaim, 0)) AS totalklaim, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Asuransi, 0)) AS totalasuransi, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Persekot, 0)) AS totalpersekot, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Absen, 0)) AS totalabsen, SUM(ISNULL(HRD_T_Salary_Convert.Sal_Lain, 0)) AS totallain, SUM(CONVERT(money,HRD_T_Salary_Convert.Sal_THR)) AS totalthr FROM HRD_M_Karyawan INNER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN HRD_T_Salary_Convert ON HRD_M_Karyawan.Kry_NIP = HRD_T_Salary_Convert.Sal_NIP WHERE (HRD_M_Karyawan.Kry_AgenID = '"& idagen &"') AND (Month(HRD_T_Salary_Convert.Sal_StartDate) = '"& bulan &"') AND (Year(HRD_T_Salary_Convert.Sal_StartDate) = '"& tahun &"') AND (HRD_T_Salary_Convert.Sal_AktifYN) = 'Y' GROUP BY HRD_M_Karyawan.Kry_DDBID, HRD_M_Divisi.Div_Nama ORDER BY HRD_M_Divisi.Div_Nama ASC"
    
    set karyawan = karyawan_cmd.execute
    do until karyawan.eof

    'rubah format dolar ke rupiah
    gapok = karyawan("totalgapok")
    insentif = karyawan("totalinsentif")
    transport = karyawan("totaltransport")
    kesehatan = karyawan("totalkesehatan")
    keluarga = karyawan("totalkeluarga")
    jabatan = karyawan("totaljabatan")
    jamsostek = karyawan("totaljamsostek")
    pph21 = karyawan("totalpph21")
    pinjaman = karyawan("totalpinjaman")
    koperasi = karyawan("totalkoperasi")
    klaim = karyawan("totalklaim")
    asuransi = karyawan("totalasuransi")
    persekot = karyawan("totalpersekot")
    absen = karyawan("totalabsen")
    lain = karyawan("totallain")
    thr = karyawan("totalthr")

    tgapok = gapok
    tinsentif = insentif
    ttransport = transport
    tkesehatan = kesehatan
    tkeluarga = keluarga
    tjabatan = jabatan
    tjamsostek = jamsostek
    tpph21 = pph21
    tpinjaman = pinjaman
    tkoperasi = koperasi
    tklaim = klaim
    tasuransi = asuransi
    tpersekot = persekot
    tabsen = absen
    tlain = lain
    tthr = thr
    %>
    <tr>
        <td><%=karyawan("Div_Nama")%></td>
        <td><%=replace(formatCurrency(tgapok),"$","")%></td>
        <td><%=replace(formatCurrency(tinsentif),"$","")%></td>
        <td><%=replace(formatcurrency(karyawan("pengembalianpot")),"$","")%></td>
        <td><%=replace(formatcurrency(karyawan("pphdtp")),"$","")%></td>
        <td><%=replace(formatCurrency(ttransport),"$","")%></td>
        <td><%=replace(formatCurrency(tkesehatan),"$","")%></td>
        <td><%=replace(formatCurrency(tkeluarga),"$","")%></td>
        <td><%=replace(formatCurrency(tjabatan),"$","")%></td>
        <td><%=replace(formatCurrency(tjamsostek),"$","")%></td>
        <td><%=replace(formatCurrency(tpph21),"$","")%></td>
        <td><%=replace(formatCurrency(tpinjaman),"$","")%></td>
        <td><%=replace(formatCurrency(tkoperasi),"$","")%></td>
        <td><%=replace(formatCurrency(tklaim),"$","")%></td>
        <td><%=replace(formatCurrency(tasuransi),"$","")%></td>
        <td><%=replace(formatCurrency(tpersekot),"$","")%></td>
        <td><%=replace(formatCurrency(tabsen),"$","")%></td>
        <td><%=replace(formatCurrency(tlain),"$","")%></td>
        <td><%=replace(formatCurrency(tthr),"$","")%></td>
       
    </tr>
    <% 
    Response.flush
    karyawan.movenext
    loop
    %>
</table>


<% 
Response.flush
aktifarea.movenext
loop
 %>

<!-- #include file='../layout/footer.asp' -->
