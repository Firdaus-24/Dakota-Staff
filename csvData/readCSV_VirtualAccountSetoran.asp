<!--#include file="../Connections/cargo.asp" -->
<!-- #include file="../updateLog.asp" -->

<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>

<body>  
<%  
Response.Expires = -1
Server.ScriptTimeout = 50000
dim cust_cmd, cust
Set cust_cmd = Server.CreateObject ("ADODB.Command")

'on error resume next
Dim objFSO,oInStream,sRows,arrRows  
Dim sFileName  
  
sFileName = "csvVirtualAccount\" & Request.QueryString("sFileName")
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

dim JurnalD,jurnalD_cmd,jurnalH,jurnalH_cmd
dim cAgenID, cTanggal, cKet, cTipe, cTotal, cPembuat, cUpdateID
dim cbid, nourut
Dim cashbank
Dim cashbank_cmd
DIM inputDetail
dim itemID
dim ItemID_cmd

set cekData_cmd = Server.CreateObject ("ADODB.Command")
cekData_cmd.ActiveConnection = MM_cargo_STRING

Set itemID_cmd = Server.CreateObject ("ADODB.Command")
itemID_cmd.ActiveConnection = MM_cargo_STRING

Set cashbank_cmd = Server.CreateObject ("ADODB.Command")
cashbank_cmd.ActiveConnection = MM_cargo_STRING

set inputDetail = server.CreateObject("ADODB.command")
			inputDetail.activeConnection = MM_cargo_String
			

set jurnalD_cmd = server.CreateObject("ADODB.command")
jurnalD_cmd.ActiveConnection = MM_cargo_STRING

set hitungJurNo_cmd = server.CreateObject("ADODB.command")
		hitungJurNo_cmd.activeConnection = MM_cargo_String

set insertJurH = server.CreateObject("ADODB.command")
		insertJurH.activeConnection = MM_cargo_String
		
set insertJurDD = server.CreateObject("ADODB.command")
	insertJurDD.activeConnection = MM_cargo_String

set insertJurDK = server.CreateObject("ADODB.command")
	insertJurDK.activeConnection = MM_cargo_String	
	
set updateCBH = server.CreateObject("ADODB.command")
	updateCBH.activeConnection = MM_cargo_String	
 
%>  


<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:80%">


 
<%  
Do Until oInStream.AtEndOfStream  
sRows = oInStream.readLine  
arrRows = Split(sRows,";")  
header=header+ 1
%>  



<% if header > 1 then 

'definisikan jurnalDetailnya



