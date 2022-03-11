<!--#include file="../connection.asp" -->

	<%
	
	nip = trim(request.querystring("nip"))
	sql = "SELECT HRD_T_Absensi.Abs_NIP, HRD_T_Absensi.Abs_AgenID, HRD_T_Absensi.Abs_SyncToAdempiere, HRD_T_Absensi.Abs_datetime, HRD_T_Absensi.Abs_lat, HRD_T_Absensi.Abs_lon, GLB_M_Agen.Agen_Nama, HRD_M_Karyawan.Kry_Nama FROM HRD_T_Absensi LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Absensi.Abs_NIP = HRD_M_Karyawan.Kry_NIP LEFT OUTER JOIN GLB_M_Agen ON HRD_T_Absensi.Abs_AgenID = GLB_M_Agen.Agen_ID where abs_nip <> ''  " 
	orderby = " ORDER BY HRD_T_Absensi.Abs_NIP, HRD_T_Absensi.Abs_datetime desc" 
	
	filtertanggal = " and abs_dateTime between '01/"& right("00" & month(now()),2) &"/2020' and '"& now() &"' "
	filterNip = " and abs_nip = '"& nip &"' "
	Set cbSupir_cmd = Server.CreateObject ("ADODB.Command")
	cbSupir_cmd.ActiveConnection = MM_cargo_STRING
	cbSupir_cmd.CommandText = sql + filtertanggal + filternip + orderby
	
	'response.write cbSupir_cmd.CommandText & "<BR>"
	
	
	
	
	Set cbSupir = cbSupir_cmd.Execute
	%>
	
				<% 	
					response.ContentType = "application/json;charset=utf-8"
				response.write "["
				do while not cbSupir.eof
					response.write "{"
					
					response.write """NIP""" & ":" &  """" & cbSupir("abs_nip") &  """" & ","
					response.write """NAMA""" & ":" & """" & cbSupir("kry_nama") & """" & ","
					response.write """CABANGABSEN""" & ":" &  """" & cbSupir("agen_nama") &  """" & ","
					response.write """TANGGALJAMABSEN""" & ":" &  """" & cbSupir("abs_dateTime") &  """" & ","
					
					
					if cbSupir("Abs_SyncToAdempiere") = "H" then
					response.write """KETERANGAN""" & ":" & """H"""
					else
					response.write """KETERANGAN""" & ":" & """O"""
					end if
				  response.write "}"
				cbSupir.movenext
					if cbSupir.eof = false then
						response.write ","
					end if 
				loop
				response.write "]"
				
%>	
