<!-- #include file='../connection.asp' -->
<% 
dim laporan, urut, area, pegawai, status, tgla, tgle, i, lbnl
dim agen_cmd, agen
dim karyawan_cmd, karyawan, karyawanb_cmd, karyawanb
dim aktifarea, aktifarea_cmd, aktifareab, aktifareab_cmd
dim jabatan_cmd, jabatan, mutasi_cmd, mutasi, jabatanb_cmd, jabatanb
dim salary_cmd, salary, salary2, salary2_cmd
dim orderby
dim mutasike, mutasidari, jablama, jabnow, nip, nipkrynlama, nipkrynbaru

urut = Request.Form("urutberdasarkan")
tgla = cdate(Request.Form("tgla"))
tgle = Cdate(Request.Form("tgle"))

'cek order by
if urut = "nama" then
    orderby = "ORDER BY Kry_nama"
elseIf urut = "nip" then
    orderby = "ORDER BY Kry_Nip"
else 
    orderby = "ORDER BY Kry_nama"
end if 

'mutasi
set mutasi_cmd = Server.CreateObject("ADODB.Command")
mutasi_cmd.ActiveConnection = MM_Cargo_string

mutasi_cmd.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_Karyawan.Kry_Nip, HRD_M_karyawan.Kry_Nama, HRD_M_Karyawan.Kry_NPWP FROM HRD_M_karyawan INNER JOIN HRD_T_Mutasi ON HRD_M_karyawan.Kry_Nip = HRD_T_Mutasi.Mut_Nip WHERE HRD_T_Mutasi.Mut_AktifYN = 'Y' and HRD_T_Mutasi.Mut_DemosiYN = 'Y' AND HRD_T_Mutasi.Mut_Tanggal BETWEEN '"& tgla &"' AND '"& tgle &"' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_T_Mutasi.Mut_Status = '1' "& orderby &""
' Response.Write mutasi_cmd.commandText & "<br>"
set mutasi = mutasi_cmd.execute

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
  <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-karyawandemosi.asp?urut=<%=urut%>&tgla=<%=tgla%>&tgle=<%=tgle%>','_self')">EXPORT</button>
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
        <label class="text-center">DAFTAR KARYAWAN DEMOSI</label>
    </div>
</div>
<div class='row'>
    <div class='col text-center judul'>
        <b>Priode : <%= tgla %> sampai <%= tgle %></b>
    </div>
</div>
<div class='row'>
    <div class='col col-sm' style="font-size: 10px;">
        <p>Tanggal Cetak <%= (Now) %></p>
    </div>
