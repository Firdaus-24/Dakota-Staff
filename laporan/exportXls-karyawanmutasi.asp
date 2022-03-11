<%@ Language=VBScript %>
<!-- #include file='../connection.asp' -->

<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Karyawan Mutasi"& Request.QueryString("bulan") &"/"& Request.QueryString("tahun") &".xls"

dim tgla, tgle
dim mutasi_cmd, mutasi
dim orderby

urut = Request.querystring("urut")
tgla = Request.querystring("tgla")
tgle = Request.querystring("tgle")

'mutasi
set mutasi_cmd = Server.CreateObject("ADODB.Command")
mutasi_cmd.ActiveConnection = MM_Cargo_string

'cek order by
if urut = "nama" then
    orderby = "ORDER BY Kry_nama"
elseIf urut = "nip" then
    orderby = "ORDER BY Kry_Nip"
else 
    orderby = "ORDER BY Kry_nama"
end if 

if bulan = 1 then
    lbln = 12
else
    lbln = bulan - 1
end if

mutasike = ""
mutasidari = ""
jablama = ""
jabnow = ""
nipkrynlama = ""
nipkrynbaru = ""
npwp = ""
            
'mutasi query
mutasi_cmd.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_Karyawan.Kry_Nama, HRD_M_karyawan.Kry_SttSosial, HRD_M_Karyawan.Kry_JmlTanggungan, HRD_M_karyawan.Kry_jmlanak, HRD_M_karyawan.Kry_NPWP, HRD_M_Karyawan.Kry_Sex FROM HRD_T_Mutasi LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_Mutasi.Mut_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_T_Mutasi.Mut_Status = '' and HRD_T_Mutasi.Mut_Tanggal BETWEEN '"& tgla &"' AND '"& tgle &"' "& orderby &""
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

<div class='row'>
    <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
        <p>PT.Dakota Buana Semesta</p>
        <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
        <p>BEKASI</p>
    </div>
