<!-- #include file='../connection.asp' -->
<!-- #include file='../constend/constanta.asp' -->
<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
    response.Redirect("../login.asp")
end if

dim cuti
dim bulan, tahun, tgl, pdate, urut
dim area

tgla = Request.Form("tgla")
tgle = Request.form("tgle")

bulan = month(tgla)
tahun = year(tgla)
laparea = request.form("laparea")

if isNull(bulan) = true or len(bulan) < 1 then
	bulan = month(date)
end if
if isNull(tahun) = true or len(tahun) < 1 then
	tahun = year(date)
end if


filterTanggal = " and ICS_StartDate between '"& tgla & " 00:00:00"  &"' and '"& tgle & " 23:59:00" &"'"

set area_cmd = Server.CreateObject("ADODB.Command")
area_cmd.activeConnection = MM_Cargo_String

set cuti_cmd = Server.CreateObject("ADODB.Command")
cuti_cmd.activeConnection = MM_Cargo_String

if laparea = "" then
    area_cmd.commandText = "SELECT dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID FROM dbo.HRD_T_IzinCutiSakit LEFT OUTER JOIN dbo.HRD_M_Karyawan ON dbo.HRD_T_IzinCutiSakit.ICS_NIP = dbo.HRD_M_Karyawan.Kry_NIP LEFT OUTER JOIN dbo.GLB_M_Agen ON dbo.HRD_M_Karyawan.Kry_AgenID = dbo.GLB_M_Agen.Agen_ID WHERE (dbo.HRD_M_Karyawan.Kry_AktifYN = 'Y') AND (dbo.GLB_M_Agen.Agen_Nama <> '') AND (dbo.HRD_T_IzinCutiSakit.ICS_StartDate between '"& tgla & " 00:00:00"  &"' and '"& tgle & " 23:59:00" &"') GROUP BY dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID ORDER BY dbo.GLB_M_Agen.Agen_Nama"
    set agen = area_cmd.execute
else
    area_cmd.commandText = "SELECT dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID FROM dbo.HRD_T_IzinCutiSakit LEFT OUTER JOIN dbo.HRD_M_Karyawan ON dbo.HRD_T_IzinCutiSakit.ICS_NIP = dbo.HRD_M_Karyawan.Kry_NIP LEFT OUTER JOIN dbo.GLB_M_Agen ON dbo.HRD_M_Karyawan.Kry_AgenID = dbo.GLB_M_Agen.Agen_ID WHERE (dbo.HRD_M_Karyawan.Kry_AktifYN = 'Y') AND (dbo.GLB_M_Agen.Agen_Nama <> '') AND (dbo.GLB_M_Agen.Agen_ID = "& laparea &") AND (dbo.HRD_T_IzinCutiSakit.ICS_StartDate between '"& tgla & " 00:00:00"  &"' and '"& tgle & " 23:59:00" &"') GROUP BY dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_ID ORDER BY dbo.GLB_M_Agen.Agen_Nama"
    ' Response.Write area_cmd.commandText
    set agen = area_cmd.execute
end if

 %>
 <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN CUTI</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
        .header ul{
            /* margin:0; */
            padding:0;
            list-style:none;
        }
        .table{
            display:block;
            white-space: nowrap;
            font-size:15px;
            overflow: auto;
        }
    </style>
</head>

