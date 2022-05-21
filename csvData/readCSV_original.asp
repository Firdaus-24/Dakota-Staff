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


set mkt_t_eConote_cmd = server.CreateObject("ADODB.command")
mkt_t_econote_cmd.activeConnection = MM_cargo_String
set hitungkode = server.CreateObject("ADODB.command")
hitungkode.activeConnection = MM_cargo_String
set hitungkodehist = server.CreateObject("ADODB.command")
hitungkodehist.activeConnection = MM_cargo_String
set mkt_t_eHistory_cmd = server.CreateObject("ADODB.command")
mkt_t_eHistory_cmd.activeConnection = MM_cargo_String
set update_econote = server.CreateObject("ADODB.command")
update_econote.activeConnection = MM_cargo_String
set cekSJ_cmd = server.CreateObject("ADODB.command")
cekSJ_cmd.activeConnection = MM_cargo_String

'command untuk asuransi
set Asuransi_cmd = server.CreateObject("ADODB.command")
Asuransi_CMD.activeConnection = MM_cargo_String

dim hID, hitunghist, kepalahist, kodehist, jmlhist
dim aID, aSPYN, aTanggal,aServID, aAsalCustID, aAsalAgenID, aAsalName, aAsalAlamat, aAsalKota, aAsalTelp, aTujuanCustID, aTujuanAgenID, aTujuanNama, aTujuanAlamat, aTujuanKota, aTujuanTelp, aTujuanKelurahan, aPembayaran, aUp, aKet, aNoSuratJalan, aNamaBarang, aJenisHarga, aJmlUnit, aBerat, aBeratvol, aHarga, aBiayaPenerus, aBiayaPacking, aKirimYN, aAgenYN, aAgenTime, aCustomerYN, aCustomerTime, aBayarYN, aPostingYN, aPostingTime, aAktifYN, aUpdateID, aUpdateTime, aService, aSMUNo, aCBYN, aPaketYN, aBAdm, aDisc, kepala, ekor,  hitung, btthash, aTujuanKecamatan, aTujuanPulau, aTujuanKodepos,aTagihTujuan

aTanggal=strtoday
aSPYN="N"
aAsalCustID=session("CID_CSV")'Request.Form("custIdNomor")
aAsalAgenID=Session("server-id")
aAsalName=Session("CNAMA_CSV")
aAsalAlamat="JAKARTA" 'Request.Form("custAlamat")
aAsalKota="JAKARTA"
aAsalTelp="-" 'Request.Form("custTelepon")
aTujuanCustID="0"
aTujuanAgenID="0" 'Request.Form("agenID")
aTujuanKelurahan="" 'Request.Form("tujuankelurahan")
aBeratvol="0" 'Request.Form("beratvolume")
aUkuran="0" 'Request.Form("volume")
aHarga="0" '(trim(Request.Form("biayaKirim")))
aBiayaPenerus="0" '(trim(Request.Form("lainlain")))
aPackingID="0" '(trim(Request.Form("packing")))
aKirimYN="N"
aAgenYN="N"
aAgenTime=month(now) & "/" & day(now) & "/" & year(now) & " " & time
aCustomerYN="N"
aCustomerTime=month(now) & "/" & day(now) & "/" & year(now) & " " & time
aPostingYN="N"
aPostingTime=month(now) & "/" & day(now) & "/" & year(now) & " " & time
aAktifYN="Y"
aUpdateID=session("username")
aUpdateTime=month(now) & "/" & day(now) & "/" & year(now) & " " & time
aSMUNo="" 'Request.Form("nosmu")
aCBYN="N"
aDisc="0" '(trim(Request.Form("potongan")))

aAsuransi="0" '(trim(request.Form("asuransi")))

aJenisHarga="" 'Request.Form("KdJenisHarga")
aPaketYN="" 'Request.Form("paketcarter")
aServID="1" 'Request.Form("KodeLayanan")
aPembayaran=2
aBayarYN="N"
aService="R"

aTujuanKodepos = "" 'Request.Form("kodepos")

kepala=serverID & bl & th
kepalahist=serverID & th & bl
 
%>  

 
<%  
Do Until oInStream.AtEndOfStream  
sRows = oInStream.readLine  
arrRows = Split(sRows,";")  
header=header + 1
%>  

<% if header > 1 then 

'response.write("surat jalan = "&arrRows(0)) & "<br>"
'response.write("btt id = "&arrRows(1)) & "<br>"
'response.write("btt tanggal = "&arrRows(2)) & "<br>"

tujRows = split(arrRows(3),"-")

'	response.write("btt tujuan propinsi = "&tujRows(0)) & "<br>"
'	response.write("btt tujuan kota = "&tujRows(1)) & "<br>"
'	response.write("btt tujuan kecamatan = "&tujRows(2)) & "<br>"

