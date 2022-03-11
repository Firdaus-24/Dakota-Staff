<!-- #include file="../connection.asp"-->
<!--#include file="../layout/header.asp"-->
<% 
dim nip

nip = Request.QueryString("nip")

'connection absen
'Set absen_cmd = Server.CreateObject ("ADODB.Command")
'absen_cmd.ActiveConnection = MM_cargo_STRING

'absen_cmd.commandText = "SELECT * FROM HRD_T_Absensi WHERE Abs_NIP= '" & nip & "' ORDER BY Abs_datetime DESC"

'set absen = absen_cmd.execute

'connection masterkaryawan
Set karyawan_cmd = Server.CreateObject ("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_cargo_STRING

'karyawan_cmd.commandText ="SELECT dbo.GLB_M_Agen.Agen_ID, dbo.GLB_M_Agen.Agen_KotaID, dbo.GLB_M_Agen.Agen_CabangID, dbo.GLB_M_Agen.Agen_TLC, dbo.GLB_M_Agen.Agen_Kode, dbo.GLB_M_Agen.Agen_Nama, dbo.GLB_M_Agen.Agen_Alamat, dbo.GLB_M_Agen.Agen_Kota, dbo.GLB_M_Agen.Agen_Kecamatan, dbo.GLB_M_Agen.Agen_Propinsi, dbo.GLB_M_Agen.Agen_ContactPerson, dbo.GLB_M_Agen.Agen_STT, dbo.GLB_M_Agen.Agen_Phone1, dbo.GLB_M_Agen.Agen_Phone2, dbo.GLB_M_Agen.Agen_Phone3, dbo.GLB_M_Agen.Agen_DialString, dbo.GLB_M_Agen.Agen_KomisiKirim, dbo.GLB_M_Agen.Agen_KomisiTerima1, dbo.GLB_M_Agen.Agen_KomisiTerima2, dbo.GLB_M_Agen.Agen_KomisiTransit, dbo.GLB_M_Agen.Agen_TransitYN, dbo.GLB_M_Agen.Agen_ServerName, dbo.GLB_M_Agen.Agen_AktifYN, dbo.GLB_M_Agen.Agen_PostingYN, dbo.GLB_M_Agen.Agen_UpdateID, dbo.GLB_M_Agen.Agen_UpdateTime, dbo.GLB_M_Agen.Agen_PCAID, dbo.GLB_M_Agen.Agen_KomisiCarter, dbo.GLB_M_Agen.Agen_Status, dbo.GLB_M_Agen.Agen_NPWP, dbo.GLB_M_Agen.Agen_KodePajak, dbo.GLB_M_Agen.Agen_AlamatNPWP, dbo.GLB_M_Agen.Agen_LimitJual, dbo.GLB_M_Agen.Agen_LimitBTT, dbo.GLB_M_Agen.Agen_MinHand, dbo.GLB_M_Agen.Agen_InsentifGudang, dbo.GLB_M_Agen.Agen_Long, dbo.GLB_M_Agen.Agen_Lat, dbo.GLB_M_Agen.Agen_VirtualAcc, dbo.GLB_M_Agen.Agen_ClosingTime, dbo.GLB_M_Agen.Agen_UMR, dbo.GLB_M_Agen.Agen_TarifKota, dbo.GLB_M_Agen.Agen_TarifKecamatan, dbo.GLB_M_Agen.Agen_barcodeScannerPrinterReady, dbo.GLB_M_Agen.Agen_md5, dbo.GLB_M_Agen.Agen_AktifTanggal, dbo.GLB_M_Agen.Agen_nonAktifTanggal, dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_DDBID, dbo.HRD_M_Karyawan.Kry_ActiveAgenID, dbo.HRD_M_Karyawan.Kry_JabCode, dbo.HRD_M_Karyawan.Kry_GSCode, dbo.HRD_M_Karyawan.Kry_JJID, dbo.HRD_M_Karyawan.Kry_Nama, dbo.HRD_M_Karyawan.Kry_Addr1, dbo.HRD_M_Karyawan.Kry_Addr2, dbo.HRD_M_Karyawan.Kry_Kota, dbo.HRD_M_Karyawan.Kry_KdPos, dbo.HRD_M_Karyawan.Kry_Telp1, dbo.HRD_M_Karyawan.Kry_Telp2, dbo.HRD_M_Karyawan.Kry_Pager, dbo.HRD_M_Karyawan.Kry_Fax, dbo.HRD_M_Karyawan.Kry_Sex, dbo.HRD_M_Karyawan.Kry_TmpLahir, dbo.HRD_M_Karyawan.Kry_TglLahir, dbo.HRD_M_Karyawan.Kry_SttSosial, dbo.HRD_M_Karyawan.Kry_JmlAnak, dbo.HRD_M_Karyawan.Kry_JmlSaudara, dbo.HRD_M_Karyawan.Kry_AnakKe, dbo.HRD_M_Karyawan.Kry_AgamaID, dbo.HRD_M_Karyawan.Kry_JDdkID, dbo.HRD_M_Karyawan.Kry_NoID, dbo.HRD_M_Karyawan.Kry_JnsID, dbo.HRD_M_Karyawan.Kry_IDValidDate, dbo.HRD_M_Karyawan.Kry_NoSIM, dbo.HRD_M_Karyawan.Kry_JnsSIM, dbo.HRD_M_Karyawan.Kry_SIMValidDate, dbo.HRD_M_Karyawan.Kry_LemburYN, dbo.HRD_M_Karyawan.Kry_CutiStt, dbo.HRD_M_Karyawan.Kry_JmlTanggungan, dbo.HRD_M_Karyawan.Kry_JmlCuti, dbo.HRD_M_Karyawan.Kry_TglMasuk, dbo.HRD_M_Karyawan.Kry_TglKeluar, dbo.HRD_M_Karyawan.Kry_TglStartGaji, dbo.HRD_M_Karyawan.Kry_TglEndGaji, dbo.HRD_M_Karyawan.Kry_PembayaranGaji, dbo.HRD_M_Karyawan.Kry_PerhitunganGaji, dbo.HRD_M_Karyawan.Kry_JmlHariKerja, dbo.HRD_M_Karyawan.Kry_BarCode, dbo.HRD_M_Karyawan.Kry_PIN, dbo.HRD_M_Karyawan.Kry_BankID, dbo.HRD_M_Karyawan.Kry_NoRekening, dbo.HRD_M_Karyawan.Kry_CurrentStt, dbo.HRD_M_Karyawan.Kry_SttKerja, dbo.HRD_M_Karyawan.Kry_MasaPercobaan, dbo.HRD_M_Karyawan.Kry_TglPercobaanStart, dbo.HRD_M_Karyawan.Kry_TglPercobaanEnd, dbo.HRD_M_Karyawan.Kry_NoSrtAngkat, dbo.HRD_M_Karyawan.Kry_AktifYN, dbo.HRD_M_Karyawan.Kry_UpdateID, dbo.HRD_M_Karyawan.Kry_UpdateTime, dbo.HRD_M_Karyawan.Kry_Obat, dbo.HRD_M_Karyawan.Kry_NPWP, dbo.HRD_M_Karyawan.Kry_NoJamsostek, dbo.HRD_M_Karyawan.Kry_password, dbo.HRD_M_Karyawan.Kry_BPJS…D WHERE Kry_nip='" & nip & "'"

karyawan_cmd.commandText = "SELECT top 100 dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Absensi.Abs_NIP, CONVERT(varchar(10), dbo.HRD_T_Absensi.Abs_datetime, 120) AS Abs_datetime, dbo.GLB_M_Agen.Agen_Nama FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.GLB_M_Agen LEFT OUTER JOIN dbo.HRD_T_Absensi ON dbo.GLB_M_Agen.Agen_ID = dbo.HRD_T_Absensi.Abs_AgenID ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Absensi.Abs_NIP WHERE        (dbo.HRD_M_Karyawan.Kry_NIP = '"& nip &"') GROUP BY dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Absensi.Abs_NIP, CONVERT(varchar(10), dbo.HRD_T_Absensi.Abs_datetime, 120), dbo.GLB_M_Agen.Agen_Nama Order BY Abs_datetime DESC"  

'response.write karyawan_cmd.commandText & "<BR>"
set karyawan = karyawan_cmd.execute


					dim sqlJamMasuk
                    set sqlJamMasuk = Server.CreateObject("ADODB.Command")
                    sqlJamMasuk.ActiveConnection = MM_cargo_STRING

					dim sqlJamKeluar
					set sqlJamKeluar = Server.CreateObject("ADODB.Command")
                    sqlJamKeluar.ActiveConnection = MM_cargo_STRING

					dim shiftKaryawan
					set shiftKaryawan = Server.CreateObject("ADODB.Command")
					shiftKaryawan.ActiveConnection = MM_cargo_STRING

 %> 

    <title>Absensi</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-lg">
            <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">NIP</th>
                    <th scope="col">CABANG ABSEN</th>
                    <th scope="col">TANGGAL</th>
                    <th scope="col">ABSEN MASUK</th>
					<th scope="col">ABSEN KELUAR</th>
                    <th scope="col">KETERANGAN MASUK</th>
                    <th scope="col">KETERANGAN KELUAR</th>
                   
                </tr>
            </thead>
                <% 
                    do until karyawan.EOF
					
					tanggal = day(karyawan("Abs_datetime")) & "/" & monthname(month(karyawan("Abs_datetime"))) & "/" & year(karyawan("Abs_datetime"))
					
                %> 
            <tbody>
                
                
                    <tr>         
                    <td><%= karyawan("Abs_NIP") %> </td>
                    <td><%= karyawan("agen_nama") %></td>
                    <td><%= tanggal %></td>
					
					<% ' cek masuk/telat dari shift 
						
									
								shiftKaryawan.commandText = "SELECT  dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_M_Karyawan.Kry_GSCode, dbo.HRD_T_Shift.* FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_GSCode = dbo.HRD_T_Shift.Shf_GSCode WHERE (dbo.HRD_M_Karyawan.Kry_NIP =  '"& nip &"') and Shf_hari = '"& weekday(tanggal) &"'" 
								
								'response.write shiftKaryawan.commandText & "<BR>"
								set shiftKrywn = shiftKaryawan.execute
								
								if shiftKrywn.eof = false then
									ShiftJamMasuk = right("00" & shiftKrywn("Shf_JamIn"),2) & ":" & right("00" & shiftKrywn("Shf_MenitIn") ,2)
									ShiftJamKeluar = right("00" & shiftKrywn("Shf_JamOut"),2) & ":" & right("00" & shiftKrywn("Shf_MenitOut") ,2)
									
								end if
								
								'response.write ShiftJamMasuk & "<BR>"
								'response.write ShiftJamKeluar & "<BR>"
					
					
					%>
					
					
               	<% 
					'Definisikan jam masuk
					

                    sqlJamMasuk.commandText = "SELECT top 1  abs_datetime FROM HRD_T_Absensi where ABS_Nip = '"& karyawan("Abs_NIP") &"' and day(abs_datetime) = '"& day(karyawan("Abs_datetime")) &"' and month(abs_datetime) = '"& month(karyawan("Abs_datetime")) &"' and year(abs_datetime) = '"& year(karyawan("Abs_datetime")) &"'  order by abs_datetime"
					
					'response.write sqlJamMasuk.commandText & "<BR>"

                    set sqlMasuk = sqlJamMasuk.execute
					
			
					  
                            
                     %>
                    <td><% do while not sqlMasuk.eof %> <% if dateDiff("h",ShiftJamMasuk,formatDateTime(sqlMasuk("abs_datetime"),4)) >= 1 then %> TIDAK ABSEN <%else%> <%= sqlMasuk("abs_datetime") %> <% masuk = sqlMasuk("abs_datetime") %> <% end if%> <% sqlMasuk.movenext%><%loop%></td>
					<% 
					'Definisikan jam keluar
					
					
                    sqlJamKeluar.commandText = "SELECT top 1 abs_datetime FROM HRD_T_Absensi where ABS_Nip = '"& karyawan("Abs_NIP") &"' and day(abs_datetime) = '"& day(karyawan("Abs_datetime")) &"' and month(abs_datetime) = '"& month(karyawan("Abs_datetime")) &"' and year(abs_datetime) = '"& year(karyawan("Abs_datetime")) &"'  order by abs_datetime desc"

                    set sqlKeluar = sqlJamKeluar.execute
					
					
                 
                     %>
					<td><% do while not sqlKeluar.eof %>   <% keluar = sqlKeluar("abs_datetime") %> <%if dateDiff("s",keluar,masuk) = 0 then %>TIDAK ABSEN <%ELSE %> <%=keluar%> <% end if %><% sqlKeluar.movenext%><%loop%></td>
					
					
					
					<td><%if ShiftJamMasuk < formatDateTime(masuk,4) then%>TERLAMBAT<%else%>TEPAT WAKTU<%end if%></td>
					<td><%if ShiftJamKeluar > formatDateTime(keluar,4) then%>PULANG AWAL<%else%>PULANG TEPAT WAKTU<%end if%></td>
					
					
					
                </tr>
            </tbody>
                <% 
                karyawan.movenext
                loop
                %> 
            </table>
        </div>
    </div>
</div>
<!--#include file="../layout/footer.asp"-->
