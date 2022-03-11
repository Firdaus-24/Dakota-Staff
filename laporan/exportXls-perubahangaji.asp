<%@ Language=VBScript %>
<!-- #include file="../connection.asp"-->
<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Perubahan Gaji"& Request.QueryString("bulan") &"/"& Request.QueryString("tahun") &".xls"

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

bulan = month(tgla)
tahun = year(tgla)

'karyawan
set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_Cargo_string

karyawan_cmd.commandText = "SELECT Sal_Nip, Sal_StartDate, HRD_M_Karyawan.Kry_Nama,Sal_gapok,sal_tunjJbt, GLB_M_agen.Agen_Nama, HRD_M_Jabatan.Jab_Nama, HRD_M_Divisi.Div_Nama FROM HRD_T_Salary_Convert AS a INNER JOIN HRD_M_Karyawan ON a.Sal_Nip = HRD_M_Karyawan.Kry_Nip LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE a.Sal_Gapok <> (SELECT TOP 1 Sal_Gapok FROM HRD_T_salary_Convert AS b WHERE b.Sal_startDate < a.Sal_StartDate AND year(b.Sal_StartDate) = '"& tahun &"' AND Month(b.sal_startDate) = month(a.sal_startDate) ORDER BY b.Sal_StartDate DESC) AND year(a.Sal_StartDate) = '"& tahun &"' AND HRD_M_KAryawan.Kry_AktifYN = 'Y' GROUP BY Sal_Nip, Sal_StartDate, HRD_M_Karyawan.Kry_Nama,Sal_gapok,sal_tunjJbt, GLB_M_agen.Agen_Nama, HRD_M_Jabatan.Jab_Nama, HRD_M_Divisi.Div_Nama "& orderby &""
' Response.Write karyawan_cmd.commandText & "<br>"
set karyawan = karyawan_cmd.execute
      
%>
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
            <label class="text-center"><b>DAFTAR KARYAWAN PERUBAHAN GAJI</b></label>
        </div>
    </div>
    <div class="row text-center">
        <div class='col'>
            <label>Priode : <%= cdate(tgla) %></label>
        </div>
    </div>
    <div class='row'>
        <div class='col col-sm' style="font-size: 10px;">
            <p>Tanggal Cetak <%= (Now) %></p>
        </div>
    </div>
    <div class='row'>
        <div class='col col-md' >
        <table class="table table-bordered text-center" style="font-size: 12px;" >
            <thead>
                <tr class="center">
                    <th rowspan="2" scope="col">Bulan</th>
                    <th rowspan="2" scope="col">No</th>
                    <th rowspan="2" scope="col">Cabang</th>
                    <th rowspan="2" scope="col">Nip</th>
                    <th rowspan="2" scope="col">Nama</th>
                    <th rowspan="2" scope="col">Jabatan</th>
                    <th rowspan="2" scope="col">Divisi</th>
                    <th colspan="2" scope="col">Upah Lama</th>
                    <th colspan="2" scope="col">Upah Baru</th>
                    <th colspan="2" scope="col">Selisih Perubahan</th>
                    <th rowspan="2" scope="col">RAPEL</th>
                    <th rowspan="2" scope="col">KETERANGAN</th>
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
            n = 0
            do while not karyawan.eof 
            n = n + 1

            pbulan = month(karyawan("Sal_startDate"))
            ptahun = year(karyawan("Sal_startDate"))
            'tentukan bulan lalu
            dim lbln, lthn
            if pbulan = 1 then
                lbln = 12
                lthn = ptahun - 1
            else
                lbln = pbulan - 1
                lthn = ptahun
            end if

            'set gapok 1 bulan sebelmnya
            karyawan_cmd.commandText = "SELECT Sal_gapok, Sal_TunjJbt FROM HRD_T_salary_Convert WHERE Sal_Nip = '"& karyawan("Sal_Nip") &"' AND Month(Sal_StartDate) = '"& lbln &"' AND Year(SaL_startDate) = '"& lthn &"' AND Sal_AktifYN = 'Y'"

            set lgaji = karyawan_cmd.execute

            if not lgaji.eof then
                gapok = lgaji("SAl_Gapok")
                tunjangan = lgaji("Sal_TunjJbt")
            else
                gapok = 0
                tunjangan = 0
            end if

            'cek jika datanya sama dengan bulan lalu dengan bulan yang di filter 
            if gapok = karyawan("Sal_gapok") Or gapok = 0 then

                if pbulan = 1 then
                    lbln = 11
                    lthn = ptahun - 1
                else
                    lbln = pbulan - 2
                    lthn = ptahun
                end if

                karyawan_cmd.commandText = "SELECT Sal_gapok, Sal_TunjJbt FROM HRD_T_salary_Convert WHERE Sal_Nip = '"& karyawan("Sal_Nip") &"' AND Month(Sal_StartDate) = '"& lbln &"' AND Year(SaL_startDate) = '"& lthn &"' AND Sal_AktifYN = 'Y'"

                set lngaji = karyawan_cmd.execute

                if not lngaji.eof then
                    gapok = lngaji("SAl_Gapok")
                    tunjangan = lngaji("Sal_TunjJbt")
                else
                    gapok = 0
                    tunjangan = 0
                end if
            end if

            selisihgapok = karyawan("Sal_Gapok") - gapok
            selisihtunjangan = karyawan("Sal_tunjJbt") - tunjangan
            %>
                <tr>
                    <td><%= MonthName(month(karyawan("Sal_StartDate"))) %></td>
                    <td><%= n %></td>
                    <td><%= karyawan("Agen_Nama") %></td>
                    <td  style="mso-number-format:\@;"><%= karyawan("Sal_Nip") %></td>
                    <td><%= karyawan("Kry_Nama") %></td>
                    <td><%= karyawan("Jab_Nama") %></td>
                    <td><%= karyawan("Div_Nama") %></td>
                    <td><%= replace(formatCurrency(cdbl(gapok)),"$","") %></td>
                    <td><%= replace(formatCurrency(cdbl(tunjangan)),"$","") %></td>
                    <td><%= replace(formatCurrency(cdbl(karyawan("sal_gapok"))),"$","") %></td>
                    <td><%= replace(formatCurrency(cdbl(karyawan("sal_tunjJbt"))),"$","") %></td>
                    <td><%= replace(formatCurrency(cdbl(selisihgapok)),"$","") %></td>
                    <td><%= replace(formatCurrency(cdbl(selisihtunjangan)),"$","") %></td>
                    <td></td>
                    <td></td>
                </tr>
            <% 
            response.flush
            karyawan.movenext
            loop
             %>
            </tbody>
        </table>
        </div>
    </div>
<!-- #include file='../layout/footer.asp' -->
