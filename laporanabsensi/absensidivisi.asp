<!-- #include file='../connection.asp' -->
<!-- #include file='getNameDay.asp' -->
<!-- #include file='../func_JarakKoordinat.asp' -->

<%
	response.Buffer=true
	server.ScriptTimeout=1000000000

	tgla = Request.Form("tgla")
	tgle = Request.Form("tgle")
	divcode = Request.Form("divisi")
	agen = Request.Form("agen")

	dim Divisi,divisi_cmd

	set rangeMasuk_cmd = Server.CreateObject("ADODB.COmmand")
	rangeMasuk_cmd.activeConnection = MM_Cargo_string
	
	set rangeKeluar_cmd = Server.CreateObject("ADODB.COmmand")
	rangeKeluar_cmd.activeConnection = MM_Cargo_string

	set liburan_cmd = Server.CreateObject("ADODB.COmmand")
	liburan_cmd.ActiveConnection = MM_Cargo_string

	set status_cmd = Server.CreateObject("ADODB.COmmand")
	status_cmd.ActiveConnection = MM_Cargo_string

	set divisi_cmd = Server.CreateObject("ADODB.COmmand")
	divisi_cmd.activeConnection = MM_Cargo_string

	if divcode <> "" then
		divisi_cmd.commandText = "SELECT dbo.HRD_M_Divisi.Div_Nama, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_M_Divisi ON dbo.HRD_M_Karyawan.Kry_DDBID = dbo.HRD_M_Divisi.Div_Code LEFT OUTER JOIN GLB_M_AGEN ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE (dbo.HRD_M_Divisi.Div_Code = '"& divcode &"') AND GLB_M_Agen.Agen_ID = '"& agen &"' AND (dbo.HRD_M_Karyawan.Kry_AktifYN = 'Y') AND (dbo.HRD_M_karyawan.Kry_Nip NOT LIKE '%H%') AND (dbo.HRD_M_karyawan.Kry_Nip NOT LIKE '%A%') ORDER BY HRD_M_Karyawan.Kry_Nama" 
		'response.write divisi_cmd.commandText & "<BR>"
		set divisi = divisi_cmd.execute
	else
		divisi_cmd.commandText = "SELECT dbo.HRD_M_Divisi.Div_Nama, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_M_Divisi ON dbo.HRD_M_Karyawan.Kry_DDBID = dbo.HRD_M_Divisi.Div_Code LEFT OUTER JOIN GLB_M_AGEN ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.Agen_ID = '"& agen &"' AND (dbo.HRD_M_Karyawan.Kry_AktifYN = 'Y') AND (dbo.HRD_M_karyawan.Kry_Nip NOT LIKE '%H%') AND (dbo.HRD_M_karyawan.Kry_Nip NOT LIKE '%A%') GROUP BY dbo.HRD_M_Divisi.Div_Nama, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_Nama ORDER BY HRD_M_Karyawan.Kry_Nama" 
		'response.write divisi_cmd.commandText & "<BR>"
		set divisi = divisi_cmd.execute
	end if

	dim karyawanshift, wfh

%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>LAPORAN ABSENSI</title>
	<!-- #include file='../layout/header.asp' -->
	<style>
		label{
			margin:0;
			font-size:12px;
		}
		table{
			font-size:10px;
		}
        button{
            position:absolute;
        }
	</style>
	</head>
<body>
<div class="btn-group" role="group" aria-label="Basic outlined example">
	<button type='button' class='btn btn-outline-danger btn-sm' onClick="window.location.href='index.asp'">Kembali</button>
	<button type='button' class='btn btn-outline-primary btn-sm' onClick="window.open('exportXls-laporanAbsensi.asp?tgla=<%=tgla%>&tgle=<%=tgle%>&divisi=<%= divcode %>&agen=<%= agen %>')">EXPORT</button>
</div>
<%  
	if not divisi.eof then
		if divcode <> "" then
			response.write "<center><b>DIVISI : " & divisi("Div_nama") & "<BR>" & "CABANG : " & divisi("Agen_NAma") & "<br>" &"PERIODE : " & tgla & " Sampai " & tgle & "</center></b><BR>"		
		else
			response.write "<center><b>CABANG : " & divisi("Agen_NAma") & "<br>" &"PERIODE : " & tgla & " Sampai " & tgle & "</center></b><BR>"
		end if 
	end if