'response.write("jml koli = "&arrRows(4)) & "<br>"
'response.write("berat = "&arrRows(5)) & "<br>"
'response.write("nama barang = "&arrRows(6)) & "<br>"
'response.write("keterangan = "&arrRows(7)) & "<br>"
'response.write("harga barang = "&arrRows(8)) & "<br>"
'response.write("nama penerima = "&arrRows(9)) & "<br>"
'response.write("alamat penerima1 = "&arrRows(10)) & "<br>"
'response.write("alamat penerima2 = "&arrRows(11)) & "<br>"
'response.write("alamat penerima3 = "&arrRows(12)) & "<br>"
'response.write("telp penerima1 = "&arrRows(13)) & "<br>"
'response.write("telp penerima2 = "&arrRows(14)) & "<br>"
'response.write("fax penerima = "&arrRows(15)) & "<br>"
'response.write("email penerima = "&arrRows(16)) & "<br>"
'response.write("kontak penerima = "&arrRows(17)) & "<br>"

'response.write("")&"<hr>"


'-------------------------------------------------------INSERT MKT T ECONOTE----------------------------------------------------------------

aNoSuratJalan=arrRows(0)
'aTanggal=arrRows(2)
aTujuanPulau=replace(tujRows(0),"'","")
aTujuanKota=replace(tujRows(1),"Kota ","")
aTujuanKota=replace(aTujuanKota,"Kab. ","")
aTujuanKecamatan=tujRows(2)
aJmlUnit=arrRows(4) 
	if trim(aJmlUnit)="" then 
		aJmlUnit=1 
	end if
aBerat=arrRows(5) 
	if trim(aBerat)="" then 
		aBerat=1 
	end if


aNamaBarang=replace(arrRows(6),"'","")
aKet=replace(arrRows(7),"'","")
aTagihTujuan = replace(arrRows(8),"'","")
	if aTagihTujuan = "" then
		aTagihTujuan = 0
	end if	
aTujuanNama=replace(arrRows(9),"'","")
aUp=replace(arrRows(9),"'","")

aTujuanAlamat=replace(arrRows(10),"'","")
aTujuanTelp=replace(arrRows(13),"'","")

'response.write(aTujuanTelp) & "<br>"


cekSJ_cmd.commandtext = "SELECT BTTT_ID FROM MKT_T_eConote WHERE (BTTT_AsalCustID = '"& aAsalCustID &"') AND (BTTT_NoSuratJalan = '"& aNoSuratJalan &"')"
set cekSJ = cekSJ_cmd.execute
if cekSJ.eof then

'---GENERATE BTT ID
hitungkode.commandtext ="SELECT TOP 1 RIGHT(BTTT_ID, 6) AS eko FROM MKT_T_eConote WHERE (LEFT(BTTT_ID, 9) = '"& kepala &"') ORDER BY RIGHT(BTTT_ID, 6) DESC "
set jml = hitungkode.execute

if jml.eof=false then
	hitung = int(jml.fields("eko").value) + 1 
	ekor=right("000000"&hitung,6)
else
	hitung=0
	ekor="000001"	
end if

aID=kepala & aService & ekor
btthash=sha256(aID)
'Response.Write(aID) & "<br>"


