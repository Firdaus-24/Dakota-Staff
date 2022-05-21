<!--#include file="cargo.asp" -->
<!--#include file="SecureHash.asp" -->

<body>  
<%  
'response.Buffer=true
server.ScriptTimeout=999999999
'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = "masterhargaunit\" +Request.QueryString("sFileName")
  
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

dim aID, aSPYN, aTanggal,aServID, aAsalCustID, aAsalAgenID, aAsalName, ckoli, ckilo, cnilai, ctgl
dim header


header = 0


 
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
       
	</tr>

-->
<%    
	
'	response.write Nilai_Barang &"<br>"
	
	
	cekPckID_cmd.commandtext = "delete MKT_M_eHarga_Unit where [agenID_asal] = '"& trim(arrRows(0)) &"' AND [servID] = '"& trim(arrRows(1)) &"' AND [Tujuan_Kecamatan] = '"& trim(arrRows(2)) &"' AND [Tujuan_Kabupaten] = '"& trim(arrRows(3)) &"' AND [Tujuan_Propinsi] = '"& trim(arrRows(4)) &"' AND [JenisUnit] = '"& trim(arrRows(5)) &"' AND [TypeUnit] = '"& trim(arrRows(6)) &"' AND [hargapokok] = '"& trim(arrRows(7)) &"' AND [estimasiHari] = '"& trim(arrRows(8)) &"' AND [keterangan] = '"& trim(arrRows(9)) &"' AND [Flag_DS] = '"& trim(arrRows(10)) &"'"
	set cekPckID = cekPckID_cmd.execute
	
	
    	expCsv_cmd.commandtext = " INSERT INTO MKT_M_eHarga_Unit VALUES ('"& Replace(Replace(trim(arrRows(0)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(1)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(2)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(3)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(4)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(5)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(6)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(7)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(8)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(9)),"'"," "),"""","") &"','"& Replace(Replace(trim(arrRows(10)),"'"," "),"""","") &"')"
'    	expCsv_cmd.commandtext = " INSERT INTO MKT_T_CSV_Lzd (Package_ID, Nama_Kota_Tujuan, Koli, Kilo, Deskripsi_Barang, Instruksi_Khusus, Nilai_Barang, Nama_Penerima, Alamat_Penerima1, Alamat_Penerima2, Alamat_Penerima3, Telepon_Penerima1, Telepon_Penerima2, Fax_Penerima, Email_Penerima, Kontak_Penerima, Cust_ID) VALUES ('"& Package_ID &"', '"& Nama_Kota_Tujuan &"', '"& Koli &"', '"& Kilo &"', '"& Deskripsi_Barang &"', '"& Instruksi_Khusus &"', '"& Nilai_Barang &"', '"& Nama_Penerima &"', '"& Alamat_Penerima1 &"', '"& Alamat_Penerima2 &"', '"& Alamat_Penerima3 &"', '"& Telepon_Penerima1 &"', '"& Telepon_Penerima2 &"', '"& Fax_Penerima &"', '"& Email_Penerima &"', '"& Kontak_Penerima &"', '"& Cust_ID &"') "
		'Response.write(expCsv_cmd.commandtext) & "<BR><BR>"
		expCsv_cmd.execute
	
	
	'cekPckID.close()
	
end if
Loop 

'Response.Write(header-1)
%>

<!--
</table>
-->
<%
if oInStream.AtEndOfStream  = true then
	response.write "PROSES SELESAI"
end if
oInStream.Close()  
Set oInStream = Nothing  




'response.Redirect("../mkt_t_econote_csv_upload_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID)

End IF  
%>  
