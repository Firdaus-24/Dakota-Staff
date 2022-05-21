<!--#include file="cargo.asp" -->
<!--#include file="SecureHash.asp" -->

<body>  
<%  
'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = session("cID_csv") & "\" & Request.QueryString("sFileName")
  
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
dim header


header = 0

aAsalCustID=trim(session("CID_CSV"))'Request.Form("custIdNomor")
aAsalAgenID=trim(Session("server-id"))
aAsalName=trim(Session("CNAMA_CSV"))
 
%>  

<!--
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:80%">
-->
 
<%  
Do Until oInStream.AtEndOfStream  
sRows = oInStream.readLine  
arrRows = Split(sRows,",")  
header=header + 1
%>  



<% if header > 1 then 


%>
<!--
	<tr>	
		<td><%=trim(arrRows(0))%></td>
        <td><%=trim(arrRows(1))%></td>
        <td><%=trim(arrRows(2))%></td>
        <td><%=trim(arrRows(3))%></td>
        <td><%=trim(arrRows(4))%></td>
        <td><%=trim(arrRows(5))%></td>
        <td><%=trim(arrRows(6))%></td>
        <td><%=trim(arrRows(7))%></td>
        <td><%=trim(arrRows(8))%></td>
        <td><%=trim(arrRows(9))%></td>
        <td><%=trim(arrRows(10))%></td>
        <td><%=trim(arrRows(11))%></td>
        <td><%=trim(arrRows(12))%></td>
        <td><%=trim(arrRows(13))%></td>
        <td><%=trim(arrRows(14))%></td>
        <td><%=trim(arrRows(15))%></td>
        <td><%=trim(arrRows(16))%></td>
        <td><%=trim(arrRows(17))%></td>
		<td><%=trim(arrRows(18))%></td>
		<td><%=trim(arrRows(19))%></td>
		<td><%=trim(arrRows(20))%></td>
		<td><%=trim(arrRows(21))%></td>
		<td><%=trim(arrRows(22))%></td>
		<td><%=trim(arrRows(23))%></td>
		<td><%=trim(arrRows(24))%></td>
		<td><%=trim(arrRows(25))%></td>
		<td><%=trim(arrRows(26))%></td>
		<td><%=trim(arrRows(27))%></td>
		<td><%=trim(arrRows(28))%></td>
		<td><%=trim(arrRows(29))%></td>
		<td><%=trim(arrRows(30))%></td>
		<td><%=trim(arrRows(31))%></td>
		<td><%=trim(arrRows(32))%></td>
	</tr>
-->	

<%    
	Package_ID=replace(replace(trim(arrRows(28)),"'",""),"""","")
	Nama_Kota_Tujuan=replace(replace(trim(arrRows(13)),"'",""),"""","")
	Koli="1"
	Kilo="1"
	Deskripsi_Barang=replace(replace(trim(arrRows(22)),"'",""),"""","")
	Instruksi_Khusus=""
	if replace(replace(trim(arrRows(30)),"'",""),"""","")="N" then Nilai_Barang="0" else Nilai_Barang=replace(replace(trim(arrRows(25)),"'",""),"""","") end if
	Nama_Penerima=replace(replace(trim(arrRows(11)),"'",""),"""","")
	Alamat_Penerima1=replace(replace(trim(arrRows(12)),"'",""),"""","")
	Alamat_Penerima2=""
	Alamat_Penerima3=""
	Telepon_Penerima1="0"&replace(replace(trim(arrRows(16)),"'",""),"""","")
	Telepon_Penerima2=""
	Fax_Penerima=""
	Email_Penerima=""
	Kontak_Penerima="" 
	Cust_ID=aAsalCustID

'	response.write Nilai_Barang &"<br>"
	
	
	cekPckID_cmd.commandtext = "SELECT Package_ID FROM MKT_T_CSV_Lzd WHERE (Package_ID = '"& Package_ID &"')"
	set cekPckID = cekPckID_cmd.execute
	if cekPckID.eof then
	
    	'expCsv_cmd.commandtext = " INSERT INTO MKT_T_CSV_Lzd (Package_ID, Nama_Kota_Tujuan, Koli, Kilo, Deskripsi_Barang, Instruksi_Khusus, Nilai_Barang, Nama_Penerima, Alamat_Penerima1, Alamat_Penerima2, Alamat_Penerima3, Telepon_Penerima1, Telepon_Penerima2, Fax_Penerima, Email_Penerima, Kontak_Penerima, Cust_ID) VALUES ('"& Replace(Replace(trim(arrRows(0)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(3)),"'"," "),"""","") &"', "& ckoli &", "& ckilo &", '"& Replace(Replace(trim(arrRows(6)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(7)),"'"," "),"""","") &"', CONVERT (MONEY, "& cnilai &"), '"& Replace(Replace(trim(arrRows(9)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(10)),"'",""),"""","") &"', '"& Replace(Replace(trim(arrRows(11)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(12)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(13)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(14)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(15)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(16)),"'"," "),"""","") &"', '"& Replace(Replace(trim(arrRows(17)),"'"," "),"""","") &"', '"& aAsalCustID &"' )"
    	expCsv_cmd.commandtext = " INSERT INTO MKT_T_CSV_Lzd (Package_ID, Nama_Kota_Tujuan, Koli, Kilo, Deskripsi_Barang, Instruksi_Khusus, Nilai_Barang, Nama_Penerima, Alamat_Penerima1, Alamat_Penerima2, Alamat_Penerima3, Telepon_Penerima1, Telepon_Penerima2, Fax_Penerima, Email_Penerima, Kontak_Penerima, Cust_ID) VALUES ('"& Package_ID &"', '"& Nama_Kota_Tujuan &"', '"& Koli &"', '"& Kilo &"', '"& Deskripsi_Barang &"', '"& Instruksi_Khusus &"', '"& Nilai_Barang &"', '"& Nama_Penerima &"', '"& Alamat_Penerima1 &"', '"& Alamat_Penerima2 &"', '"& Alamat_Penerima3 &"', '"& Telepon_Penerima1 &"', '"& Telepon_Penerima2 &"', '"& Fax_Penerima &"', '"& Email_Penerima &"', '"& Kontak_Penerima &"', '"& Cust_ID &"') "
		'Response.write(expCsv_cmd.commandtext) & "<BR><BR>"
    	expCsv_cmd.execute
	
	end if
	cekPckID.close()
	
end if
Loop 

'Response.Write(header-1)
%>

<!--
</table>
-->

<%
oInStream.Close()  
Set oInStream = Nothing  

session("CID_CSV")=""
Session("CNAMA_CSV")=""

response.Redirect("../mkt_t_econote_csv_upload_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID)

End IF  
%>  