'---INPUT TABEL BTT
mkt_t_eConote_cmd.commandtext ="INSERT INTO MKT_T_eConote (BTTT_ID, BTTT_SPYN, BTTT_Tanggal, BTTT_ServID, BTTT_AsalCustID, BTTt_AsalAgenID, BTTT_AsalName, BTTT_AsalAlamat, BTTT_AsalKota, BTTT_AsalTelp, BTTT_TujuanCustID, BTTt_TujuanAgenID, BTTT_TujuanNama, BTTT_TujuanAlamat, BTTT_TujuanKota, BTTT_TujuanTelp, BTTT_TujuanKelurahan, BTTT_TujuanKecamatan, BTTT_TujuanPulau, BTTT_TujuanKodepos, BTTT_Pembayaran, BTTT_Up, BTTT_Ket, BTTT_NoSuratJalan, BTTT_NamaBarang, BTTT_JenisHarga, BTTT_JmlUnit, BTTT_Berat, BTTT_Beratvol, BTTT_Ukuran, BTTT_Harga, BTTT_BiayaPenerus, BTTT_PackingID, BTTT_KirimYN, BTTT_AgenYN, BTTT_AgenTime, BTTT_CustomerYN, BTTT_CustomerTime, BTTT_BayarYN, BTTT_PostingYN, BTTT_PostingTime, BTTT_AktifYN, BTTT_UpdateID, BTTT_UpdateTime, BTTT_Service, BTTT_SMUNo, BTTT_CBYN, BTTT_PaketYN, BTTT_Disc, BTTT_Hash, BTTT_PrintCount,BTTT_TagihTujuan) VALUES ('"& aID &"', '"& aSPYN &"', '"& aTanggal &"', '"& aServID &"', '"& aAsalCustID &"', '"& aAsalAgenID &"', '"& aAsalName &"', '"& aAsalAlamat &"', '"& aAsalKota &"', '"& aAsalTelp &"', '"& aTujuanCustID &"', '"& aTujuanAgenID &"', '"& aTujuanNama &"', '"& aTujuanAlamat &"', '"& aTujuanKota &"', '"& aTujuanTelp &"', '"& aTujuanKelurahan &"', '"& aTujuanKecamatan &"','"& aTujuanPulau &"','"& aTujuanKodepos &"', '"& aPembayaran &"', '"& aUp &"', '"& aKet &"', '"& aNoSuratJalan &"', '"& aNamaBarang &"', '"& aJenisHarga &"', '"& aJmlUnit &"', '"& aBerat & "', '"& aBeratvol &"', '"& aUkuran &"' , convert(money, '"& aHarga &"'), convert(money,'"& aBiayaPenerus &"'), convert(money,'"& aPackingID &"'), '"& aKirimYN &"', '"& aAgenYN &"', '"& aAgenTime &"', '"& aCustomerYN &"', '"& aCustomerTime &"', '"& aBayarYN &"', '"& aPostingYN &"', '"& aPostingTime &"', '"& aAktifYN &"', '"& aUpdateID &"', '"& aUpdateTime &"', '"& aService &"', '"& aSMUNo &"', '"& aCBYN &"', '"& aPaketYN &"', '"& aDisc &"', '"& btthash &"', 0,convert(money,'"& aTagihTujuan &"')) "
mkt_t_eConote_cmd.execute
'response.Write Session("CNAMA_CSV") & "<BR>" '& mkt_t_eConote_cmd.commandtext & "<BR>" & "<BR>"
response.Write mkt_t_eConote_cmd.commandtext & "<BR>" & "<BR>"


'INPUT TABEL HISTORY
hitungkodehist.commandtext ="SELECT TOP 1 RIGHT(Hist_ID, 7) AS eko FROM MKT_T_eHistory WHERE (LEFT(Hist_ID, 9) = '"& kepalahist &"') ORDER BY RIGHT(Hist_ID, 7) DESC "
set jmlhist = hitungkodehist.execute
if jmlhist.eof=false then
	hitunghist = int(jmlhist.fields("eko").value) + 1 
	ekorhist=right("0000000"&hitunghist,7)
else
	hitunghist=0
	ekorhist="0000001"	
end if
hID = kepalahist & ekorhist
'Response.Write(hID) & "<br>"

mkt_t_eHistory_cmd.commandtext = "INSERT INTO MKT_T_eHistory (Hist_ID, Hist_BTTID, Hist_AgenID, Hist_StatUrut, Hist_Tanggal) VALUES ('"& hID &"', '"& aID &"', "& aAsalAgenID &", 0, '"& aTanggal &"') "
mkt_t_eHistory_cmd.execute
'response.Write mkt_t_eHistory_cmd.commandtext & "<BR>" & "<BR>" 


'UPDATE TABEL ECONOTE
update_econote.commandtext = "UPDATE MKT_T_eConote SET BTTT_HistID = '"& hID &"' WHERE BTTT_ID = '"& aID &"' "
update_econote.execute
'response.write update_econote.commandtext & "<BR>" & "<BR>" 

'insert into tabel asuransi KLM_T_Asuransi
'asuransi_cmd.commandtext ="INSERT INTO KLM_T_Asuransi(NoAsuransi, BTT_ID, BiayaAsuransi, PT_asuransi) VALUES ('"& aTanggal & "A" & aID &"', '"& aID &"', convert(money,'"& aAsuransi &"'), 'PT. ASURANSI')"
'response.write asuransi_cmd.commandtext
'asuransi_cmd.execute


'-----------------------------------------------------END INSERT MKT T ECONOTE----------------------------------------------------------------

response.write("")&"<hr>"

end if

end if
Loop  


oInStream.Close()  
Set oInStream = Nothing  

session("CID_CSV")=""
Session("CNAMA_CSV")=""

'response.Redirect("../mkt_t_econote.asp?vcustname="&aAsalName&"&tgla="&strtoday&"&tgle="&strtoday&"&ckcustomer=on&ckTanggal=on")
response.Redirect("../mkt_t_econote_csv_upload_d.asp?vcustname="&aAsalName&"&vcustid="&aAsalCustID&"&tgl="&strtoday)

End IF  
%>  
