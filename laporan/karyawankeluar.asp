<!-- #include file='../connection.asp' -->
<% 
if session("username") = "" then
    Response.Redirect("../login.asp")
end if
' response.Buffer=true
' server.ScriptTimeout=1000000000
dim laporan, urut, area, pegawai, bank, status, tgla, tgle
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

'karyawan
set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_Cargo_string

' area kerja
set aktifarea_cmd = Server.CreateObject("ADODB.Command")
aktifarea_cmd.ActiveConnection = MM_Cargo_string

if area = "" then
    aktifarea_cmd.commandText = "SELECT agen_nama, agen_ID FROM glb_m_agen LEFT OUTER JOIN HRD_M_Karyawan ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_AktifYN = 'N' AND HRD_M_Karyawan.Kry_TglKeluar <> '' AND HRD_M_Karyawan.Kry_TglKeluar BETWEEN '"& tgla &"' AND '"& tgle &"' GROUP BY agen_nama, agen_ID ORDER BY GLB_M_Agen.Agen_Nama"
    ' Response.Write aktifarea_cmd.commandText & "<br>"
    set aktifarea = aktifarea_cmd.execute
else
    aktifarea_cmd.commandText = "SELECT agen_nama, agen_ID FROM glb_m_agen LEFT OUTER JOIN HRD_M_Karyawan ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_AktifYN = 'N' AND Agen_ID = '"& area &"' AND HRD_M_Karyawan.Kry_TglKeluar <> '' AND HRD_M_Karyawan.Kry_TglKeluar BETWEEN '"& tgla &"' AND '"& tgle &"' GROUP BY agen_nama, agen_ID ORDER BY GLB_M_Agen.Agen_Nama"
    set aktifarea = aktifarea_cmd.execute
end if

if urut = "nama" then
    orderby = "ORDER BY Kry_nama"
elseIf urut = "nip" then
    orderby = "ORDER BY Kry_Nip"
else 
    orderby = "ORDER BY Kry_nama"
end if

