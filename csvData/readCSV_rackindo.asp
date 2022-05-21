<!--#include file="cargo.asp" -->

<body>  
<%  
dim cust_cmd, cust
Set cust_cmd = Server.CreateObject ("ADODB.Command")
cust_cmd.ActiveConnection = MM_cargo_STRING
'cust_cmd.commandtext = "SELECT Cust_ID, Cust_Name FROM MKT_M_Customer WHERE (Cust_ID = '2710000007')"
cust_cmd.commandtext = "SELECT Cust_ID, Cust_Name FROM MKT_M_Customer WHERE (Cust_ID = '5610000003')"
set cust = cust_cmd.execute

'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = cust.fields.item("cust_ID") & "\" & Request.QueryString("sFileName")
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
hr = right("00"&day(now),2)
bl = right("00"&month(now),2)
th = right("0000"&year(now),4)
strtoday = bl &"/"& hr &"/"& th
serverID = right("000"&session("server-ID"),3)

set cekPckID_cmd = server.CreateObject("ADODB.command")
cekPckID_cmd.activeConnection = MM_cargo_String
set expCsv_cmd = server.CreateObject("ADODB.command")
expCsv_cmd.activeConnection = MM_cargo_String

dim aID, aSPYN, aTanggal,aServID, aAsalCustID, aAsalAgenID, aAsalName, ckoli, ckilo, cnilai, ctgl

aAsalCustID=trim(cust("Cust_ID"))'Request.Form("custIdNomor")
aAsalAgenID=trim(Session("server-id"))
aAsalName=trim(cust("Cust_Name"))
 

Do Until oInStream.AtEndOfStream  
	sRows = replace(oInStream.readLine,"'","")  
	sRows = replace(sRows,"""","")  
	sRows = replace(sRows,Chr(13),"")  
	arrRows = Split(sRows,";")  
	header=header+ 1

	if header >= 2 then 

		if not trim(arrRows(1)) = "" then  'cek kondisi jika packageID kosong tidak di input ke system

			cekPckID_cmd.commandtext = "SELECT Tanggal FROM MKT_T_CSV_Rackindo WHERE (SJ = '"& trim(arrRows(11)) &"')"
			set cekPckID = cekPckID_cmd.execute
			if cekPckID.eof then

				
				'expCsv_cmd.commandtext = " INSERT INTO MKT_T_CSV_Rackindo (Tanggal, Penerima, Alamat, Kota, Telp, Kelurahan, Kecamatan, Propinsi, Kodepos, UP, Keterangan, SJ, Isi, Jml, Berat, Volume) VALUES ('"& trim(arrRows(0)) &"', '"& trim(arrRows(1)) &"', '"& trim(arrRows(2)) &"', '"& trim(arrRows(3)) &"', '"& trim(arrRows(4)) &"', '"& trim(arrRows(5)) &"', '"& trim(arrRows(6)) &"', '"& trim(arrRows(7)) &"', '"& trim(arrRows(8)) &"', '"& trim(arrRows(9)) &"', '"& trim(arrRows(10)) &"', '"& trim(arrRows(11)) &"', '"& trim(arrRows(12)) &"', '"& trim(arrRows(13)) &"', '"& trim(arrRows(14)) &"', '"& trim(arrRows(15)) &"') "
				expCsv_cmd.commandtext = " INSERT INTO MKT_T_CSV_Rackindo (Tanggal, Penerima, Alamat, Kota, Telp, Kelurahan, Kecamatan, Propinsi, Kodepos, UP, Keterangan, SJ, Isi, Jml, Berat, Volume) VALUES ('"& trim(arrRows(0)) &"', '"& left(trim(arrRows(1)),150) &"', '"& left(trim(arrRows(2)),250) &"', '"& left(trim(arrRows(3)),100) &"', '"& left(trim(arrRows(4)),100) &"', '"& left(trim(arrRows(5)),100) &"', '"& left(trim(arrRows(6)),100) &"', '"& left(trim(arrRows(7)),100) &"', '"& left(trim(arrRows(8)),10) &"', '"& left(trim(arrRows(9)),50) &"', '"& left(trim(arrRows(10)),150) &"', '"& left(trim(arrRows(11)),250) &"', '"& left(trim(arrRows(12)),150) &"', '"& trim(arrRows(13)) &"', '"& trim(arrRows(14)) &"', '"& trim(arrRows(15)) &"') "
				'Response.write(expCsv_cmd.commandtext) & "<BR><BR>"
				expCsv_cmd.execute
			
			end if
			cekPckID.close()

		end if  'end cek kondisi jika packageID kosong tidak di input di system
		
	end if

Loop 



oInStream.Close()  
Set oInStream = Nothing  

response.Redirect("../mkt_t_econote_csv_upload_rackindo_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID)

End IF  
%>  
