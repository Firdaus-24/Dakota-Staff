<!-- #include file='../connection.asp' -->
<!-- #include file='../laporanabsensi/getNameDay.asp' -->
<!-- #include file='../../func_JarakKoordinat.asp' -->
<% 
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

    function GetLastDay(aDate)
    dim intMonth
    dim dteFirstDayNextMonth

        dtefirstdaynextmonth = dateserial(year(adate),month(adate) + 1, 1)
        GetLastDay = Day(DateAdd ("d", -1, dteFirstDayNextMonth))
    end function

    set rangeKeluar_cmd = Server.CreateObject("ADODB.COmmand")
    rangeKeluar_cmd.ActiveConnection = MM_Cargo_string

    set rangeMasuk_cmd = Server.CreateObject("ADODB.COmmand")
    rangeMasuk_cmd.ActiveConnection = MM_Cargo_string

    set karyawan_cmd = Server.CreateObject("ADODB.COmmand")
    karyawan_cmd.ActiveConnection = MM_Cargo_string

    ' label nama dan nip
    karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama, kry_nip, GLB_M_Agen.Agen_ID FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nip = '"& nip &"'"
    set karyawan = karyawan_cmd.execute

    if not karyawan.eof then
        agen = karyawan("agen_ID")
    end if

    set shift_cmd = Server.CreateObject("ADODB.COmmand")
	shift_cmd.ActiveConnection = MM_Cargo_string
			
	wfh = Cdate("3/7/2021")

    if tgla <> "" AND tgle <> "" then
		root = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& karyawan("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"
			
		shift_cmd.commandText = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& karyawan("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"
			' Response.Write shift_cmd.commandText & "<br>"
		set karyawanshift = shift_cmd.execute

		set connection = server.CreateObject("ADODB.Connection")
		connection.open MM_cargo_STRING

		orderBy =  " ORDER BY HRD_T_Shift.Shf_Tanggal ASC"

		set rs = Server.CreateObject("ADODB.Recordset")

		sqlAwal = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& karyawan("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"' "

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

		sqlawal = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP ='"& karyawan("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"	

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
    .table{
        font-size:12px;
        overflow:auto;
        display:block;
    }
    .table tr:first-child{
        white-space: nowrap;
    }
    </style>
</head>
<body>
<!-- #include file='../landing.asp' -->
<div class='container'>
<!-- #include file='template-detail.asp' -->
    <!--header -->
    <% if not karyawan.eof then %>
        <div class='row mt-2 mb-2 contentDetail'>
            <label for="labelNip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class='col-lg-3' >
                <input type='text' class='form-control form-control-sm' name='labelNip' id='labelNip' value="<%= nip %>" readonly>
            </div>
            <label for="labelNama" class="col-sm-1 col-form-label col-form-label-sm">NAMA</label>
            <div class='col-lg-3' >
                <input type='text' class='form-control form-control-sm' name='labelNama' id='labelNama' value="<%= karyawan("Kry_Nama") %>" readonly>
            </div>
            <label for="labelDivisi" class="col-sm-1 col-form-label col-form-label-sm">DIVISI</label>
            <div class='col-lg-3' >
                <input type='text' class='form-control form-control-sm' name='labelDivisi' id='labelDivisi' value="<%= karyawan("Div_Nama") %>" readonly>
            </div>
        </div>
    <% end if %>
    <!--endheader -->
    <!--form input tanggal -->
    <div class='row contentDetail'>
        <div class='col'>
            <div class="form mb-2">
                <form action="absensi.asp?nip=<%= nip %>" method="post"  id="form-absensi" class="row g-3 mt-3 form-absensi"> 
                    <input type="hidden" class="form-control" name="nip" id="nip" value="<%= nip %>" required >
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-floating">
                            <input type="date" class="form-control" name="tgla" id="tgla" required >
                            <label for="floatingInputGrid">Tanggal Awal</label>
                            </div>
                        </div>
                        <div class="col-md-3">
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
    <%
		if tgla <> "" AND tgle <> "" then
			if not karyawanshift.eof then
			%>
				<div class='row mt-3'>
					<div class='col-md-12 p-0'>
						<table class="table table-hover" >
							<thead class="bg-secondary text-light text-center">
								<tr>
									<th scope="col">NIP</th>
									<th scope="col">HARI</th>
									<th scope="col">MASUK SHIFT</th>
									<th scope="col">KELUAR SHIFT</th>
									<th scope="col">JAM KERJA</th>
									<th scope="col">BEDA HARI</th>
									<th scope="col">ABSEN MASUK</th>
									<th scope="col">KET.MASUK</th>
									<th scope="col">KOORDINAT</th>
									<th scope="col">ABSEN KELUAR</th>
									<th scope="col">KET.KELUAR</th>
									<th scope="col">KOORDINAT</th>
									<th scope="col">CABANG ABSEN</th>
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
								shift_cmd.commandText = "SELECT top 1  vw_poolAbsen.abs_datetime, GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID,vw_poolAbsen.ABS_Lat, vw_poolAbsen.ABS_Lon, vw_poolAbsen.ABS_SyncToAdempiere, vw_poolAbsen.ABS_Nip FROM vw_poolAbsen LEFT OUTER JOIN GLB_M_Agen ON vw_poolAbsen.Abs_AgenId = GLB_M_Agen.Agen_ID where ABS_Nip = '"& rs("Kry_NIP") &"' and day(abs_datetime) = '"& day(rs("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(rs("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(rs("Shf_Tanggal")) &"'  order by abs_datetime ASC"
								' Response.Write shift_cmd.commandText & "<br>"
								set jamMasuk = shift_cmd.execute

								ShiftJamMasuk = right("00" & rs("Sh_JamIn"),2) & ":" & right("00" & rs("Sh_MenitIn") ,2)
								
								'jam keluar
								shift_cmd.commandText = "SELECT TOP 1 ABS_Datetime, GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID,vw_poolAbsen.ABS_Lat, vw_poolAbsen.ABS_Lon, vw_poolAbsen.ABS_SyncToAdempiere FROM vw_poolAbsen LEFT OUTER JOIN GLB_M_Agen ON vw_poolAbsen.Abs_AgenID = GLB_M_Agen.Agen_ID where ABS_Nip = '"& rs("Kry_NIP") &"' and day(abs_datetime) = '"& day(rs("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(rs("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(rs("Shf_Tanggal")) &"'  order by abs_datetime DESC"

								set jamKeluar = shift_cmd.execute

								ShiftJamKeluar = right("00" & rs("Sh_JamOut"),2) & ":" & right("00" & rs("Sh_MenitOut") ,2)

								'definisi jam masuk dan keluar jika sama kosongkan
								if not jamMasuk.eof then
									longitude = jamMasuk("Abs_Lon")
									latitude = jamMasuk("Abs_Lat")
									tglmasuk =  Cdate(month(jamMasuk("abs_datetime")) &"/"& day(jamMasuk("Abs_datetime")) &"/"& year(jamMasuk("abs_datetime")) &" "& dateadd("n",60,ShiftJamMasuk))
									masuk = jamMasuk("Abs_datetime") 
									' interval max jam masuk
									if masuk >= tglmasuk then
										masuk = "TIDAK ABSEN"
									else
										masuk = masuk
									end if
									' definisi status absen untuk WFH and WFO
									if jamMasuk("ABS_SyncToAdempiere") <> "H" then
										status = "O"
									else
										status = jamMasuk("ABS_SyncToAdempiere")
									end if
								else
									masuk = "TIDAK ABSEN"
									longitude = "-"
									latitude = "-"
									tglmasuk = ""
								end if 
								
								' definisi jam keluar
								if not jamKeluar.eof then 
										minKeluar = Cdate(month(jamMasuk("abs_datetime")) &"/"& day(jamMasuk("Abs_datetime")) &"/"& year(jamMasuk("abs_datetime")) &" "& dateAdd("n",-30, ShiftJamKeluar))

										maxKeluar = Cdate(month(jamMasuk("abs_datetime")) &"/"& day(jamMasuk("Abs_datetime")) &"/"& year(jamMasuk("abs_datetime")) &" "& dateAdd("h",3, ShiftJamKeluar))

										keluar = jamKeluar("Abs_Datetime")
										longitude1 = jamKeluar("Abs_Lon")
										latitude1 = jamKeluar("Abs_Lat")

										if keluar <= minKeluar then
											keluar = "TIDAK ABSEN"
										elseIf keluar >= maxkeluar then
											keluar = "TIDAK ABSEN"
										else
											keluar = keluar
										end if

										if jamKeluar("ABS_SyncToAdempiere") <> "H" then
											statusKeluar = "O"
										else
											statusKeluar = jamKeluar("ABS_SyncToAdempiere")
										end if
								else
									keluar = "TIDAK ABSEN"
									longitude1 = "-"
									latitude1 = "-"
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
											statusMasuk = jamMasuk("ABS_SyncToAdempiere")
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
									shift_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.Ics_Status FROM HRD_T_IzinCutiSakit WHERE  HRD_T_IzinCutiSakit.ICS_Nip = '"& rs("Kry_NIP") &"' AND (HRD_T_IzinCutiSakit.ICS_StartDate BETWEEN '"& rs("Shf_Tanggal") &"' AND '"& month(rs("Shf_Tanggal")) &"/"& GetLastDay(rs("Shf_Tanggal")) &"/"& year(rs("Shf_Tanggal")) &"' OR HRD_T_IzinCutiSakit.ICS_EndDate BETWEEN '"& rs("Shf_Tanggal") &"' AND '"& month(rs("Shf_Tanggal")) &"/"& GetLastDay(rs("Shf_Tanggal")) &"/"& year(rs("Shf_Tanggal")) &"') AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate ASC" 
									' Response.Write shift_cmd.commandText & "<br>"
									set status = shift_cmd.execute

									if not status.eof then
									' Response.Write status() & 
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
									<td>
										<% getLastDay(Weekday(rs("Shf_Tanggal"))) %>
									</td>
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
									<!--jam masuk -->
										<% 
										if masuk = "TIDAK ABSEN"  then
										'tabsenMasuk = tabsenMasuk + 1
										%>
											<td style="color:red;">
												<%= masuk %>
											</td>
										<%else %>
											<td>
												<%= masuk %>
											</td>
										<%end if %>
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
									<!--cabang absen masuk -->
										<%
										if masuk <> "TIDAK ABSEN" then
											if not jamMasuk.eof then
												if status = "O" then
													rangeMasuk_cmd.commandText = "SELECT GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_Lat, GLB_M_Agen.Agen_Long, GLB_M_Agen.Agen_md5, isnull(GLB_M_AgenRangeGPS.AgenG_Range,100) AS AgenG_Range FROM GLB_M_Agen LEFT OUTER JOIN GLB_M_AgenRangeGPS ON GLB_M_Agen.Agen_ID = GLB_M_AgenRangeGPS.AgenG_AgenID RIGHT JOIN HRD_M_Karyawan ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE (GLB_M_Agen.Agen_AktifYN = 'Y') AND (GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%') AND (GLB_M_Agen.Agen_ID) = '"& agen &"' ORDER BY GLB_M_Agen.Agen_Nama"
													' Response.Write rangeMasuk_cmd.commandText & "<br>"
													set rangeMasuk = rangeMasuk_cmd.execute

													if not rangeMasuk.eof then
														ilat1 = rangeMasuk("Agen_lat")
														ilong1 = rangeMasuk("Agen_long")
														jarak = Cint(rangeMasuk("AgenG_Range"))
														
														if distance(ilat1,ilong1,latitude,longitude,"K") <= jarak then %>
															<td>SESUAI</td>
														<%else%>
															<td style="color:red;">TIDAK SESUAI</td>
														<%end if%>
													<%end if%>
												<%else %>
													<td style="color:red;">WFH</td>
												<%
												end if
											else %>
												<td>-</td>
										<%
											end if
										else %>
											<td style="color:red;">TIDAK ABSEN</td>
										<%end if%>
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
									
									<!--cabang absen keluar -->
										<%
										if keluar <> "TIDAK ABSEN" then
											if not jamKeluar.eof then
												if statusKeluar = "O" then
													rangeKeluar_cmd.commandText = "SELECT GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_Lat, GLB_M_Agen.Agen_Long, GLB_M_Agen.Agen_md5, isnull(GLB_M_AgenRangeGPS.AgenG_Range,100) AS AgenG_Range FROM GLB_M_Agen LEFT OUTER JOIN GLB_M_AgenRangeGPS ON GLB_M_Agen.Agen_ID = GLB_M_AgenRangeGPS.AgenG_AgenID RIGHT JOIN HRD_M_Karyawan ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE (GLB_M_Agen.Agen_AktifYN = 'Y') AND (GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%') AND (GLB_M_Agen.Agen_ID) = '"& agen &"' ORDER BY GLB_M_Agen.Agen_Nama"
													' Response.Write rangeKeluar_cmd.commandText & "<br>"
													set rangeKeluar = rangeKeluar_cmd.execute

													if not rangeKeluar.eof then
													
													ilat1 = rangeKeluar("Agen_lat")
													ilong1 = rangeKeluar("Agen_long")
													jarak = Cint(rangeKeluar("AgenG_Range"))
										%>
														<%if distance(ilat1,ilong1,latitude1,longitude1,"K") <= jarak then %>
															<td>SESUAI</td>
														<%else%>
															<td style="color:red;">TIDAK SESUAI</td>
														<%end if
													end if
														%>
										<%	
												else %>
													<td style="color:red;">WFH</td>
												<%
												end if
											else %>	
												<td>-</td>
										<%
											end if
										else %>
											<td style="color:red;">TIDAK ABSEN</td>
										<%end if%>



									
									<!--set maps -->
										<% if longitude <> "-" And logointude1 <> "-" then %>
											<td>
												<div class="btn-group" role="group" aria-label="Basic example">
													<% If masuk <> "TIDAK ABSEN" then%>
													<a href="https://maps.google.com/maps?q=<%= latitude %>,<%= longitude %>&hl=id&z=16&ampoutput=embed"  target="_blank"><span class="badge rounded-pill bg-primary">Masuk</span></a>
													<% end if%>
													<%if keluar <> "TIDAK ABSEN" then%>
													<a href="https://maps.google.com/maps?q=<%= latitude1 %>,<%= longitude1 %>&hl=id&z=16&ampoutput=embed"  target="_blank"><span class="badge rounded-pill bg-primary">Keluar</span></a>
													<%end if%>
												</div>
											</td>
										<%else%>
											<td style="text-align:center;">
												-
											</td>
										<%end if%>
									<!--status WFH -->
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
                                response.flush
								rs.movenext
								if rs.EOF then
								lastrecord = 1
								end if
								loop

								rs.close
							%>
						</table>
					</div>
                    <!-- paggination -->
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item">
								<% 
								page = Request.QueryString("page")
								if page = "" then
									npage = 1
								else
									npage = page - 1
								end if
								if requestrecords <> 0 then %>
								<a class="page-link" href="absensi.asp?offset=<%= requestrecords - recordsonpage%>&page=<%=npage%>&tgla=<%=tgla%>&tgle=<%= tgle %>&nip=<%= nip %>">&#x25C4; Previous </a>
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

									if page = "" then
										page = 1
									else
										page = page
									end if
									
									if Cint(page) = pagelistcounter then
								%>	
									<a class="page-link hal d-flex bg-primary text-light" href="absensi.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>&tgla=<%=tgla%>&tgle=<%= tgle %>&nip=<%= nip %>"><%= pagelistcounter %></a>  
									<% else %>
									<a class="page-link hal d-flex" href="absensi.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>&tgla=<%=tgla%>&tgle=<%= tgle %>&nip=<%= nip %>"><%= pagelistcounter %></a>  
								<%
									end if
								pagelist = pagelist + recordsonpage
								loop
								%>
							</li>
							<li class="page-item">
							<% 
								if page = "" then
									page = 1
								else
									page = page + 1
								end if
							%>
								<% if(recordcounter > 1) and (lastrecord <> 1) then %>
								<a class="page-link next" href="absensi.asp?offset=<%= requestrecords + recordsonpage %>&page=<%=page%>&tgla=<%=tgla%>&tgle=<%= tgle %>&nip=<%= nip %>">Next &#x25BA;</a>
								<% else %>
								<p class="page-link next-p">Next &#x25BA;</p>
								<% end if %>
							</li>	
						</ul>
					</nav>
				<!-- end pagging -->
				</div>
            <%
            end if
            end if%>
<!-- #include file='../layout/footer.asp' -->