<body>
<div class='container'>
    <!-- header -->
    <div class='row'>
        <div class='col header'>
            <ul>
                <li>PT DAKOTA BUANA SEMESTA</li>
                <li>JL.WIBAWA MUKTI II NO 8 JATIASIH BEKASI</li>
                <li>BEKASI</li>
            </ul>
        </div>
    </div>
    <div class='row'>
        <div class='col-sm mb-3 text-center'>
            <h4>IZIN, CUTI, SAKIT DAN ALPA</h4>
			<h5>Periode <%= day(tgla) & " " & monthName(month(tgla))%> - <%= day(tgle) & " " & monthName(month(tgle)) & " " & tahun%></h5>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <p>tanggal Cetak :<%= date() %></p>
        </div>
        <div class='col'>
            <div class='d-flex flex-row-reverse'>
                <div class="btn-group" role="group" aria-label="Basic outlined example">
                    <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-laporancuti.asp?bulan=<%=tgla%>&tahun=<%=tgle%>&laparea=<%= laparea %>')">EXPORT</button>
                </div>
                <div class="btn-group" role="group" aria-label="Basic outlined example">
                    <button type="button" class="btn btn-outline-danger btn-sm" onClick="window.location.href='index.asp'">Kembali</button>
                </div>
            </div>
        </div>
    </div>
    <!-- endheader -->
    <table class="table table-striped">
        <tr>
            <TH>
                No.
            </TH>
            <TH>
                Nomor
            </TH>
            <TH>
                Status
            </TH>
            <TH>
                Priode Tgl
            </TH>
            <TH>
                Keterangan
            </TH>
            <TH>
                Jumlah Cuti
            </TH>
            <TH>
                Jml Hari
            </TH>
            <TH>
                Pot.Gaji
            </TH>
            <TH>
                Pot.Cuti
            </TH>
            <TH>
                Sisa Cuti
            </TH>
            <TH>
                Form
            </TH>
            <TH>
                Surat Dokter
            </TH>
        </tr>
        <% 
        if laparea <> "" then
         %>
        <tr>
            <td colspan="12">
                <%= agen("Agen_Nama") %>
            </td>
        </tr>
        <%
        area_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama FROM HRD_M_Karyawan left outer JOIN HRD_T_IzinCutiSakit ON HRD_M_Karyawan.Kry_Nip = HRD_T_IzinCutiSakit.ICS_Nip WHERE ICS_AktifYN = 'Y' "& filterTanggal & " AND HRD_M_Karyawan.Kry_AgenID = '"& agen("Agen_ID") &"' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' GROUP BY HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama ORDER BY HRD_M_karyawan.kry_nama ASC"
        ' Response.Write area_cmd.commandText & "<br>"
        set area = area_cmd.execute
        urut = 0
        do until area.eof 
            urut = urut + 1

            cuti_cmd.commandText = "SELECT dbo.HRD_T_IzinCutiSakit.ICS_ID, dbo.HRD_T_IzinCutiSakit.ICS_NIP, dbo.HRD_T_IzinCutiSakit.ICS_StartDate, dbo.HRD_T_IzinCutiSakit.ICS_EndDate, dbo.HRD_T_IzinCutiSakit.ICS_Status, dbo.HRD_T_IzinCutiSakit.ICS_Keterangan, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, dbo.HRD_M_Karyawan.Kry_JmlCuti, dbo.HRD_T_IzinCutiSakit.ICS_PotongCuti,dbo.HRD_T_IzinCutiSakit.ICS_PotongGaji, HRD_T_IzinCutiSakit.ICS_obat, HRD_T_IzinCutiSakit.ICS_FormYN, HRD_T_IzinCutiSakit.ICS_SuratDokterYN FROM dbo.HRD_T_IzinCutiSakit LEFT OUTER JOIN dbo.HRD_M_Karyawan ON dbo.HRD_T_IzinCutiSakit.ICS_NIP = dbo.HRD_M_Karyawan.Kry_NIP WHERE(dbo.HRD_T_IzinCutiSakit.ICS_Nip = '"& area("Kry_Nip") &"') " & filterTanggal &" AND Kry_AgenID = '"& agen("Agen_ID") &"' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' GROUP BY dbo.HRD_T_IzinCutiSakit.ICS_ID, dbo.HRD_T_IzinCutiSakit.ICS_NIP, dbo.HRD_T_IzinCutiSakit.ICS_StartDate, dbo.HRD_T_IzinCutiSakit.ICS_EndDate, dbo.HRD_T_IzinCutiSakit.ICS_Status, dbo.HRD_T_IzinCutiSakit.ICS_Keterangan, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, dbo.HRD_M_Karyawan.Kry_JmlCuti, dbo.HRD_T_IzinCutiSakit.ICS_PotongCuti,dbo.HRD_T_IzinCutiSakit.ICS_PotongGaji, HRD_T_IzinCutiSakit.ICS_obat,HRD_T_IzinCutiSakit.ICS_FormYN, HRD_T_IzinCutiSakit.ICS_SuratDokterYN ORDER BY dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_IzinCutiSakit.ICS_StartDate"
            ' response.write cuti_cmd.commandText & "<BR>"
			set result = cuti_cmd.execute
        %>

        <tr>
            <td>
                <%= urut %>
            </td>
            <td colspan="10">  
                Nama Karyawan : <%= area("Kry_Nama")  %> <b> [<%= area("kry_nip")%>] </b>
            </td>  
            <td>  
                <% 
                jcuti = 0
                jobat = 0
                status = ""
                potgaji = ""
                potcuti = ""
                svalcuti = 0
                do until result.eof 
                'cek status shift
                if result("ICS_Status") = "A" then
                    status = "Alpa"
                elseIf result("ICS_Status") = "I" then 
                    status = "Izin"
                elseIf result("ICS_Status") = "C" then 
                    status = "Cuti"
                elseIf result("ICS_Status") = "D" then
                    status = "Alpa"
                elseIf result("ICS_Status") = "G" then 
                    status = "Dispensasi"
                elseIf result("ICS_Status") = "B" then
                    status = "Cuti Bersama"
                elseIf result("ICS_Status") = "S" then
                    status = "Sakit"
                else
                    status = "Klaim Pengobatan" 
                end if
                
                'cek interval hari cuti
                interval = dateDiff("d",result("ICS_StartDate"),result("ICS_EndDate") ) + 1
                'hitung jumlah hari cuti
                jcuti = jcuti + interval
                jobat = jobat + result("ICS_obat")

                'cek ngambil potong cuti apa gaji 
                if result("ICS_PotongGaji") = "Y" then
                    potgaji = "Ya"
                    valgaji = interval
                else
                    potgaji = "Tidak"
                    valgaji = 0
                end if

                if result("ICS_PotongCuti") = "Y" then
                    potcuti = "Ya"
                    valcuti = interval
                else
                    potcuti = "Tidak"
                    valcuti = 0
                end if


				if ucase(result("ICS_FormYN")) = "Y" then
					formYN = "Ya"
				else
					formYN = "Tidak"
				end if

                svalcuti = svalcuti + int(valcuti)
                %>  
                <tr> 
                    <td></td>
                    <td>
                        <%= result("ICS_ID") %>
                    </td>
                    <td>
                        <%= status %>
                    </td>
                    <td>
                        <%= result("ICS_StartDate") %> - <%= result("ICS_EndDate") %>
                    </td>
                    <td>
                        <%= result("ICS_Keterangan") %>
                    </td>
                    <td>
                    </td>
                    <td>
                        <%= interval %>
                    </td>
                    <td>
                        <%= valgaji %>
                    </td>
                    <td>
                        <%= valcuti %>
                    </td>
                    <td>
						
                    </td>
						
                    <td>	
						<%=formYN%>
                    </td>
                    <td><%
						if len(result("ICS_SuratDokterYN")) = 0 or isNull(result("ICS_SuratDokterYN")) = true then %>
					Tidak Ada
				<%else%>
					<a href="../suratDokter/<%=result("ICS_SuratDokterYN")%>.jpg">Ada (Klik Detail)</a>
				<%end if%>
                    </td>
                <% 
                Response.flush
                result.movenext
                loop
                result.movefirst
                'set sisa cuti yang tersedia
                sisacuti = int(result("Kry_JmlCuti")) - int(svalcuti)
                %>
                    <tr>
                        <td></td>
                        <td colspan="4">Sub Total</td>
                        <td><%= result("Kry_JmlCuti") %></td>
                        <td><%= jcuti %></td>
                        <td></td>
                        <td></td>
                        <td><%= sisacuti %></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tr>
            </td>
        </tr>
        <% 
            Response.Flush
            area.movenext
            loop 
        else

        do until agen.eof
         %>
        <tr>
            <td  colspan="12">
                <%= agen("Agen_Nama") %>
            </td>
        </tr>
        <%
        area_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama FROM HRD_M_Karyawan left outer JOIN HRD_T_IzinCutiSakit ON HRD_M_Karyawan.Kry_Nip = HRD_T_IzinCutiSakit.ICS_Nip WHERE HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' "& filterTanggal & " AND HRD_M_Karyawan.Kry_AgenID = '"& agen("Agen_ID") &"' AND HRD_M_karyawan.Kry_AktifYN = 'Y' GROUP BY HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama ORDER BY HRD_M_Karyawan.Kry_nama ASC"
        'Response.Write area_cmd.commandText
        set area = area_cmd.execute
        urut = 0
        do until area.eof 
            urut = urut + 1

            cuti_cmd.commandText = "SELECT dbo.HRD_T_IzinCutiSakit.ICS_ID, dbo.HRD_T_IzinCutiSakit.ICS_NIP, dbo.HRD_T_IzinCutiSakit.ICS_StartDate, dbo.HRD_T_IzinCutiSakit.ICS_EndDate, dbo.HRD_T_IzinCutiSakit.ICS_Status, dbo.HRD_T_IzinCutiSakit.ICS_Keterangan, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, dbo.HRD_M_Karyawan.Kry_JmlCuti, dbo.HRD_T_IzinCutiSakit.ICS_PotongCuti,dbo.HRD_T_IzinCutiSakit.ICS_PotongGaji, HRD_T_IzinCutiSakit.ICS_obat, HRD_T_IzinCutiSakit.ICS_FormYN, HRD_T_IzinCutiSakit.ICS_SuratDokterYN FROM dbo.HRD_T_IzinCutiSakit LEFT OUTER JOIN dbo.HRD_M_Karyawan ON dbo.HRD_T_IzinCutiSakit.ICS_NIP = dbo.HRD_M_Karyawan.Kry_NIP WHERE(dbo.HRD_T_IzinCutiSakit.ICS_Nip = '"& area("Kry_Nip") &"') " & filterTanggal &" AND Kry_AgenID = '"& agen("Agen_ID") &"' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' GROUP BY dbo.HRD_T_IzinCutiSakit.ICS_ID, dbo.HRD_T_IzinCutiSakit.ICS_NIP, dbo.HRD_T_IzinCutiSakit.ICS_StartDate, dbo.HRD_T_IzinCutiSakit.ICS_EndDate, dbo.HRD_T_IzinCutiSakit.ICS_Status, dbo.HRD_T_IzinCutiSakit.ICS_Keterangan, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, dbo.HRD_M_Karyawan.Kry_JmlCuti, dbo.HRD_T_IzinCutiSakit.ICS_PotongCuti,dbo.HRD_T_IzinCutiSakit.ICS_PotongGaji, HRD_T_IzinCutiSakit.ICS_obat,HRD_T_IzinCutiSakit.ICS_FormYN, HRD_T_IzinCutiSakit.ICS_SuratDokterYN ORDER BY dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_IzinCutiSakit.ICS_StartDate"
            'response.write cuti_cmd.commandText & "<BR>"
			set result = cuti_cmd.execute
        %>

        <tr>
            <td>
                <%= urut %>
            </td>
            <td colspan="10">  
                Nama Karyawan : <%= area("Kry_Nama")  %> <b> [<%= area("kry_nip")%>] </b>
            </td>  
            <td>  
                <% 
                jcuti = 0
                jobat = 0
                status = ""
                potgaji = ""
                potcuti = ""
                svalcuti = 0
                do until result.eof 
                'cek status shift
                if result("ICS_Status") = "A" then
                    status = "Alpa"
                elseIf result("ICS_Status") = "I" then 
                    status = "Izin"
                elseIf result("ICS_Status") = "C" then 
                    status = "Cuti"
                elseIf result("ICS_Status") = "D" then
                    status = "Alpa"
                elseIf result("ICS_Status") = "G" then 
                    status = "Dispensasi"
                elseIf result("ICS_Status") = "B" then
                    status = "Cuti Bersama"
                elseIf result("ICS_Status") = "S" then
                    status = "Sakit"
                else
                    status = "Klaim Pengobatan" 
                end if
                
                'cek interval hari cuti
                interval = dateDiff("d",result("ICS_StartDate"),result("ICS_EndDate") ) + 1
                'hitung jumlah hari cuti
                jcuti = jcuti + interval
                jobat = jobat + result("ICS_obat")

                'cek ngambil potong cuti apa gaji 
                if result("ICS_PotongGaji") = "Y" then
                    potgaji = "Ya"
                    valgaji = interval
                else
                    potgaji = "Tidak"
                    valgaji = 0
                end if

                if result("ICS_PotongCuti") = "Y" then
                    potcuti = "Ya"
                    valcuti = interval
                else
                    potcuti = "Tidak"
                    valcuti = 0
                end if
				
				if ucase(result("ICS_FormYN")) = "Y" then
					formYN = "Ya"
				else
					formYN = "Tidak"
				end if

                svalcuti = svalcuti + int(valcuti)
                %>  
                <tr> 
                    <td></td>
                    <td>
                        <%= result("ICS_ID") %>
                    </td>
                    <td>
                        <%= status %>
                    </td>
                    <td>
                        <%= result("ICS_StartDate") %> - <%= result("ICS_EndDate") %>
                    </td>
                    <td>
                        <%= result("ICS_Keterangan") %>
                    </td>
                    <td>
                    </td>
                    <td>
                        <%= interval %>
                    </td>
                    <td>
                        <%= valgaji %>
                    </td>
                    <td>
                        <%= valcuti %>
                    </td>
                    <td>
						
                    </td>
						
                    <td>	
						<%=formYN%>
                    </td>
                    <td><%
						if len(result("ICS_SuratDokterYN")) = 0 or isNull(result("ICS_SuratDokterYN")) = true then %>
					        Tidak Ada
                        <%else%>
                            <a href="../suratDokter/<%=result("ICS_SuratDokterYN")%>.jpg">Ada (Klik Detail)</a>
                        <%end if%>
                    </td>
                <% 
                Response.flush
                result.movenext
                loop
                result.movefirst
                'set sisa cuti yang tersedia
                sisacuti = Int(result("Kry_JmlCuti")) - int(svalcuti)
                %>
                    <tr>
                        <td></td>
                        <td colspan="4">Sub Total</td>
                        <td><%= result("Kry_JmlCuti") %></td>
                        <td><%= jcuti %></td>
                        <td></td>
                        <td></td>
                        <td><%= sisacuti %></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tr>
            </td>
        </tr>
        <% 
            Response.Flush
            area.movenext
            loop
        Response.Flush
        agen.movenext
        loop 
        end if  
         %>
    </table>
</div>


<!-- #include file='../layout/footer.asp' -->