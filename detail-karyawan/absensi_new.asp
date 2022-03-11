<!-- #include file='../connection.asp' -->
<!-- #include file='../landing.asp' -->
<% 
if session("username") = "" then
response.Redirect("../login.asp")
end if

dim karyawanshift, wfh

nip = Request.QueryString("nip")
if nip = "" then
    nip = Request.Form("nip")
end if

tgla = Request.QueryString("tgla")
if tgla = "" then
    tgla = Request.Form("tgla")
end if

tgle = Request.QueryString("tgle")
if tgle = "" then
    tgle = Request.Form("tgle")
end if

set shift_cmd = Server.CreateObject("ADODB.COmmand")
shift_cmd.ActiveConnection = MM_Cargo_string

' label nama dan nip
shift_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE Kry_Nip = '"& nip &"'"
set karyawan = shift_cmd.execute

wfh = Cdate("3/7/2021")


if tgla <> "" AND tgle <> "" then

shift_cmd.commandText = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& nip &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"
' Response.Write shift_cmd.commandText & "<br>"
set karyawanshift = shift_cmd.execute

set connection = server.CreateObject("ADODB.Connection")
connection.open MM_cargo_STRING

dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter
dim nip, cabang, tgl, tgla, tgle, ketm, ketk, shiftm, shiftk, bedai, offset

orderBy =  " ORDER BY HRD_T_Shift.Shf_Tanggal ASC"

set rs = Server.CreateObject("ADODB.Recordset")

sqlAwal = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& nip &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"' "

sql=sqlawal + orderBy

rs.open sql, Connection

' records per halaman
recordsonpage = 10

' count all records
allrecords = 0
do until rs.EOF
  allrecords = allrecords + 1
  rs.movenext
loop


' if offset is zero then the first page will be loaded
offset = Request.QueryString("offset")
if offset = 0 OR offset = "" then
  requestrecords = 0
else
  requestrecords = requestrecords + offset
end if

rs.close

set rs = server.CreateObject("adodb.recordset")

sqlawal = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP ='"& nip &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"	

sql=sqlawal + orderBy

rs.open sql, Connection

' reads first records (offset) without showing them (can't find another solution!)
hiddenrecords = requestrecords
do until hiddenrecords = 0 OR rs.EOF
  hiddenrecords = hiddenrecords - 1
  rs.movenext
  if rs.EOF then
    lastrecord = 1
  end if	
loop
end if
 %>
 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Absensi</title>
    <!--#include file="../layout/header.asp"-->
    <style>
    table{
        font-size:14px;
    }
    </style>
</head>
<body>
<!-- #include file='template-detail.asp' -->
<div class='container'>
    <!--header -->
    <% if not karyawan.eof then %>
    <div class='row'>
        <label fpr="labelNip" class="col-sm-1 col-form-label">NIP</label>
        <div class='col-lg-3' >
            <input type='text' class='form-control' name='labelNip' id='labelNip' value="<%= nip %>" readonly>
        </div>
        <label fpr="labelNama" class="col-sm-1 col-form-label">NAMA</label>
        <div class='col-lg-3' >
            <input type='text' class='form-control' name='labelNama' id='labelNama' value="<%= karyawan("Kry_Nama") %>" readonly>
        </div>
        <label fpr="labelDivisi" class="col-sm-1 col-form-label">DIVISI</label>
        <div class='col-lg-3' >
            <input type='text' class='form-control' name='labelDivisi' id='labelDivisi' value="<%= karyawan("Div_Nama") %>" readonly>
        </div>
    </div>
    <% end if %>
    <!--endheader -->
    <!--form input tanggal -->
    <div class='row'>
        <div class='col'>
            <div class="form mb-2">
                <form action="absensi_new.asp?nip=<%= nip %>" method="post"  id="form-absensi" class="row g-3 mt-3 form-absensi"> 
                    <input type="hidden" class="form-control" name="nip" id="nip" value="<%= nip %>" required >
                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-floating">
                            <input type="date" class="form-control" name="tgla" id="tgla" required >
                            <label for="floatingInputGrid">Tanggal Awal</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                            <input type="date" class="form-control" name="tgle" id="tgle" required >
                            <label for="floatingSelectGrid">Sampai</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary mb-3" name="cari-absensi" id="cari-absensi" value="submit" onCLick="hide">CARI</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--end form -->

    <!--content -->
