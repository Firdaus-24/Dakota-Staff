<%@ Language=VBScript %>
<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Karyawan Promorsi "& Request.QueryString("tgla") &" sampai "& Request.QueryString("tgle") &".xls"
%>

<!-- #include file="../connection.asp"-->
    <title>Laporan</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>
<% 
dim laporan, urut, area, pegawai, status, bulan, tahun
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

'cek order by
if urut = "nama" then
    orderby = "ORDER BY HRD_M_Karyawan.Kry_nama"
elseIf urut = "nip" then
    orderby = "ORDER BY HRD_M_Karyawan.Kry_Nip"
else 
    orderby = "ORDER BY HRD_M_Karyawan.Kry_nama"
end if 

'mutasi
set mutasi_cmd = Server.CreateObject("ADODB.Command")
mutasi_cmd.ActiveConnection = MM_Cargo_string

'mutasi query
mutasi_cmd.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_NPWP, (GLB_M_Agen.Agen_Nama) AS arealama, (HRD_M_jabatan.Jab_Nama) AS jablama FROM HRD_T_Mutasi INNER JOIN HRD_M_Karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip LEFT OUTER JOIN GLB_M_agen ON HRD_T_Mutasi.Mut_AsalAgenID = GLB_M_agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_T_Mutasi.Mut_AsalJabCode = HRD_M_Jabatan.Jab_Code WHERE HRD_T_Mutasi.Mut_AktifYN = 'Y' AND HRD_T_Mutasi.Mut_Tanggal BETWEEN '"& tgla &"' AND '"& tgle &"' AND HRD_T_Mutasi.Mut_Status = '3' "& orderby &""
' Response.Write mutasi_cmd & "<br>"
set mutasi = mutasi_cmd.execute
      
%>
<div class='row'>
    <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
        <p>PT.Dakota Buana Semesta</p>
        <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
        <p>BEKASI</p>
    </div>
</div>
<div class='row'>
    <div class='col text-center judul'>
        <label class="text-center">DAFTAR KARYAWAN PROMORSI</label>
    </div>
</div>
<div class='row'>
    <div class='col col-sm' style="font-size: 10px;">
        <p>Tanggal Cetak <%= (Now) %></p>
    </div>
</div>
<div class='row'>
    <div class='col col-md' >
        <table class="table table-bordered text-center" style="font-size: 10px;">
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
                    <th rowspan="2">Keterangan</th>
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
            'cek data tanggungan karyawan
            data = 0 
            tanggungan = 0 
            anak = 0
            hasiltanggungan = 0

            gapok = 0
            tunjangan = 0
            gapok1 = 0
            tunjangan1 = 0
            selisihgaji = 0
            selisihtunjangan = 0

            i = 1 'for number asc
            do until mutasi.eof
            
            nip = mutasi("Mut_Nip")
            'cek asal demosi/mutasi
            mutasidari = mutasi("Mut_AsalAgenID")
            mutasike = mutasi("Mut_TujAgenID")
            jablama = mutasi("Mut_AsalJabCode")
            jabnow = mutasi("Mut_TujJabCode")

            'cek bulan gajian lama dengan yang baru
            bulan = month(mutasi("Mut_tanggal"))
            tahun = year(mutasi("Mut_Tanggal"))

                if bulan = 1 then
                    lbulan = 12
                    ltahun = tahun -1
                else
                    lbulan = bulan - 1
                    ltahun = tahun 
                end if

                    'area lama
                    mutasi_cmd.commandText = "SELECT agen_nama FROM GLB_M_agen WHERE Agen_ID = '"& mutasike &"'"
                    ' Response.Write mutasi_cmd.commandText & "<br>"
                    set areabaru = mutasi_cmd.execute

                    if areabaru.eof = false then
                        agenbaru = areabaru("agen_nama")
                    else 
                        agenbaru = ""
                    end if

                    'jabatan baru
                    mutasi_cmd.commandText = "SELECT Jab_nama FROM HRD_M_Jabatan WHERE Jab_Code = '"& jabnow &"'"
                    set jabatan = mutasi_cmd.execute

                    'gaji lama
                    mutasi_Cmd.commandText = "SELECT Sal_nip, Sal_gapok, Sal_TunjJbt FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& mutasi("Kry_nip") &"' and Month(Sal_StartDate) = '"& lbulan &"' AND Year(Sal_StartDate) = '"& ltahun &"' AND Sal_AktifYN = 'Y'"
                    set lsalary = mutasi_Cmd.execute

                    if not lsalary.eof then
                        gapok1 = lsalary("Sal_Gapok")
                        tunjangan1 = lsalary("Sal_TunjJbt")
                    end if

                    'gaji baru
                    mutasi_cmd.commandText = "SELECT Sal_nip, Sal_gapok, Sal_TunjJbt FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& mutasi("Kry_Nip") &"' and Month(Sal_StartDate) = '"& bulan &"' AND Year(Sal_StartDate) = '"& tahun &"' AND Sal_AktifYN = 'Y'"
                    set salary = mutasi_cmd.execute

                    if not salary.eof then
                        gapok = salary("Sal_gapok")
                        tunjangan = salary("Sal_TunjJbt")
                    end if

                    'hitung selisih gaji lama dan baru
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
                    <td><%=MonthName(month(mutasi("Mut_tanggal")))%></td>
                    <td><%=i%></td>
                    <td><%=mutasi("Kry_Nip")%></td>
                    <td><%=mutasi("Kry_Nama")%></td>
                    <td><%=mutasi("arealama")%></td>
                    <td><%=agenbaru%></td>
                    <td><%=mutasi("jablama")%></td>
                    <td><%=jabatan("Jab_Nama")%></td>
                    <td><%=gapok1%></td>
                    <td><%=tunjangan1%></td>
                    <td><%=gapok%></td>
                    <td><%=tunjangan%></td>
                    <td><%=selisihgaji%></td>
                    <td><%=selisihtunjangan%></td>
                    <td><%=mutasi("Kry_NPWP")%></td>
                    <td><%= mutasi("Mut_Memo") %></td>
                </tr>
            <% 
            Response.flush
            mutasi.movenext
            i = i + 1
            loop
             %>
            </tbody>
        </table>
    </div>
</div>
<!-- #include file='../layout/footer.asp' -->