%>

	<tr>	
        <td><%=replace(trim(arrRows(0)),"""","")%></td> <%	'ID dari tanggal dan jam%>
		<td><%=replace(trim(arrRows(1)),"""","")%></td> <%	'Keterangan %>
        <td><%=replace(trim(arrRows(2)),"""","")%></td> <%	'Nominal	%>
        <td><%=replace(trim(arrRows(3)),"""","")%></td> <%	'Kode Debit	%>
        <td><%=replace(trim(arrRows(4)),"""","")%></td> <%	'Kode Kredit	%>
	</tr>
	<%
			'--CEK STATUS POSTING AKHIR BULAN'
			set user_cmd = server.CreateObject("ADODB.Command")
			user_cmd.activeConnection = MM_Cargo_String
			user_cmd.commandtext="SELECT Bulan FROM GLB_M_Closing WHERE Bulan = '"& month(replace(trim(arrRows(0)),"""","")) &"' AND Tahun = '"& year(replace(trim(arrRows(0)),"""","")) &"' AND AgenID = '"& int(session("server-id")) &"'"
			'response.write user_cmd.commandText & "<BR>"
			set cekPost = user_cmd.execute
			
			if not cekPost.eof then %>
	<tr bgcolor="#FF0000">
		<td colspan="5">Transaksi Untuk Periode Ini Sudah DiClosing, Silahkan Hubungi Petugas Akunting Kantor Pusat</td>
	</tr>
			
	
			<%else
			
			'cek apa sudah pernah diupload sblmnya
				cekData_cmd.commandText = "SELECT dbo.GL_T_CashBank.CB_Tanggal, dbo.GL_T_JurnalH.TJurH_Keterangan, dbo.GL_T_JurnalD.TJurD_AccCode, dbo.GL_T_CashBank.CB_Total FROM dbo.GL_T_CashBank LEFT OUTER JOIN dbo.GL_T_JurnalH ON dbo.GL_T_CashBank.CB_NoJurnal = dbo.GL_T_JurnalH.TJurH_No LEFT OUTER JOIN dbo.GL_T_JurnalD ON dbo.GL_T_JurnalH.TJurH_No = dbo.GL_T_JurnalD.TJurD_TJurHNo WHERE (dbo.GL_T_CashBank.CB_Tanggal = '"& replace(trim(arrRows(0)),"""","") &"') AND (dbo.GL_T_JurnalH.TJurH_Keterangan = '"& replace(trim(arrRows(1)),"""","") &"') AND (dbo.GL_T_CashBank.CB_Total = "& replace(trim(arrRows(2)),"""","") &")"	 					
				set cekData = cekData_cmd.execute
				'response.write cekData_cmd.commandText & "<BR>"
				if cekData.eof = false then
				%>
				<tr bgcolor="#FFF451"><td colspan="6">TIDAK DIPROSES, SUDAH DIUPLOAD SEBELUMNYA</td></tr>
				
				<%
				else 'kondisi dari cek data
					
					'cek item_ID nya brp dari GL_M_Item
					ItemID_cmd.commandText = "select item_ID FROM [dbs].[dbo].[GL_M_Item] where Item_OwnCAID = '"& replace(trim(arrRows(3)),"""","") &"' and Item_CashCAID = '"& replace(trim(arrRows(4)),"""","") &"'"
					set itemID = ItemID_cmd.execute
					
					%>
					<tr>
					<td colspan="3" align="right" >ItemID</td><td colspan="2"><%=itemID("item_ID")%></td>
					
					</tr>
					<%
					
					cAgenID = session("server-id")
					cTanggal = replace(trim(arrRows(0)),"""","")
					cKet = replace(replace(trim(arrRows(1)),"""",""),","," ")
					cTipe = "T"
					cTotal = replace(trim(arrRows(2)),"""","")
					cPembuat = session("username")
					cUpdateID = session("username")
					
					cashbank_cmd.commandtext = "sp_AddGL_T_CashBank '"& cAgenID &"', '"& cTanggal &"', '"& cKet &"', '"& cTipe &"', "& cTotal &", '"& cPembuat &"', '"& cUpdateID &"' "
					'response.Write(cashbank_cmd.CommandText) & "<br>"
					
					Set cashbank = cashbank_cmd.Execute
					
					cbid = cashbank.fields.item("id")
					nourut = cashbank.fields.item("Urutan")
					dItemID = itemID("item_ID")
					dKet = cKet
					dQuantity = 1
					dHargaSatuan = cTotal
					dAgenID = right("000"&session("server-id"),3)
					dSusutYN = "N"
					
			
					inputDetail.commandtext = "INSERT INTO GL_T_CashBankDetil (CBD_CBID, CBD_ItemID, CBD_Ket, CBD_Quantity, CBD_HargaSatuan, CBD_AgenID, CBD_SusutYN) VALUES ('"&  cbid &"', '"&  dItemID &"', '"&  dKet &"', "&  dQuantity &", CONVERT(MONEY, '"&  dHargaSatuan &"'), "&  int(dAgenID) &", '"&  dSusutYN &"') "
					'response.Write(inputDetail.commandtext) & "<br><BR>"
					inputDetail.execute	
			
					'updateLog system
					ip = Request.ServerVariables("remote_addr")
					browser = Request.ServerVariables("http_user_agent")
					dateTime = now()
					eventt = "CREATE"
					key = cbid
					url = ""
					call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser)
			
					
					
					%>	
			
			
			<tr>
				<td colspan="3" align="right">Jurnal</td>
				<td>Debet</td>
				<td>Kredit</td>
			</tr>
			<tr>
			
				<td colspan="3" align="right"><%=replace(trim(arrRows(3)),"""","")%></td>
				
				<td><%=replace(trim(arrRows(2)),"""","")%></td>
				<td></td>
				
				
			</tr>
			<%
			'definisikan detail jurnal kreditnya
			
			jurnalD_cmd.commandText = "select * from [dbs].[dbo].[GL_M_Item] where Item_OwnCAID = '"& replace(trim(arrRows(3)),"""","") &"' and Item_CashCAID like '%"& replace(trim(arrRows(4)),"""","") &"%'"
			set jurnalD = jurnalD_cmd.execute
			
			if not jurnalD.eof then
			%>
			<tr>
				<td colspan="3" align="right"><%=jurnalD("Item_CashCAID")%></td>
				
				<td></td>
				<td><%=replace(trim(arrRows(2)),"""","")%></td>
				
				
			</tr>
			
			<%'insert ke jurnal
			
			aktif = "Y"
			uid = Session("username")
			utime = month(now) & "/" & day(now) & "/" & year(now) & " " & time
			agenid = left(cbid,3)
			tgl = replace(trim(arrRows(0)),"""","")
			ket = replace(trim(arrRows(1)),"""","")
			bl = right("00" & month(replace(trim(arrRows(0)),"""","")),2)
			th = right(year(replace(trim(arrRows(0)),"""","")),2)
				'header jurnal
				
				hitungJurNo_cmd.commandtext = "SELECT TOP 1 CONVERT(int, RIGHT(TJurH_No, 5)) AS urut FROM GL_T_JurnalH WHERE (SUBSTRING(TJurH_No, 5, 3) = '"& agenid &"') AND (LEFT(TJurH_No, 2) = '"& th &"') AND (SUBSTRING(TJurH_No, 3, 2) = '"& bl &"') AND (SUBSTRING(TJurH_No, 8, 1) = 'T') ORDER BY RIGHT(TJurH_No, 5) DESC "
				'response.write hitungJurNo_cmd.commandText &"<BR>"
				set hitungJurNo = hitungJurNo_cmd.execute
				if hitungJurNo.eof then
					hitung = "00001"
				else 'hitungJurNo.eof
					hitung = right("00000"&(hitungJurNo.fields.item("urut")+1),5)
				end if 'hitungJurNo.eof
				jurno = th & bl & agenid & "T" & hitung

				insertJurH.commandtext = "INSERT INTO GL_T_JurnalH (TJurH_No, TJurH_Tanggal, TJurH_Keterangan, TJurH_Type, TJurH_DeleteYN, TJurH_PostYN, TJurH_SusutYN, TJurH_PostingYN, TJurH_UpdateID, TJurH_UpdateTime) VALUES ('"& jurno &"', '"& tgl &"', '"& ket &"', 'T', 'N', 'Y', 'N', 'N', '"& uid &"', '"& utime &"') "
				'response.Write(insertJurH.commandtext) & "<br><br>"
				insertJurH.execute
				
				'detail jurnal debit
				insertJurDD.commandtext = "INSERT INTO GL_T_JurnalD (TJurD_TJurHNo, TJurD_AccCode, TJurD_AgenID, TJurD_Keterangan, TJurD_Debet, TJurD_Kredit) VALUES ('"& jurno &"', '"& replace(trim(arrRows(3)),"""","") &"', "& int(agenid) &", '"& ket &"', CONVERT(MONEY, "& replace(trim(arrRows(2)),"""","") &"), 0) "
				'response.Write(insertJurDD.commandtext) & "<br>"
				insertJurDD.execute
				
				'detail jurnal kredit
				insertJurDK.commandtext = "INSERT INTO GL_T_JurnalD (TJurD_TJurHNo, TJurD_AccCode, TJurD_AgenID, TJurD_Keterangan, TJurD_Debet, TJurD_Kredit) VALUES ('"& jurno &"', '"& replace(trim(arrRows(4)),"""","") &"', "& int(agenid) &", '"& ket &"', 0, CONVERT(MONEY, "& replace(trim(arrRows(2)),"""","") &")) "
				'response.Write(insertJurDK.commandtext) & "<br>"
				insertJurDK.execute
				
				'update no jurnal di cashbank header
				updateCBH.commandtext = "UPDATE GL_T_CashBank SET CB_NoJurnal = '"& jurno &"', CB_PostYN = 'Y', CB_UpdateID = '"& uid &"', CB_UpdateTime = '"& utime &"' WHERE CB_ID = '"& cbid &"' "
				'response.Write(updateCBH.commandtext) & "<br><br>"
				updateCBH.execute
				
			
			end if
			end if %>
			<tr><td colspan="6"></td></tr>
			
		<%    
	end if 'selesai kondisi sudah diclosing/belum


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
