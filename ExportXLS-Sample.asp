<%@ Language=VBScript %>


<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=TEST FILE.xls"





%>

Laporan Absensi periode xxxx - xxxxx <br />
Nama Karyawan : <br>
NIP : <BR>

<hr />
<table width="100%" border="1">
<tr bgcolor="#999999">
    <td align="center">Package ID</td>
    <td align="center">Penerima</td>
    <td align="center">Alamat</td>
    <td align="center">Tujuan</td>
    <td align="center">Telepon</td>
    <td align="center">Nama Barang</td>
    <td align="center">Instruksi Khusus</td>
	
</tr>

<%
'do while not btt.eof
%>
	<tr>
    	<td><%'=btt.fields.item("Package_ID")%></td>
    	<td><%'=btt.fields.item("Nama_Penerima")%></td>
    	<td><%'=btt.fields.item("Alamat_Penerima1")%></td>
    	<td><%'=btt.fields.item("Nama_Kota_Tujuan")%></td>
    	<td><%'=btt.fields.item("Telepon_Penerima1")%></td>
    	<td><%'=btt.fields.item("Deskripsi_Barang")%></td>
        <td><%'=btt.fields.item("Instruksi_Khusus")%></td>
		
	</tr>
    
<%
'btt.movenext
'loop
%>
</table>

