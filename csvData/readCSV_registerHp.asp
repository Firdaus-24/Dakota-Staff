<!--#include file="cargo.asp" -->

<body>  
<%  
set cek_cmd = server.CreateObject("ADODB.command")
cek_cmd.activeConnection = MM_cargo_String

'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = "registerHp\" & Request.QueryString("sFileName")
response.write sFileName & "<HR>"  
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

'aAsalCustID=trim(cust("Cust_ID"))'Request.Form("custIdNomor")
'aAsalAgenID=trim(Session("server-id"))
'aAsalName=trim(cust("Cust_Name"))
 
%>  


<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:80%">
<tr><th>NIP</th><th>IMEI</th><th>SERIAL NUMBER</th><th>STATUS</th>
 
<%  
Do Until oInStream.AtEndOfStream  
sRows = oInStream.readLine  
arrRows = Split(sRows,";")  
header=header+ 1
%>  



<% if header >= 2 then 

if not trim(arrRows(0)) = "" then  'cek kondisi jika packageID kosong tidak di input ke system

		a = split(replace(trim(arrRows(0)),"""",""),",")
		nip=trim(a(0))
		imei1 = trim(a(1))
		simcard1 = trim(a(2))
%>

	<tr>
		<td><%=nip%></td>
		<td><%=imei1%></td>
		<td><%=simcard1%></td>
       
        <td>DONE</td>


        
        
        
    </tr>

<%    
		
		
	
		cek_cmd.commandtext="UPDATE HRD_M_Karyawan SET Kry_Imei1 = '"& imei1 &"', Kry_SimcardID1 = '"& simcard1 &"' WHERE (Kry_NIP = '"& nip &"')"
		'response.write cek_cmd.commandtext & "<BR>"
		
		cek_cmd.execute

end if  'end cek kondisi jika packageID kosong tidak di input di system
	
end if
Loop 


%>


</table>


<%
oInStream.Close()  
Set oInStream = Nothing  

'response.Redirect("../mkt_t_econote_csv_upload_SF_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID)

End IF  
%>  