'nilai urutan
dim i, k
i = 1
k = 1
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>
<div class="btn-group position-absolute top-0 end-0" role="group" aria-label="Basic outlined example">
  <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-karyawankeluar.asp?urut=<%=urut%>&tgla=<%=tgla%>&tgle=<%=tgle%>&area=<%=area%>&pegawai=<%=pegawai%>','_self')">EXPORT</button>
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
        <div class='col text-center judul'>
            <label class="text-center"><b>DAFTAR KARYAWAN KELUAR</b></label></br>
            <label class="text-center">Priode : <%= formatDatetime(tgla,2) %> - <%= formatDatetime(tgle,2) %></label>
        </div>
    </div>
    <div class='row'>
        <div class='col col-sm' style="font-size: 10px;">
            <p>Tanggal Cetak <%= (Now) %></p>
        </div>
    </div>
    <div class='row'>
        <div class='col' >
        <table class="table" style="font-size: 12px;">
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">Nip</th>
                    <th scope="col">Nama</th>
                    <th scope="col">Jabatan</th>
                    <th scope="col">Divisi</th>
                    <th scope="col">Tgl Keluar</th>
                    <th scope="col">Ket.Resign</th>
                    <th scope="col">Gaji</th>
                    <th scope="col">Tun-Jab</th>
                    <th scope="col">No KTP</th>
                    <th scope="col">Tgl Lahir</th>
                    <th scope="col">Jamsostek</th>
                    <th scope="col">NPWP</th>
                    <th colspan="2"scope="col">Status</th>
                    <th scope="col">No Rek</th>
                    <th scope="col">NPP</th>
                </tr>
            </thead>
            <tbody>
            <%
            do until aktifarea.eof
             %>
            <tr>
                <th colspan="17" class="bg-secondary text-light"><%= aktifarea("Agen_Nama") %></th>
            </tr>
            <% 
                if  pegawai = "" then
                    karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_TglKeluar, HRD_M_Karyawan.Kry_NoID, HRD_M_Karyawan.Kry_TglLahir, HRD_M_Karyawan.Kry_NPWP, HRD_M_Karyawan.Kry_NoJamsostek, HRD_M_Karyawan.Kry_SttSosial, HRD_M_karyawan.Kry_JmlTanggungan, HRD_M_karyawan.Kry_jmlanak, HRD_M_Karyawan.Kry_Norekening, GLB_M_agen.Agen_Nama, HRD_M_Jabatan.Jab_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_COde WHERE HRD_M_Karyawan.Kry_TglKeluar <> '' AND HRD_M_Karyawan.Kry_TglKeluar BETWEEN '"& tgla &"' AND '"& tgle &"' AND HRD_M_Karyawan.Kry_agenID = '"& aktifarea("Agen_ID") &"' AND HRD_M_Karyawan.Kry_AktifYN = 'N' "& orderby &""
                    ' Response.Write karyawan_cmd.commandText
                    set karyawan = karyawan_cmd.execute
                else 
                    karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_TglKeluar, HRD_M_Karyawan.Kry_NoID, HRD_M_Karyawan.Kry_TglLahir, HRD_M_Karyawan.Kry_NPWP, HRD_M_Karyawan.Kry_NoJamsostek, HRD_M_Karyawan.Kry_SttSosial, HRD_M_karyawan.Kry_JmlTanggungan, HRD_M_karyawan.Kry_jmlanak, HRD_M_Karyawan.Kry_Norekening, GLB_M_agen.Agen_Nama, HRD_M_Jabatan.Jab_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_COde WHERE HRD_M_Karyawan.Kry_TglKeluar <> '' AND HRD_M_Karyawan.Kry_TglKeluar BETWEEN '"& tgla &"' AND '"& tgle &"' AND HRD_M_Karyawan.Kry_agenID = '"& aktifarea("Agen_ID") &"' AND HRD_M_Karyawan.Kry_AktifYN = 'N' AND HRD_M_Karyawan.Kry_ActiveAgenID = '"& pegawai &"' "& orderby &""
                    ' Response.Write karyawan_cmd.commandText
                    set karyawan = karyawan_cmd.execute
                end if
            
                gapok = ""
                tunjabatan = ""
                ttanggungan = 0
                do until karyawan.eof
                'hitung jumlah tanggungan
                ttanggungan = Cint(karyawan("Kry_JmlTanggungan")) + Cint(karyawan("Kry_JmlAnak"))
        
                'cekstatus
                data = karyawan("Kry_SttSosial")
                tanggungan = karyawan("Kry_JmlTanggungan")
                anak = karyawan("Kry_jmlanak")
                
                hasiltanggungan = tanggungan + anak

                if data = 0 then
                    if hasiltanggungan = 0 then
                        hasilstatus = "TK"
                    elseIf hasiltanggungan = 1 then
                        hasilstatus = "TK"
                    elseIf hasiltanggungan = 2 then
                        hasilstatus = "TK"
                    else 
                        hasilstatus = "TK"
                    end if
                elseIf data = 1 then
                    if hasiltanggungan = 0 then
                        hasilstatus = "K"
                    elseIf hasiltanggungan = 1 then
                        hasilstatus = "K"
                    elseIf hasiltanggungan = 2 then
                        hasilstatus = "K"
                    else 
                        hasilstatus = "K"
                    end if
                else    
                    if hasiltanggungan = 0 then
                        hasilstatus = "HB"
                    elseIf hasiltanggungan = 1 then
                        hasilstatus = "HB"
                    elseIf hasiltanggungan = 2 then
                        hasilstatus = "HB"
                    else 
                        hasilstatus = "HB"
                    end if
                end if

                ' set gaji dan tunjangan jabatan
                karyawan_cmd.commandText = "SELECT TOP 1 Sal_Gapok, Sal_TunjJbt FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& karyawan("Kry_Nip") &"' ORDER BY Sal_StartDate DESC"
                ' Response.Write karyawan_cmd.commandTExt & "<br>" 
                set gaji = karyawan_cmd.execute

                if not gaji.eof then
                    gapok = Replace(formatCurrency(gaji("Sal_gapok")),"$","Rp.")
                    tunjangan = Replace(formatCurrency(gaji("Sal_TunjJbt")),"$","Rp.")
                else
                    gapok = ""
                    tunjangan = ""
                end if
            %>
                <tr>
                    <th><%=k%></th>
                    <td><%=karyawan("Kry_NIP")%></td>
                    <td><%=karyawan("Kry_nama")%></td>
                    <td><%=karyawan("Jab_Nama")%></td>
                    <td><%=karyawan("Div_Nama")%></td>
                    <td><%=karyawan("Kry_TglKeluar")%></td>
                    <td></td> 
                    <td><%=gapok%></td>
                    <td><%=tunjangan%></td>
                    <td><%=karyawan("Kry_NoID")%></td>
                    <td><%=karyawan("Kry_TglLahir")%></td>
                    <td><%=karyawan("Kry_NoJamsostek")%></td>
                    <td><%=karyawan("Kry_NPWP")%></td>
                    <td><%=hasilstatus%></td>
                    <td><%=ttanggungan%></td>
                    <td><%=karyawan("Kry_NoRekening")%></td>
                    <td></td>
                    <td></td>
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
    </div>


<!-- #include file='../layout/footer.asp' -->