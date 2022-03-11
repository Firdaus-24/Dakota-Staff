<!-- #include file='../connection.asp' -->
<% 
    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.activeConnection = MM_Cargo_string

    karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_Nip, GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama, HRD_M_Divisi.Div_Code, HRD_M_Divisi.DIv_Nama, HRD_M_Jabatan.Jab_Code, HRD_M_Jabatan.Jab_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_DIvisi ON HRD_M_karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_NIP NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_NIP NOT LIKE '%A%' ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
    ' Response.Write karyawan_cmd.commandText & "<br>"
    set karyawan = karyawan_cmd.execute

    response.ContentType = "application/json;charset=utf-8"
        response.write "["
            do while not karyawan.eof
            response.write "{"
				response.write """NAMA""" & ":" &  """" & karyawan("Kry_nama") &  """"  & ","
				response.write """NIP""" & ":" &  """" & karyawan("Kry_Nip") &  """"  & ","
				response.write """DIVCODE""" & ":" &  """" & karyawan("Div_CODE") &  """"  & ","
				response.write """DIVNAMA""" & ":" &  """" & karyawan("Div_Nama") &  """"  & ","
				response.write """AGENID""" & ":" &  """" & karyawan("Agen_ID") &  """"  & ","
				response.write """JABCODE""" & ":" &  """" & karyawan("Jab_Code") &  """"  & ","
				response.write """JABNAMA""" & ":" &  """" & karyawan("Jab_Nama") &  """"  & ","
				response.write """AGEN""" & ":" &  """" & karyawan("Agen_Nama") &  """"
            response.write "}"
            karyawan.movenext
            	if karyawan.eof = false then
					response.write ","
				end if 
            loop
        response.write "]"
 %>