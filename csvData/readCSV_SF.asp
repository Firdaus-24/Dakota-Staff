<!--#include file="cargo.asp" -->

<body>  
<%  
dim cust_cmd, cust
Set cust_cmd = Server.CreateObject ("ADODB.Command")
cust_cmd.ActiveConnection = MM_cargo_STRING
cust_cmd.commandtext = "SELECT Cust_ID, Cust_Name FROM MKT_M_Customer WHERE (Cust_ID = '0010000011')"
set cust = cust_cmd.execute

'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = cust.fields.item("cust_ID") & "\" & Request.QueryString("sFileName")
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

aAsalCustID=trim(cust("Cust_ID"))'Request.Form("custIdNomor")
aAsalAgenID=trim(Session("server-id"))
aAsalName=trim(cust("Cust_Name"))
 
%>  


<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:80%">


 
<%  
Do Until oInStream.AtEndOfStream  
sRows = oInStream.readLine  
arrRows = Split(sRows,";")  
header=header+ 1
%>  



<% if header >= 7 then 

if not trim(arrRows(1)) = "" then  'cek kondisi jika packageID kosong tidak di input ke system
%>

	<tr>	
        <td><%=replace(trim(arrRows(1)),"""","")%></td> <%	'PACKAGE ID	%>
        <td><%=replace(trim(arrRows(3)),"""","")%></td> <%	'JUMLAH UNIT	%>
        <td><%=replace(replace(trim(arrRows(4)),"""",""),"KG","")%></td> <%	'BERAT	%>
        <td><%=replace(trim(arrRows(8)),"""","")%></td> <%	'TUJUAN NAMA	%>
        <td><%=replace(trim(arrRows(9)),"""","")%></td> <%	'TUJUAN ALAMAT	%>
        <td><%=replace(trim(arrRows(10)),"""","")%></td> <%	'TUJUAN TELPON	%>
        <td><%=replace(trim(arrRows(11)),"""","")%></td> <%	'NAMA BARANG	%>
        <td><%=replace(trim(left(arrRows(13),5)),"""","")%></td> <%	'TUJUAN KODEPOS	%>
<!--        <td><%=replace(trim(arrRows(9)),"""","")%></td> <%	'UP	%> 
        
        <td><%=replace(trim(arrRows(11)),"""","")%></td> <%	'TUJUAN KOTA	%>



        
        
        
        -->
	</tr>

<%    

	cekPckID_cmd.commandtext = "SELECT Package_ID FROM MKT_T_CSV_SF WHERE (Package_ID = '"& replace(trim(arrRows(1)),"""","") &"')"
	set cekPckID = cekPckID_cmd.execute
	if cekPckID.eof then

				
   	expCsv_cmd.commandtext = " INSERT INTO MKT_T_CSV_SF (Package_ID, Tujuan_Nama, Tujuan_Alamat, Tujuan_Kodepos, Tujuan_Telp, Nama_Barang, Koli, Kilo, Cust_ID) VALUES ('"& replace(trim(arrRows(1)),"""","") &"', '"& replace(trim(arrRows(8)),"""","") &"', '"& replace(trim(arrRows(9)),"""","") &"', '"& replace(trim(left(arrRows(13),5)),"""","") &"', '"& replace(trim(arrRows(10)),"""","") &"', '"& replace(trim(arrRows(11)),"""","") &"', '"& replace(trim(arrRows(3)),"""","") &"', '"& replace(replace(trim(arrRows(4)),"""",""),"KG","") &"', '"& aAsalCustID &"')"
	'Response.write(expCsv_cmd.commandtext) & "<BR><BR>"
    expCsv_cmd.execute
	
	end if
	cekPckID.close()

end if  'end cek kondisi jika packageID kosong tidak di input di system
	
end if
Loop 


%>


</table>


<%
oInStream.Close()  
Set oInStream = Nothing  

response.Redirect("../mkt_t_econote_csv_upload_SF_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID)

End IF  
%>  
