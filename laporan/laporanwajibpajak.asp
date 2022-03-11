<!-- #include file='../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
dim laporan, urut, area, pegawai, bank, status, bulan, tahun
dim karyawan_cmd, karyawan 
dim aktifarea, aktifarea_cmd
dim divisi_cmd, divisi
dim salary_cmd, salary
dim data, ptkp_cmd, ptkp
dim orderby
dim i, usia, fromdate, todate, umur

urut = Request.Form("urutberdasarkan")
area = Request.Form("laparea")
pegawai = Request.Form("lappegawai")
status = Request.Form("lapstatus")
tgla = Cdate(Request.Form("tgla"))


' area kerja
set aktifarea_cmd = Server.CreateObject("ADODB.Command")
aktifarea_cmd.ActiveConnection = MM_Cargo_string

if area = "" then
    aktifarea_cmd.commandText = "SELECT GLB_M_Agen.agen_nama, GLB_M_Agen.agen_ID FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_AGEN ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.agen_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND (HRD_M_Karyawan.Kry_Nip) IS NOT NULL AND GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%' AND HRD_M_karyawan.Kry_aktifYN = 'Y' GROUP BY GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID ORDER BY GLB_M_Agen.Agen_Nama ASC"

    set aktifarea = aktifarea_cmd.execute
else
    aktifarea_cmd.commandText = "SELECT GLB_M_Agen.agen_nama, GLB_M_Agen.agen_ID FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_AGEN ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.Agen_ID = '"& area &"' AND GLB_M_Agen.agen_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND (HRD_M_Karyawan.Kry_Nip) IS NOT NULL AND GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%' AND HRD_M_karyawan.Kry_aktifYN = 'Y' GROUP BY GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID ORDER BY GLB_M_Agen.Agen_Nama ASC"
    'Response.Write aktifarea_cmd.commandText
    set aktifarea = aktifarea_cmd.execute
end if

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
 
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN WAJIB PAJAK</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>
<% if aktifarea.eof = false then %>
<div class="btn-group position-absolute top-0 end-0" role="group" aria-label="Basic outlined example">
  <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-wajibpajak.asp?urut=<%=urut%>&area=<%=area%>','_self')">EXPORT</button>
<% end if %>
</div>
    <div class='row'>
        <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
            <p>PT.Dakota Buana Semesta</p>
            <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
            <p>BEKASI</p>
        </div>
    </div>
    <div class='row'>
        <div class='col text-center judul'>
            <label class="text-center">DAFTAR KARYAWAN WAJIB PAJAK</label>
        </div>
    </div>
    <div class='row'>
        <div class='col col-sm' style="font-size: 10px;">
            <p>Tanggal Cetak <%= (Now) %></p>
        </div>
    </div>
    <% if aktifarea.eof then %>
    <div class='row text-center text-danger mt-5' data-aos="zoom-in-down">
        <div class='col'>
            <h5>DATA TIDAK DITEMUKAN</h5>
        </div>
    </div>
    <% 
    else
    id = ""
    hasiltanggungan = 0
    hasilstatus = ""
    tglkeluar = ""
    
    
    'nilai urutan
    id = ""
    hasiltanggungan = 0
    hasilstatus = ""
    tglkeluar = ""

    do until aktifarea.eof
        id = aktifarea("agen_id")
     %>
    <div class='row'>
        <div class='col'>
            <%= aktifarea("agen_nama") %>
        </div>
    </div>
    <div class='row'>
        <div class='col col-md' >
            <table class="table" style="font-size: 12px;">
            <thead>
                <tr>
                <th scope="col">NIP</th>
                <th scope="col">Jamsostek</th>
                <th scope="col">NPWP</th>
                <th scope="col">Nama Wajib Pajak</th>
                <th scope="col">Alamat</th>
                <th scope="col">Status</th>
                <th scope="col">Tgl Masuk</th>
                <th scope="col">Tgl Keluar</th>
                </tr>
            </thead>
            <tbody>
            <% 
                karyawan_cmd.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_AgenID = '"& id &"' and Kry_AktifYN = 'Y' AND Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE '%A%' AND Kry_TglKeluar IS NOT NULL "& orderby &""
                    ' Response.Write karyawan_cmd.commandText & "<br>"
                set karyawan = karyawan_cmd.execute

          
            do until karyawan.eof 
                'cek status 
                tanggungan = karyawan("Kry_JmlTanggungan")
                anak = karyawan("Kry_jmlanak")
                
                
                if karyawan("Kry_Sex") = "W" then
                    data = "0"
                    hasiltanggungan = 0
                else 
                    data = karyawan("Kry_SttSosial")
                    hasiltanggungan = tanggungan + anak
                end if

                if data = 0 then
                    if hasiltanggungan = 0 then
                        hasilstatus = "TK0"
                    elseIf hasiltanggungan = 1 then
                        hasilstatus = "TK1"
                    elseIf hasiltanggungan = 2 then
                        hasilstatus = "TK2"
                    else 
                        hasilstatus = "TK3"
                    end if
                elseIf data = 1 then
                    if hasiltanggungan = 0 then
                        hasilstatus = "K0"
                    elseIf hasiltanggungan = 1 then
                        hasilstatus = "K1"
                    elseIf hasiltanggungan = 2 then
                        hasilstatus = "K2"
                    else 
                        hasilstatus = "K3"
                    end if
                else    
                    if hasiltanggungan = 0 then
                        hasilstatus = "HB0"
                    elseIf hasiltanggungan = 1 then
                        hasilstatus = "HB1"
                    elseIf hasiltanggungan = 2 then
                        hasilstatus = "HB2"
                    else 
                        hasilstatus = "HB3"
                    end if
                end if
            'cek tanggal keluar 
            if karyawan("Kry_TglKeluar") = "1/1/1900" then
                tglkeluar = ""
            else
                tglkeluar = karyawan("Kry_tglKeluar")
            end if
            %> 
                <tr>
                <th scope="row"><%= karyawan("Kry_Nip") %></th>
                <td><%=karyawan("Kry_NoJamsostek")%></td>
                <td><%=karyawan("Kry_NPWP")%></td>
                <td><%=karyawan("Kry_nama")%></td>
                <td><%=karyawan("Kry_Addr1")%></td>
                <td><%=hasilstatus%></td>  
                <td><%=karyawan("Kry_TglMasuk")%></td>
                <td><%=tglkeluar%></td>
                </tr>
            <% 
                Response.flush
                karyawan.movenext
                loop
            %>
            </tbody>
            </table>
        </div>
    </div>

    <% 
        Response.flush
        aktifarea.movenext
        loop
    end if
     %>
<!-- #include file='../layout/footer.asp' -->