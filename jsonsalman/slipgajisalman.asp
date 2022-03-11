<!-- #include file='../connection.asp' -->
<% 
nip = trim(request.querystring("nip"))
tahun = Request.QueryString("tahun")

set slipgaji_cmd = Server.CreateObject("ADODB.COmmand")
slipgaji_cmd.ActiveConnection = MM_cargo_STRING

slipgaji_cmd.CommandText = "SELECT * FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& nip &"' AND Year(Sal_StartDate) = '"& tahun &"' AND month(Sal_StartDate) < '"& month(now()) &"' ORDER BY Sal_StartDate ASC"
' Response.Write slipgaji_cmd.commandText & "<br>"    
set gaji = slipgaji_cmd.execute
' tgl = month(now()) &"/"& day(11) & "/" & year(gaji("sal_startDate"))

    response.ContentType = "application/json;charset=utf-8"
	
    response.write "["
		do while not gaji.eof
		' if month(gaji("Sal_StartDate")) <> month(now()) And year(gaji("Sal_startDate")) = year(now()) then

            bpjsp = (gaji("Sal_gapok") / 100) * 4
            bpjsk = (gaji("Sal_gapok") / 100) * Cdbl(0.89)

			response.write "{"
					
			response.write """ID""" & ":" &  """" & gaji("Sal_Id") &  """" & ","
			response.write """GAPOK""" & ":" &  """" & gaji("Sal_gapok") &  """" & ","
			response.write """INSENTIF""" & ":" & """" & gaji("Sal_Insentif") & """" & ","
			response.write """THR""" & ":" &  """" & gaji("Sal_THR") &  """" & ","
			response.write """BPJSP""" & ":" &  """" & bpjsp &  """" & ","
			response.write """TRANSPORT""" & ":" &  """" & gaji("SAl_TunjTransport") &  """" & ","
			response.write """KESEHATAN""" & ":" &  """" & gaji("Sal_TunjKEsehatan") &  """" & ","
			response.write """KELUARGA""" & ":" &  """" & gaji("Sal_TunjKeluarga") &  """" & ","
			response.write """JABATAN""" & ":" &  """" & gaji("Sal_TunjJbt") &  """" & ","
			response.write """ASURANSI""" & ":" &  """" & gaji("Sal_asuransi") &  """" & ","
			response.write """JAMSOSTEK""" & ":" &  """" & gaji("Sal_Jamsostek") &  """" & ","
			response.write """KOPERASI""" & ":" &  """" & gaji("Sal_Koperasi") &  """" & ","
			response.write """KLAIM""" & ":" &  """" & gaji("Sal_Klaim") &  """" & ","
			response.write """BPJSK""" & ":" &  """" & bpjsk &  """" & ","
			response.write """PPH21""" & ":" &  """" & gaji("Sal_PPH21") &  """" & ","
			response.write """ABSENSI""" & ":" &  """" & gaji("Sal_Absen") &  """" & ","
			response.write """BULAN""" & ":" &  """" & MonthName(Month(gaji("sal_startDate"))) &  """" & ""

			response.write "}"		
		' end if
		gaji.movenext
			if gaji.eof = false then
				response.write ","
			end if 
		loop
		response.write "]"
 %>