</div>
<div class='row'>
    <div class='col col-md' >
        <table class="table table-bordered text-center" style="font-size: 12px;">
            <thead class="text-sm-center">
                <tr>
                    <th rowspan="2" scope="col">Bulan</th>
                    <th rowspan="2" scope="col">No</th>
                    <th rowspan="2" scope="col">Nip</th>
                    <th rowspan="2" scope="col">Nama</th>
                    <th colspan="2" scope="col">Area Kerja</th>
                    <th colspan="2" scope="col">Jabatan</th>
                    <th colspan="2" scope="col">Upah Lama</th>
                    <th colspan="2" scope="col">Upah Baru</th>
                    <th colspan="2" scope="col">Selisih Perubahan</th>
                    <th rowspan="2" scope="col">NPWP</th>
                </tr>
                <tr>
                    <th>Lama</th>
                    <th>Baru</th>
                    <th>Lama</th>
                    <th>Baru</th>
                    <th>Gapok</th>
                    <th>Tunjangan</th>
                    <th>Gapok</th>
                    <th>Tunjangan</th>
                    <th>Gapok</th>
                    <th>Tunjangan</th>
                </tr>
            </thead>
            <tbody>
            <% 
            gapok = 0
            tunjangan = 0
            gapok1 = 0
            tunjangan1 = 0
            nama = ""
            i = 1
            selisihgaji = 0
            selisihtunjangan = 0
            nipkrynlama = ""
            namakryn = ""
            npwp = ""

            do until mutasi.eof
            nip = mutasi("Kry_Nip")
            
                bulan = month(mutasi("Mut_tanggal"))
                tahun = year(mutasi("Mut_tanggal"))
                'bulan dan taun gaji 
                if bulan = 1 then
                    lbln = 12
                    lthn = tahun - 1
                else
                    lbln = bulan - 1
                    lthn = tahun 
                end if

            'cek asal demosi/mutasi
            mutasidari = mutasi("Mut_AsalAgenID")
            mutasike = mutasi("Mut_TujAgenID")
            jablama = mutasi("Mut_AsalJabCode")
            jabnow = mutasi("Mut_TujJabCode")


                    'area lama
                    mutasi_cmd.commandText = "SELECT agen_nama FROM GLB_M_agen WHERE Agen_ID = '"& mutasidari &"'"
                    ' Response.Write mutasi_cmd.commandText & "<br>"
                    set arealama = mutasi_cmd.execute

                    'area baru
                    mutasi_cmd.commandText = "SELECT agen_nama FROM GLB_M_agen WHERE Agen_ID = '"& mutasike &"'"
                    'Response.Write mutasi_cmd.commandText & "<br>"
                    set areabaru = mutasi_cmd.execute
                    
                    'jabatan lama 
                    mutasi_cmd.commandText = "SELECT Jab_nama FROM HRD_M_Jabatan WHERE Jab_Code = '"& jablama &"'"
                    set jabatanlama = mutasi_cmd.execute

                    'jabatan baru
                    mutasi_cmd.commandText = "SELECT Jab_nama FROM HRD_M_Jabatan WHERE Jab_Code = '"& jabnow &"'"
                    set jabatanbaru = mutasi_cmd.execute

                   'gaji lama
                    mutasi_cmd.commandText = "SELECT Sal_gapok, Sal_TunjJbt FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& mutasi("Kry_nip") &"' and Month(Sal_StartDate) = '"& lbln &"' AND Year(Sal_StartDate) = '"& lthn &"' AND Sal_AktifYN = 'Y' "
                    set gajilama = mutasi_cmd.execute

                    if not gajilama.eof then
                        gapok1 = gajilama("Sal_Gapok")
                        tunjangan1 = gajilama("Sal_TunjJbt")
                    end if

                    'gaji baru
                    mutasi_cmd.commandText = "SELECT Sal_nip, Sal_gapok, Sal_TunjJbt FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& mutasi("Kry_Nip") &"' and Month(Sal_StartDate) = '"& bulan &"' AND Year(Sal_StartDate) = '"& tahun &"' AND Sal_AktifYN = 'Y'"

                    set gajibaru = mutasi_cmd.execute

                    if not gajibaru.eof = true then
                        gapok = gajibaru("Sal_gapok")
                        tunjangan = gajibaru("Sal_TunjJbt")
                    end if

            '         'hitung selisih gaji lama dan baru
                    selisihgaji = gapok - gapok1
                    if selisihgaji < 0 then 
                        selisihgaji = 0
                    end if            

                    selisihtunjangan = tunjangan - tunjangan1
                    if selisihtunjangan < 0 then
                        selisihtunjangan = 0
                    end if
             %>
                <tr>
                    <td><%=monthName(month(mutasi("Mut_Tanggal")))%></td>
                    <td><%=i%></td>
                    <td><%= mutasi("Kry_Nip")%></td>
                    <td><%= mutasi("Kry_Nama")%></td>
                    <td><%= arealama("agen_Nama")%></td>
                    <td><%= areabaru("Agen_Nama")%></td>
                    <td><%= jabatanlama("Jab_Nama")%></td>
                    <td><%= jabatanbaru("Jab_Nama")%></td>
                    <td><%= Replace(formatCurrency(gapok1),"$","")%></td>
                    <td><%= Replace(formatCurrency(tunjangan1),"$","")%></td>
                    <td><%= Replace(formatCurrency(gapok),"$","")%></td>
                    <td><%= Replace(formatCurrency(tunjangan),"$","")%></td>
                    <td><%= Replace(formatCurrency(selisihgaji),"$","")%></td>
                    <td><%= Replace(formatCurrency(selisihtunjangan),"$","")%></td>
                    <td><%= mutasi("Kry_NPWP")%></td>
                </tr>
            <% 
            mutasi.movenext
            i = i + 1
            loop
             %>
            </tbody>
        </table>
    </div>
</div>

<!-- #include file='../layout/footer.asp' -->
