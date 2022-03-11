<!--#include file="Connections/cargo.asp" -->
<!--#include file="secureString.asp" -->
<%

set cek_cmd = server.CreateObject("ADODB.command")
cek_cmd.activeConnection = MM_cargo_String


dim b, nip, imei1, simcard1
link = trim(request.form("nama"))

if link <> "" then

	b = split(trim(link),",")
	
	nip=trim(b(0)) 
	imei1=trim(b(1)) 
	simcard1=trim(b(2)) 

	cek_cmd.commandtext="SELECT Kry_NIP FROM HRD_M_Karyawan WHERE (Kry_NIP = '"& nip &"')"
	set cekKry = cek_cmd.execute
	
	if cekKry.eof then
		response.write "NIP Tidak Terdaftar"
	
	else
		cek_cmd.commandtext="UPDATE HRD_M_Karyawan SET Kry_Imei1 = '"& imei1 &"', Kry_SimcardID1 = '"& simcard1 &"' WHERE (Kry_NIP = '"& nip &"')"
		cek_cmd.execute
		
		response.redirect("hrd_m_kry_device_a.asp")
	end if
	
end if
%>