</div>
<div class='row'>
    <div class='col text-center judul'>
        <label class="text-center"><b>DAFTAR KARYAWAN MUTASI</b></label>
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
        <table class="table table-bordered text-center" style="font-size: 12px;">
            <thead class="text-sm-center">
                <tr>
                    <th rowspan="2" scope="col">Bulan</th>
                    <th rowspan="2" scope="col">No</th>
                    <th rowspan="2" scope="col">Nip</th>
                    <th rowspan="2" scope="col">Nama</th>
                    <th rowspan="2" scope="col">Mutasi Dari</th>
                    <th rowspan="2" scope="col">Jabatan</th>
                    <th rowspan="2" scope="col">Mutasi Ke</th>
                    <th rowspan="2" scope="col">Jabatan</th>
                    <th colspan="2" scope="col">Gaji Lama</th>
                    <th colspan="2" scope="col">Gaji Baru</th>
                    <th colspan="2" scope="col">Selisih Perubahan</th>
                    <th rowspan="2" scope="col">Kekurangan Upah Rapel</th>
                    <th rowspan="2" scope="col">NPWP</th>
                    <th rowspan="2" scope="col">Status</th>
                    <th rowspan="2" scope="col">Keterangan</th>
                </tr>
                <tr>
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
            nomor = 0
            ssosial = ""
            blnl = ""
            gapokl = 0
            tunjl = 0
            gapokn = 0
            tunjn = 0
            selisihgaji = 0
            selisihtunj = 0
            data = ""
            tanggungan = 0
            anak = 0
            do until mutasi.eof
            nomor = nomor + 1

            'cek priode untuk bulan gaji sebelum di mutasi
            blnl = month(mutasi("Mut_Tanggal")) - 1
            thnl = year(mutasi("Mut_tanggal"))

            if blnl <= 0 then
                blnl = 12
                thnl = thnl - 1
            end if
           
            'agen lama
            mutasi_cmd.commandText = "SELECT Agen_Nama FROM GLB_M_Agen WHERE Agen_ID = '"& mutasi("Mut_AsalagenID") &"' AND Agen_AktifYN = 'Y'"
            set agenlama = mutasi_cmd.execute

            'agen baru 
            mutasi_cmd.commandText = "SELECT Agen_Nama FROM GLB_M_Agen WHERE Agen_ID = '"& mutasi("Mut_TujAgenID") &"' AND Agen_AktifYN = 'Y'"
            set agenbaru = mutasi_cmd.execute

            'jabatanlama
            mutasi_cmd.commandText = "SELECT Jab_Nama FROM HRD_M_jabatan WHERE Jab_Code = '"& mutasi("Mut_AsalJabCode") &"' AND Jab_AktifYN = 'Y'"
            set jabatanlama = mutasi_cmd.execute
            
            if not jabatanlama.eof then 
                ljabatan = jabatanlama("Jab_Nama")
            else
                ljabatan = ""
            end if

             'jabatanbaru
            mutasi_cmd.commandText = "SELECT Jab_Nama FROM HRD_M_jabatan WHERE Jab_Code = '"& mutasi("Mut_TujJabCode") &"' AND Jab_AktifYN = 'Y'"
            set jabatanbaru = mutasi_cmd.execute

            if not jabatanbaru.eof then 
                njabatan = jabatanbaru("Jab_Nama")
            else
                njabatan = ""
            end if

            'gajilama
            mutasi_cmd.commandText = "SELECT Sal_gapok, Sal_TunJJbt FROM HRD_T_Salary_Convert WHERE Month(Sal_StartDate) = '"& blnl &"' AND year(Sal_StartDate) = '"& thnl &"' AND Sal_AktifYN = 'Y' AND Sal_Nip = '"& mutasi("Mut_Nip") &"'"

            set gajilama = mutasi_cmd.execute

            if not gajilama.eof then    
                gapokl = gajilama("Sal_Gapok")
                tunjl = gajilama("Sal_TunjJbt")
            end if
            
            'gaji baru
            mutasi_cmd.commandText = "SELECT Sal_gapok, Sal_TunJJbt FROM HRD_T_Salary_Convert WHERE Month(Sal_StartDate) = '"& month(mutasi("Mut_Tanggal")) &"' AND year(Sal_StartDate) = '"& year(mutasi("Mut_Tanggal")) &"' AND Sal_AktifYN = 'Y' AND Sal_Nip = '"& mutasi("Mut_Nip") &"'"

            set gajibaru = mutasi_cmd.execute

            if not gajibaru.eof then    
                gapokn = gajibaru("Sal_Gapok")
                tunjn = gajibaru("Sal_TunjJbt")
            end if

            'cek selisih gaji lama dengan yang baru 
            selisihgaji = gapokn - gapokl
            if selisihgaji < 0 then 
                selisihgaji = 0
            end if            

            selisihtunjangan = tunjn - tunjl
            if selisihtunjangan < 0 then
                selisihtunjangan = 0
            end if

            'cek status karyawan
            data = mutasi("Kry_Sttsosial")
            tanggungan = mutasi("Kry_JmlTanggungan")
            anak = mutasi("Kry_jmlanak")
            kelamin = mutasi("Kry_Sex")
            
            ' cek hasil tanggungan 
            hasiltanggungan = tanggungan + anak
            if kelamin = "W" then
                hasilstatus = "TK"
            else
                if data = 0 then
                    if hasiltanggungan = 0 OR hasiltanggungan > 0 then
                        hasilstatus = "TK"
                    end if
                elseIf data = 1 then
                    if hasiltanggungan = 0 OR hasiltanggungan > 0 then
                        hasilstatus = "K"
                    end if
                else    
                    if hasiltanggungan = 0 OR hasiltanggungan > 0 then
                        hasilstatus = "HB"
                    end if
                end if
            end if
             %>
                <tr>
                    <td><%=MonthName(month(mutasi("mut_tanggal")))%></td>
                    <td><%=nomor%></td>
                    <td style="mso-number-format:\@;"><%=mutasi("Mut_Nip")%></td>
                    <td><%=mutasi("Kry_Nama")%></td>
                    <td><%=agenlama("agen_Nama")%></td>
                    <td><%=ljabatan%></td>
                    <td><%=agenbaru("agen_nama")%></td>
                    <td><%=njabatan%></td>
                    <td><%=cdbl(gapokl)%></td>
                    <td><%=cdbl(tunjl)%></td>
                    <td><%=cdbl(gapokn)%></td>
                    <td><%=cdbl(tunjn)%></td>
                    <td><%=cdbl(selisihgaji)%></td>
                    <td><%=cdbl(selisihtunjangan)%></td>
                    <td></td>
                    <td><%=mutasi("Kry_NPWP")%></td>
                    <td><%= hasilstatus %></td>
                    <td></td>
                </tr>
            <% 
            Response.Flush
            mutasi.movenext
            i = i + 1
            loop
             %>
            </tbody>
        </table>
    </div>
</div>

<!-- #include file='../layout/footer.asp' -->