<% 
if tgla <> "" AND tgle <> "" then
    if not karyawanshift.eof then
%>
    <div class='row'>
        <div class='col-lg-12 overflow-scroll'>
            <table class="table table-hover" >
                <thead class="bg-secondary text-light text-center">
                    <tr>
                        <th scope="col">NIP</th>
                        <th scope="col">CABANG ABSEN</th>
                        <th scope="col">TANGGAL</th>
                        <th scope="col">ABSEN MASUK</th>
                        <th scope="col">ABSEN KELUAR</th>
                        <th scope="col">KETERANGAN MASUK</th>
                        <th scope="col">KETERANGAN KELUAR</th>
                        <th scope="col">MASUK SHIFT</th>
                        <th scope="col">KELUAR SHIFT</th>
                        <th scope="col">JAM KERJA</th>
                        <th scope="col">BEDA HARI</th>
                        <th scope="col">Longitude</th>
                        <th scope="col">Latitude</th>
                        <th scope="col">WFH/WFO</th>
                        <th scope="col">STATUS</th>
                    </tr>
                </thead>
                <% 
                    ketMasuk = 0
                    ketKeluar = 0
                    tabsenMasuk = 0
                    tabsenKeluar = 0
                    alfa = 0
                    showrecords = recordsonpage
					recordcounter = requestrecords
					do until showrecords = 0 OR  rs.EOF
					recordcounter = recordcounter + 1

                    'jam masuk dan keluar di absensi
                    shift_cmd.commandText = "SELECT top 1  HRD_T_Absensi.abs_datetime, GLB_M_Agen.Agen_Nama, HRD_T_Absensi.ABS_Lat, HRD_T_Absensi.ABS_Lon, HRD_T_Absensi.ABS_SyncToAdempiere FROM HRD_T_Absensi LEFT OUTER JOIN GLB_M_Agen ON HRD_T_Absensi.Abs_AgenId = GLB_M_Agen.Agen_ID where ABS_Nip = '"& rs("Kry_NIP") &"' and day(abs_datetime) = '"& day(rs("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(rs("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(rs("Shf_Tanggal")) &"'  order by abs_datetime ASC"
                    ' Response.Write shift_cmd.commandText & "<br>"
                    set jamMasuk = shift_cmd.execute

                    ShiftJamMasuk = right("00" & rs("Sh_JamIn"),2) & ":" & right("00" & rs("Sh_MenitIn") ,2)
                    
                    'jam keluar
                    shift_cmd.commandText = "SELECT TOP 1 ABS_Datetime, GLB_M_Agen.Agen_Nama, HRD_T_Absensi.ABS_Lat, HRD_T_Absensi.ABS_Lon FROM HRD_T_Absensi LEFT OUTER JOIN GLB_M_Agen ON HRD_T_Absensi.Abs_AgenID = GLB_M_Agen.Agen_ID where ABS_Nip = '"& rs("Kry_NIP") &"' and day(abs_datetime) = '"& day(rs("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(rs("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(rs("Shf_Tanggal")) &"'  order by abs_datetime DESC"

                    set jamKeluar = shift_cmd.execute

                    ShiftJamKeluar = right("00" & rs("Sh_JamOut"),2) & ":" & right("00" & rs("Sh_MenitOut") ,2)

                    'definisi jam masuk dan keluar jika sama kosongkan
                    if not jamMasuk.eof then
                        masuk = jamMasuk("Abs_datetime") 
                        longitude = jamMasuk("Abs_Lon")
                        'cek wfh dan wfo 
                    else
                        masuk = "TIDAK ABSEN"
                        longitude = "-"
                    end if 

                    if not jamKeluar.eof then 
                        keluar = jamKeluar("Abs_Datetime")
                        latitude = jamMasuk("Abs_Lat")
                    else
                        keluar = "TIDAK ABSEN"
                        latitude = "-"
                    end if 

                    'cek jika tidak absen masuk/pulang
                    if masuk = keluar then
                        masuk = "TIDAK ABSEN"
                    end if
                    
                    'cek absen di cabang mana masuk/pulang
                    if not jamMasuk.eof then
                        absenCabangMasuk = jamMasuk("Agen_Nama")
                    else
                        absenCabangMasuk = "-"
                    end if
                    
                    'cek waktu jam kerja
                    if masuk <> "TIDAK ABSEN" AND keluar <> "TIDAK ABSEN" then
                        jamKerja = dateDiff("h",formatDateTime(masuk),formatDateTime(keluar))
                    else
                        jamKerja = "-"
                    end if 

                    'cek wfh dan wfo
                    if wfh > 1 then
                        if longitude <> "-" And latitude <> "-" then
                            if not jamMasuk.eof then
                                if jamMasuk("ABS_SyncToAdempiere") = "H" then
                                    pwfh = "DILUAR KANTOR"
                                else
                                    pwfh = "DI KANTOR"
                                end if
                            end if
                        else
                            pwfh = "-"
                        end if
                    end if

                    'cek status karyawan absen sesuai dengan izincutisakit
                    if masuk = "TIDAK ABSEN" And keluar = "TIDAK ABSEN" And longitude = "-" And latitude = "-" then
                        shift_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.Ics_Status FROM HRD_T_IzinCutiSakit INNER JOIN HRD_M_Karyawan ON HRD_T_IzinCutiSakit.ICS_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND HRD_T_IzinCutiSakit.ICS_StartDate BETWEEN '"& rs("Shf_Tanggal") &"' AND '"& rs("Shf_Tanggal") &"' AND HRD_T_IzinCutiSakit.ICS_EndDate BETWEEN '"& rs("Shf_Tanggal") &"' AND '"& rs("Shf_Tanggal") &"' AND HRD_T_IzinCutiSakit.ICS_Nip = '"& rs("Kry_NIP") &"'" 

                        set status = shift_cmd.execute

                        if not status.eof then
                            if status("ics_status") = "A" then
                                icskaryawan = "ALFA"
                            elseIf status("ics_status") = "B" then
                                icskaryawan = "CUTI BERSAMA"
                            elseIf status("ics_status") = "C" then
                                icskaryawan = "CUTI"
                            elseIf status("ics_status") = "G" then
                                icskaryawan = "DISPENSASI"
                            elseIf status("ics_status") = "I" then
                                icskaryawan = "IZIN"
                            elseIf status("ics_status") = "K" then
                                icskaryawan = "KLAIM OBAT"
                            else
                                icskaryawan = "SAKIT"
                            end if
                        else
                            icskaryawan = "ALFA"
                        end if
                    else    
                        icskaryawan = "-"
                    end if
                        
                %>
                <tbody>
                    <tr>
                        <td>
                            <%= rs("Kry_Nip") %>
                        </td>
                        <!--set cabang -->
                        <td class="text-center">
                            <%=absenCabangMasuk%>
                        </td>
                        <!--end cabang -->  
                        <td>
                            <%= rs("Shf_Tanggal") %>
                        </td>
                        <!--jam masuk -->
                        <% 
                        if masuk = "TIDAK ABSEN"  then
                        tabsenMasuk = tabsenMasuk + 1
                        %>
                            <td class="text-danger">
                                <%= masuk %>
                            </td>
                        <% else %>
                            <td>
                                <%= masuk %>
                            </td>
                        <% end if %>
                        <!--jam keluar -->
                        <%
                        if keluar = "TIDAK ABSEN" then
                        tabsenKeluar = tabsenKeluar + 1
                        %>
                            <td class="text-danger">
                                <%= keluar %>
                            </td>
                        <% else %>
                            <td>
                                <%= keluar %>
                            </td>
                        <%end if%>
                        <!--keterangan masuk-->
                        <% 
                        if masuk <> "TIDAK ABSEN" then
                            if shiftJamMasuk < formatDateTime(masuk,4) then
                            ketMasuk = ketMasuk + 1
                         %>
                                <td class="text-danger">
                                    TERLAMBAT
                                </td>
                            <% else %>
                                <td>
                                    TEPAT WAKTU
                                </td>
                            <% end if %>
                        <% else %>
                            <td class="text-danger">
                                TIDAK ABSEN
                            </td>
                        <% end if %>
                        <!--keterangan keluar -->
                        <% 
                        if keluar <> "TIDAK ABSEN" then
                            if shiftJamKeluar > formatDateTime(keluar,4) then
                            ketKeluar = ketKeluar + 1
                        %>
                                <td class="text-danger">
                                    PULANG CEPAT
                                </td>
                            <% else %>
                                <td>
                                    TEPAT WAKTU
                                </td>
                            <% end if %>
                        <% else %>
                            <td class="text-danger">
                                TIDAK ABSEN
                            </td>
                        <% end if %>
                        <td>
                            <%= shiftJamMasuk %>
                        </td>
                        <td>
                            <%= ShiftJamKeluar %>
                        </td>
                        <!--jam kerja -->
                        <td class="text-center">
                            <%= jamKerja %>
                        </td>
                        <td>
                            <%= rs("Sh_iHari") %>
                        </td>
                        <!--longitude & latitude -->
                        <td class="text-center">
                            <%= longitude %>
                        </td>
                        <td class="text-center">
                            <%= latitude %>
                        </td>
                        <td class="text-center">
                            <%= pwfh %>
                        </td>
                        <!--cek status -->
                        <% 
                        if icskaryawan = "ALFA" then
                        alfa = alfa + 1
                         %>
                            <td class="text-danger text-center">
                                <%= icskaryawan %>
                            </td>
                        <% else %>
                            <td class="text-center">
                                <%= icskaryawan %>
                            </td>
                        <% end if %>
                    </tr>
                </tbody>
                <% 
                    showrecords = showrecords - 1
					rs.movenext
					if rs.EOF then
					lastrecord = 1
					end if
					loop

					rs.close
                 %>
            </table>
        </div>
    </div>
    <div class='row mt-2'>
        <div class='col-lg-10 text-center'>
            <!--paggination -->
            <nav aria-label="Page navigation example">
				<ul class="pagination">
					<li class="page-item">
						<% if requestrecords <> 0 then %>
							<a class="page-link" href="absensi_new.asp?offset=<%= requestrecords - recordsonpage%>&page=<%=pagelistcounter%>&nip=<%= nip %>&tgla=<%= tgla %>&tgle=<%= tgle %>">&#x25C4; Previous </a>
						<% else %>
							<p class="page-link-p">&#x25C4; Previous </p>
						<% end if %>
					</li>
					<li class="page-item d-flex" style="overflow-y:auto;">	
						<%
						pagelist = 0
						pagelistcounter = 0
						maxpage = 5
						nomor = 0
						do until pagelist > allrecords  
						pagelistcounter = pagelistcounter + 1

						%>	
							<a class="page-link hal d-flex active" href="absensi_new.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>&nip=<%= nip %>&tgla=<%= tgla %>&tgle=<%= tgle %>"><%= pagelistcounter %></a>  
						<%
						pagelist = pagelist + recordsonpage
						loop
						%>
					</li>
					<li class="page-item">
						<% if(recordcounter > 1) and (lastrecord <> 1) then %>
							<a class="page-link next" href="absensi_new.asp?offset=<%= requestrecords + recordsonpage %>&page=<%=pagelistcounter%>&nip=<%= nip %>&tgla=<%= tgla %>&tgle=<%= tgle %>">Next &#x25BA;</a>
						<% else %>
							<p class="page-link next-p">Next &#x25BA;</p>
						<% end if %>
					</li>	
				</ul>
			</nav>
			<!-- end pagging -->
        </div>
        <div class='col-lg-2 ps-0 pe-0 d-flex justify-content-end'>
            <button type="button" class="btn btn-primary btn-sm" onClick="window.open('exportXls-absensi.asp?nip=<%=nip%>&tgla=<%=tgla%>&tgle=<%=tgle%>','_self')">Export To Exel</button>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg-6'>
            <label><b>KETERANGAN / 10 DATA YANG DI TAMPILKAN</b></label>
            <ul>
                <li>
                    TIDAK ABSEN MASUK = <%= tabsenMasuk %>
                </li>
                <li>
                    TIDAK ABSEN KELUAR = <%= tabsenKeluar %>
                </li>
                <li>
                    TERLAMBAT MASUK = <%= ketMasuk %>
                </li>
                <li>
                    PULANG CEPAT = <%= ketKeluar %>
                </li>
                <li>
                    ALFA = <%= alfa %>
                </li>
            </ul>
        </div>
    </div>
    <% else %>
    <div class='row text-center mt-3'>
        <div class='col-lg' data-aos="flip-up" data-aos-easing="ease-out-cubic" data-aos-duration="500">
            <h5>MOHON UNTUK SET SHIFT KERJA TERLEBIH DAHULU / KARYAWAN BELUM MELAKUKAN ABSEN</h5>
        </div>
    </div>
<% 
    end if
end if              
%>
    <!--end konten -->
</div>



<!-- #include file='../layout/footer.asp' -->