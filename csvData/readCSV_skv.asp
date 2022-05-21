<!--#include file="cargo.asp" -->

<body>  
<%  


'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  

sFileName = Request.QueryString("sFileName")
'response.write sFileName & "<HR>"  
'*** Create Object ***'  
Set objFSO = CreateObject("Scripting.FileSystemObject")  
  
'*** Check Exist Files ***'  
If Not objFSO.FileExists(Server.MapPath(sFileName)) Then  
	Response.write("File not found.")  
Else  
  
'*** Open Files ***'  
Set oInStream = objFSO.OpenTextFile(Server.MapPath(sFileName),1,False)  


dim strtoday,hr,bl,th, serverID
' hr = right("00"&day(now),2)
' bl = right("00"&month(now),2)
' th = right("0000"&year(now),4)
' strtoday = bl &"/"& hr &"/"& th
' serverID = right("000"&session("server-ID"),3)

set cekPckID_cmd = server.CreateObject("ADODB.command")
cekPckID_cmd.activeConnection = MM_cargo_String
set expCsv_cmd = server.CreateObject("ADODB.command")
expCsv_cmd.activeConnection = MM_cargo_String

dim aID, aSPYN, aTanggal,aServID, aAsalCustID, aAsalAgenID, aAsalName, ckoli, ckilo, cnilai, ctgl

' aAsalCustID=trim(cust("Cust_ID"))'Request.Form("custIdNomor")
' aAsalAgenID=trim(Session("server-id"))
' aAsalName=trim(cust("Cust_Name"))
 
Do Until oInStream.AtEndOfStream  
	sRows = replace(oInStream.readLine,"'","")  
	sRows = replace(sRows,"""","")  
	sRows = replace(sRows,Chr(13),"")  
	arrRows = Split(sRows,";")  
	header=header+ 1

	if header >= 2 then 
		if not trim(arrRows(0)) = "" then  'cek kondisi jika packageID kosong tidak di input ke system

			'cekPckID_cmd.commandtext = "SELECT Tanggal FROM MKT_T_CSV_Rackindo WHERE (SJ = '"& trim(arrRows(11)) &"')"
			cekPckID_cmd.commandtext = "SELECT Sal_Insentif FROM HRD_T_salary_convert WHERE (Sal_Nip = '"& trim(arrRows(0)) &"')"
			set cekPckID = cekPckID_cmd.execute
			if not cekPckID.eof then

				
				expCsv_cmd.commandtext = " UPDATE HRD_T_Salary_convert SET Sal_Insentif = '"& trim(arrRows(1)) &"' WHERE Sal_Nip = '"& trim(arrRows(0)) &"' AND Sal_startDate = '"& trim(arrRows(2)) &"' "
				' Response.write(expCsv_cmd.commandtext) & "<BR><BR>"
				expCsv_cmd.execute

			end if
			cekPckID.close()

		end if  'end cek kondisi jika packageID kosong tidak di input di system
		
	end if

Loop 



oInStream.Close()  
Set fs = CreateObject("Scripting.FileSystemObject") 
set f = fs.GetFile(Server.MapPath(sFileName)) 

If (fs.FileExists(f))=true Then
    f.delete
End If

set fs = Nothing
set f = Nothing

Set oInStream = Nothing  

' response.Redirect("../mkt_t_econote_csv_upload_skv_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID)
response.Redirect("../importFile/index.asp")

End IF  
%>  
