<!-- #include file='../connection.asp' -->
<% 
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=LaporanKetidakHadiranKaryawan.xls"

    tgla = Request.querystring("tgla")
    tgle = Request.querystring("tgle")
    laparea = trim(Request.querystring("laparea"))
    lappegawai = trim(Request.querystring("lappegawai"))
    
    if tgla <> "" AND tgle <> "" then
        filterTgl = " AND HRD_T_IzinCutiSakit.ICS_StartDate BETWEEN '"& tgla &"' AND '"& tgle &"' AND HRD_T_IzinCutiSakit.ICS_EndDate BETWEEN '"& tgla &"' AND '"& tgle &"'"
    end if
    if laparea <> "" then
        filterArea = " AND HRD_M_Karyawan.Kry_activeAgenID = '"& laparea &"'"
    end if 
    if lappegawai <> "" then
        filterPegawai = " AND HRD_M_Karyawan.Kry_AgenID = '"& lappegawai &"'"
    end if

    set cuti_cmd = Server.CreateObject("ADODB.Command")
    cuti_cmd.ActiveConnection = MM_Cargo_string

    set potcuti = Server.CreateObject("ADODB.Command")
    potcuti.ActiveConnection = MM_Cargo_string

    set potgaji = Server.CreateObject("ADODB.Command")
    potgaji.ActiveConnection = MM_Cargo_string

    set detailcuti_cmd = Server.CreateObject("ADODB.Command")
    detailcuti_cmd.ActiveConnection = MM_Cargo_string

    detailcuti_cmd.commandText = "SELECT GLB_M_AGEN.Agen_Nama, GLB_M_Agen.Agen_id FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_T_IzinCutiSakit ON HRD_M_Karyawan.Kry_Nip = HRD_T_IzinCutiSakit.ICS_Nip WHERE HRD_M_karyawan.Kry_AktifYN = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' "&filterTgl&" "&filterArea&" "&filterPegawai&" AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND HRD_T_IzinCutiSakit.ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' GROUP BY GLB_M_AGEN.Agen_Nama, GLB_M_Agen.Agen_id ORDER BY GLB_M_Agen.Agen_Nama ASC"
    ' Response.Write detailcuti_cmd.CommandTExt & "<br>"
    set detailcuti = detailcuti_cmd.execute
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DETAIL CUTI</title>
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
    <table class="table" style="font-size:12px;">
        <tr style="text-align:center;">
            <td colspan="15">IZIN, CUTI, SAKIT DAN ALFA</td>
        </tr>
        <tr style="text-align:center;">
            <td colspan="15">PERIODE :<b><%= tgla & " S/D " & tgle %></b></td>
        </tr>
        <tr>
            <td colspan="15">Tanggal Cetak <%= (Now) %></td>
        </tr>
                    <tr>
                        <td>No</td>
                        <td>Nip</td>
                        <td>Nama</td>
                        <td>Tgl Masuk</td>
                        <td>Jatah Cuti</td>
                        <td>Cuti</td>
                        <td>Izin</td>
                        <td>Sakit</td>
                        <td>Alfa</td>
                        <td>Dispensasi</td>
                        <td>Cuti Bersama</td>
                        <td>Potong Cuti</td>
                        <td>Sisa Cuti</td>
                        <td>Potong Gaji</td>
                        <td>Biaya Obat</td>
                    </tr>
                    <% do while not detailcuti.eof %>
                        <tr>
                            <td>CABANG</td>
                            <td><%= detailcuti("Agen_Nama") %></td>
                        </tr>
                        <% 
                            cuti_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_TglMasuk,HRD_M_Karyawan.Kry_JmlCuti, HRD_T_IzinCutiSakit.ICS_Nip, HRD_T_IzinCutiSakit.ICS_Obat,SUM(CASE WHEN HRD_T_IzinCutiSakit.ICS_Status = 'S' THEN DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1 ELSE 0 END) AS tsakit, SUM(CASE WHEN HRD_T_IzinCutiSakit.ICS_Status = 'C' THEN DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1 ELSE 0 END) AS tcuti, SUM(CASE WHEN HRD_T_IzinCutiSakit.ICS_Status = 'I' THEN DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1 ELSE 0 END) AS tizin, SUM(CASE WHEN HRD_T_IzinCutiSakit.ICS_Status = 'A' THEN DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1 ELSE 0 END) AS talfa, SUM(CASE WHEN HRD_T_IzinCutiSakit.ICS_Status = 'G' THEN DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1 ELSE 0 END) AS tdispen, SUM(CASE WHEN HRD_T_IzinCutiSakit.ICS_Status = 'B' THEN DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1 ELSE 0 END) AS tcutibersama FROM HRD_T_IzinCutiSakit LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_IzinCutiSakit.ICS_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_M_Karyawan.Kry_agenID = "&detailcuti("Agen_ID")&" "&filterTgl&" AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND HRD_T_IzinCutiSakit.ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' GROUP BY HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_TglMasuk, HRD_M_Karyawan.Kry_JmlCuti, HRD_T_IzinCutiSakit.ICS_Nip, HRD_T_IzinCutiSakit.ICS_Obat ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
                            ' Response.Write cuti_cmd.commandText & "<br>"
                            set cuti = cuti_cmd.execute
                            
                            nomor = 0
                            do while not cuti.eof
                            nomor = nomor + 1
                            
                                ' potong cuti
                                potcuti.commandText = "SELECT SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate) + 1) AS pcuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& cuti("ICS_nip") &"' "&filterTgl&" AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
                                ' Response.Write potcuti.commandText & "<br>"
                                set saldocuti = potcuti.execute

                                pcuti = 0
                                do while not saldocuti.eof 
                                    pcuti = pcuti + saldocuti("pcuti")
                                saldocuti.movenext
                                loop
                                
                                ' potong gaji
                                potgaji.commandText = "SELECT SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) + 1 AS pgaji FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& cuti("ICS_nip") &"' "&filterTgl&" AND HRD_T_IzinCutiSakit.ICS_PotongGaji <> '' AND HRD_T_IzinCutiSakit.ICS_Potonggaji = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
                                set saldogaji = potgaji.execute

                                pgaji = 0 
                                do while not saldogaji.eof
                                    pgaji = pgaji + saldogaji("pgaji")
                                saldogaji.movenext 
                                loop

                                ' saldo cuti
                                hsisacuti = cuti("Kry_jmlCuti") - pcuti
                        %>
                        
                        <tr>
                            <td><%= nomor %></td>
                            <td><%= cuti("Kry_Nip") %></td>
                            <td><%= cuti("Kry_nama") %></td>
                            <td><%= cuti("Kry_TglMasuk") %></td>
                            <td><%= cuti("Kry_JmlCuti") %></td>
                            <td><%= cuti("tcuti") %></td>
                            <td><%= cuti("tizin") %></td>
                            <td><%= cuti("tsakit") %></td>
                            <td><%= cuti("talfa") %></td>
                            <td><%= cuti("tdispen") %></td>
                            <td><%= cuti("tcutibersama") %></td>
                            <td><%= pcuti %></td>
                            <td><%= hsisacuti %></td>
                            <td><%= pgaji %></td>
                            <td><%= cuti("ICS_Obat") %></td>
                        </tr>
                    <% 
                            Response.FLush
                            cuti.movenext
                            loop

                        Response.FLush
                        detailcuti.movenext
                        loop
                    %>
            </table>
<!-- #include file='../layout/footer.asp' -->