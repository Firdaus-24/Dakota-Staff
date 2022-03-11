<!-- #include file='../connection.asp' -->
<% 
if session("username") = "" then
    Response.Redirect("../login.asp")
end if

dim laporan, urut, area, pegawai, bank, status, bulan, tahun
dim agen_cmd, agen
dim karyawan_cmd, karyawan 
dim aktifarea, aktifarea_cmd
dim divisi_cmd, divisi, jabatan_cmd, jabatan
dim salary_cmd, salary
dim orderby

laporan = Request.Form("laporan")
urut = Request.Form("urutberdasarkan")
area = Request.Form("laparea")
pegawai = Request.Form("lappegawai")
status = Request.Form("lapstatus")
tgla = Request.Form("tgla")
tgle = Request.Form("tgle")

' area kerja
set aktifarea_cmd = Server.CreateObject("ADODB.Command")
aktifarea_cmd.ActiveConnection = MM_Cargo_string

if area = "" then
    aktifarea_cmd.commandText = "SELECT agen_nama, agen_ID FROM glb_m_agen LEFT OUTER JOIN HRD_M_Karyawan ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE HRD_M_Karyawan.Kry_Nip LIKE '%H%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' GROUP BY agen_nama, agen_ID ORDER BY GLB_M_Agen.Agen_Nama"
    ' Response.Write aktifarea_cmd.commandText & "<br>"
    set aktifarea = aktifarea_cmd.execute
else
    aktifarea_cmd.commandText = "SELECT agen_nama, agen_ID FROM glb_m_agen LEFT OUTER JOIN HRD_M_Karyawan ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE HRD_M_Karyawan.Kry_Nip LIKE '%H%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND Agen_ID = '"& area &"' GROUP BY agen_nama, agen_ID ORDER BY GLB_M_Agen.Agen_Nama"
    set aktifarea = aktifarea_cmd.execute
end if

if urut = "nama" then
    orderby = "ORDER BY Kry_nama"
elseIf urut = "nip" then
    orderby = "ORDER BY Kry_Nip"
else 
    orderby = "ORDER BY Kry_nama"
end if      
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN KARYAWAN HARIAN</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>
<div class="btn-group position-absolute top-0 end-0" role="group" aria-label="Basic outlined example">
  <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-daftarkaryawanharian.asp?urut=<%=urut%>&tgla=<%=tgla%>&tgle=<%=tgle%>&area=<%=area%>&pegawai=<%=pegawai%>','_self')">EXPORT</button>
</div>
    <div class='container'>
        <div class='row'>
            <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
                <p>PT.Dakota Buana Semesta</p>
                <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
                <p>BEKASI</p>
            </div>
        </div>
        <div class='row'>
            <div class='col text-center'>
                <label class="text-center"><b>DAFTAR KARYAWAN HARIAN</b></label>
            </div>
        </div>
        <div class='row'>
            <div class='col text-center'>
                <label class="text-center">Pirode :<%= formatdatetime(tgla,2) %> - <%= formatdatetime(tgle,2) %></label>
            </div>
        </div>
        <div class='row'>
            <div class='col col-sm' style="font-size: 10px;">
                <p>Tanggal Cetak <%= (Now) %></p>
            </div>
        </div>
        <div class='row'>
            <div class='col col-md' >
            <table class="table table-hover" style="font-size: 12px;">
                <thead class="bg-secondary text-light text-center">
                    <tr>
                        <th scope="col">Nama</th>
                        <th scope="col">Cabang</th>
                        <th scope="col">Jabatan</th>
                    </tr>
                </thead>
                <%         
                dim id
                do until aktifarea.eof 
                    aktifarea_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_COde WHERE HRD_M_Karyawan.Kry_AgenID = '"& aktifarea("Agen_ID") &"' AND HRD_M_KAryawan.Kry_Nip LIKE '%H%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_KAryawan.Kry_TglMAsuk BETWEEN '"& tgla &"' AND '"& tgle &"' ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set karyawan = aktifarea_cmd.execute
                    
                    do while not karyawan.eof 
                %>
                <tbody>
                    <tr>
                        <td><%=karyawan("Kry_nama")%></td>
                        <td><%=karyawan("Agen_nama")%></td>
                        <td><%=karyawan("Div_Nama")%></td>
                    </tr>
                </tbody>
                <% 
                    Response.flush
                    karyawan.movenext
                    loop
                Response.flush
                aktifarea.movenext
                i = i + 1
                loop
                %>
            </table>
            </div>
        </div>
    </div>
<!-- #include file='../layout/footer.asp' -->