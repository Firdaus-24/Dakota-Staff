<!-- #include file='../connection.asp' -->
<% 
dim saldo, saldo_cmd
dim nip

nip = Request.QueryString("nip")
tahun = Request.QueryString("tahun")

set saldo_cmd = Server.CreateObject("ADODB.Command")
saldo_cmd.activeConnection = mm_cargo_string

saldo_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS jharicuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& tahun &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& tahun &"' AND HRD_T_IzinCutiSakit.ICS_PotongCuti <> '' AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' GROUP BY  HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC" 
' Response.Write saldo_cmd.commandText & "<br>"
set saldo = saldo_cmd.execute

saldo_cmd.commandText = "SELECT Kry_JmlCuti FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
set jmcuti = saldo_cmd.execute

jharicuti = 0
do while not saldo.eof
    jharicuti = jharicuti + (saldo("jharicuti") + 1)
saldo.movenext
loop
        sisacuti = int(jmcuti("Kry_JmlCuti")) - int(jharicuti)
        response.ContentType = "application/json;charset=utf-8"
      
		response.write "["
            response.write "{"
				response.write """SALDOCUTI""" & ":" &  """" & sisacuti &  """"  & ","
				response.write """JUMLAHCUTI""" & ":" &  """" & jmcuti("Kry_JmlCuti") &  """"  & ","
				response.write """CUTITERPAKAI""" & ":" &  """" & jharicuti &  """"
            response.write "}"
        response.write "]"
 %>