%>

	<%
	do while not divisi.eof
		response.write "<label>KARYAWAN : " & divisi("kry_nama") & " <b>[" & divisi("Kry_Nip") & "]</label></b>"

		set shift_cmd = Server.CreateObject("ADODB.COmmand")
		shift_cmd.ActiveConnection = MM_Cargo_string
			
		wfh = Cdate("3/7/2021")

		shift_cmd.commandText = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& divisi("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"
		' Response.Write shift_cmd.commandText & "<br>"
		set karyawanshift = shift_cmd.execute

			set connection = server.CreateObject("ADODB.Connection")
			connection.open MM_cargo_STRING

			dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter
			dim nip, cabang, tgl, tgla, tgle, ketm, ketk, shiftm, shiftk, bedai, offset

			orderBy =  " ORDER BY HRD_T_Shift.Shf_Tanggal ASC"

			set rs = Server.CreateObject("ADODB.Recordset")

			sqlAwal = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP =  '"& divisi("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"' "

			sql=sqlawal + orderBy

			rs.open sql, Connection

			' records per halaman
			recordsonpage = 200

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

			sqlawal = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_M_Shift.Sh_Name FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID WHERE dbo.HRD_M_Karyawan.Kry_NIP ='"& divisi("kry_nip") &"' and Shf_tanggal between '"& tgla &"' AND '"& tgle &"'"	

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
		%>
			<%  if not karyawanshift.eof then %>
				<div class='row'>
					<div class='col-lg-12 overflow-auto'>
						<table class="table table-hover">
							<thead class="bg-secondary text-light text-center" style="white-space: nowrap;">
								<tr>
									<th scope="col">NIP</th>
									<th scope="col">HARI</th>
									<th scope="col">MASUK SHIFT</th>
									<th scope="col">KELUAR SHIFT</th>
									<th scope="col">TANGGAL SHIFT</th>
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

								'jam masuk 
								shift_cmd.commandText = "SELECT top 1  vw_poolAbsen.abs_datetime, GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID,vw_poolAbsen.ABS_Lat, vw_poolAbsen.ABS_Lon, vw_poolAbsen.ABS_SyncToAdempiere, vw_poolAbsen.ABS_Nip FROM vw_poolAbsen LEFT OUTER JOIN GLB_M_Agen ON vw_poolAbsen.Abs_AgenId = GLB_M_Agen.Agen_ID where ABS_Nip = '"& rs("Kry_NIP") &"' and day(abs_datetime) = '"& day(rs("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(rs("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(rs("Shf_Tanggal")) &"'  order by abs_datetime ASC"
								' Response.Write shift_cmd.commandText & "<br>"
								set jamMasuk = shift_cmd.execute

								'jam keluar
								shift_cmd.commandText = "SELECT TOP 1 ABS_Datetime, GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID,vw_poolAbsen.ABS_Lat, vw_poolAbsen.ABS_Lon, vw_poolAbsen.ABS_SyncToAdempiere FROM vw_poolAbsen LEFT OUTER JOIN GLB_M_Agen ON vw_poolAbsen.Abs_AgenID = GLB_M_Agen.Agen_ID where ABS_Nip = '"& rs("Kry_NIP") &"' and day(abs_datetime) = '"& day(rs("Shf_Tanggal")) &"' and month(abs_datetime) = '"& month(rs("Shf_Tanggal")) &"' and year(abs_datetime) = '"& year(rs("Shf_Tanggal")) &"'  order by abs_datetime DESC"

								set jamKeluar = shift_cmd.execute

								'definisi jam masuk dan keluar jika sama kosongkan
								if not jamMasuk.eof then
									longitude = jamMasuk("Abs_Lon")
									latitude = jamMasuk("Abs_Lat")

									ShiftJamMasuk = right("00" & rs("Sh_JamIn"),2) & ":" & right("00" & rs("Sh_MenitIn") ,2)

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
									
									ShiftJamKeluar = right("00" & rs("Sh_JamOut"),2) & ":" & right("00" & rs("Sh_MenitOut") ,2)

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
									' cek priode libur
									liburan_cmd.commandTExt = "SELECT * FROM HRD_M_CalLiburPeriodik WHERE LP_Tgl = '"& rs("SHF_Tanggal") &"' AND LP_LiburYN = 'Y'"
									set libur = liburan_cmd.execute

									if not libur.eof then
										icskaryawan = "PRIODE LIBUR"
									else
										status_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.Ics_Status FROM HRD_T_IzinCutiSakit WHERE  HRD_T_IzinCutiSakit.ICS_Nip = '"& rs("Kry_NIP") &"' AND NOT(HRD_T_IzinCutiSakit.ICS_StartDate > '"& rs("Shf_Tanggal") &"' OR HRD_T_IzinCutiSakit.ICS_EndDate < '"& rs("Shf_Tanggal") &"') AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate ASC" 
										' Response.Write status_cmd.commandText & "<br>"
										set gamasuk = status_cmd.execute

										' cek cuti karyawan 
										if not gamasuk.eof then
												if gamasuk("ics_status") = "A" then
													icskaryawan = "ALFA"
												elseIf gamasuk("ics_status") = "B" then
													icskaryawan = "CUTI BERSAMA"
												elseIf gamasuk("ics_status") = "C" then
													icskaryawan = "CUTI"
												elseIf gamasuk("ics_status") = "G" then
													icskaryawan = "DISPENSASI"
												elseIf gamasuk("ics_status") = "I" then
													icskaryawan = "IZIN"
												elseIf gamasuk("ics_status") = "K" then
													icskaryawan = "KLAIM OBAT"
												else
													icskaryawan = "SAKIT"
												end if
										else
											icskaryawan = "ALFA"
										end if
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
										<% getNameDay(Weekday(rs("Shf_Tanggal"))) %>
									</td>
									<td>
										<%= shiftJamMasuk %>
									</td>
									<td>
										<%= ShiftJamKeluar %>
									</td>
									<td>
										<%= rs("SHf_Tanggal") %>
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
				</div>
				<% else %>
				<div class='row text-center mt-3'>
					<div class='col-lg' data-aos="flip-up" data-aos-easing="ease-out-cubic" data-aos-duration="500">
						<h5>MOHON UNTUK SET SHIFT KERJA TERLEBIH DAHULU / KARYAWAN BELUM MELAKUKAN ABSEN</h5>
					</div>
				</div>
			<% 
				end if
			' end if              
			%>
<% 
response.flush
divisi.movenext
loop %>	
</div>
<!-- #include file='../layout/footer.asp' -->


