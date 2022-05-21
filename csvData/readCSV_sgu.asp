<!--#include file="cargo.asp" -->
<!--#include file="../SecureString.asp" -->

<body>  
<%  


'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = "SGU\" & Request.QueryString("sFileName")
'response.write sFileName & "<HR>"  
'*** Create Object ***'  
Set objFSO = CreateObject("Scripting.FileSystemObject")  
  
'*** Check Exist Files ***'  
If Not objFSO.FileExists(Server.MapPath(sFileName)) Then  
Response.write("File not found.")  
Else  
  
'*** Open Files ***'  
Set oInStream = objFSO.OpenTextFile(Server.MapPath(sFileName),1,False)  


set cekPckID_cmd = server.CreateObject("ADODB.command")
cekPckID_cmd.activeConnection = MM_cargo_String
set expCsv_cmd = server.CreateObject("ADODB.command")
expCsv_cmd.activeConnection = MM_cargo_String


 

Do Until oInStream.AtEndOfStream  
	sRows = replace(oInStream.readLine,"'","")  
	sRows = replace(sRows,"""","")  
	sRows = replace(sRows,Chr(13),"")  
	arrRows = Split(sRows,";")  
	header=header+ 1

	if header >= 2 then
	
		ck=trim(arrRows(0))
		cekPckID_cmd.commandtext="SELECT SGUD_SGUID, SGUD_Angsuran, SGUD_Tahun, SGUD_Bulan, SGUD_Pokok, SGUD_Bunga FROM GL_T_SGUD WHERE (SGUD_SGUID = '"& trim(arrRows(0)) &"') AND (SGUD_Angsuran = '"& trim(arrRows(1)) &"') AND (SGUD_Tahun = '"& trim(arrRows(3)) &"') AND (SGUD_Bulan = '"& trim(arrRows(2)) &"')"
		set cekPckID=cekPckID_cmd.execute
		if cekPckID.eof then
		
			cekPckID_cmd.commandtext="INSERT INTO GL_T_SGUD (SGUD_SGUID, SGUD_Angsuran, SGUD_Tahun, SGUD_Bulan, SGUD_Pokok, SGUD_Bunga) VALUES ('"& trim(arrRows(0)) &"', '"& trim(arrRows(1)) &"', '"& trim(arrRows(3)) &"', '"& trim(arrRows(2)) &"', '"& trim(arrRows(4)) &"', '"& trim(arrRows(5)) &"')"
			'response.write cekPckID_cmd.commandtext &"<br>"
			cekPckID_cmd.execute

		end if
		
	end if

Loop 



oInStream.Close()  
Set oInStream = Nothing  

response.Redirect("../gl_t_sgu_e.asp?b="&encode(ck))

End IF  
%>  
