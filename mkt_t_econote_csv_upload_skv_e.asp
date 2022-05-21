<!--#include file="Connections/cargo.asp" -->
	<!--#include file="secureString.asp" -->
    
   
<%
	' cek session PT ID

	set user_cmd = server.CreateObject("ADODB.Command")
	user_cmd.activeConnection = MM_Cargo_String
	user_cmd.commandtext = "select * from weblogin where PT_ID = '"& session("ValidatePTID") &"'"
	user_cmd.prepared=true
	set user = user_cmd.execute

	if user.eof = true then
		response.Redirect("logout.asp")
	end if

Set Connection = Server.CreateObject("ADODB.Connection")
	Connection.Open MM_Cargo_string
set rsButton = server.CreateObject("adodb.recordset")

%>   
   
   
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%>

<!-- template header, footer & menu -->



<head>
		<meta name="viewport" content="width=device-width">
	
	<link rel="stylesheet" type="text/css" href="css/style_t.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/styletable.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/properti.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/grid.css"/> <!-- CSS All -->
	<link href="css/mobile_t.css" rel="stylesheet" type="text/css" media="only screen and (max-width:768px)"> 
	<link href="css/menu_t.css" rel="stylesheet" type="text/css" media="only screen and (min-width:769px)">
	<!-- Tambahan -->
	<link rel="stylesheet" type="text/css" href="css/tcal.css" />
	<script type="text/javascript" src="js/jquery-1.4.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.8.min.js"></script>
	<script type="text/javascript" src="js/tcal.js"></script>

  <!--
<style>
  #draggable { width: 150px; height: 150px; padding: 0.5em; }
</style>
<script>
  $(function() {
    $( "#draggable" ).draggable();
  });
</script>  
  -->
  
<!-- digital clock -->
	<script type="text/javascript"> 
	function display_c(){
	var refresh=1000; // Refresh rate in milli seconds
	mytime=setTimeout('display_ct()',refresh)
	}

	function display_ct() {

	var x = new Date()
	var x1=x.getDate() + "/" + x.getMonth() + "/" + x.getFullYear() + " - " +  x.getHours( )+ ":" +  x.getMinutes() + ":" +  x.getSeconds(); 


	document.getElementById('ct').innerHTML = x1;
	tt=display_c();
	 }
	</script>

	
	<%
	Dim serverID
	Dim cabang
	Dim cabang_cmd

	dim bulan
	dim tanggal

	serverID = right("000"&session("server-ID"),3)

	Set cabang_cmd = Server.CreateObject ("ADODB.Command")
	cabang_cmd.ActiveConnection = MM_cargo_STRING
	cabang_cmd.CommandText = "select Agen_Nama, agen_id from GLB_M_Agen WHERE (Agen_AktifYN = 'Y') ORDER BY Agen_Nama" 
	Set cabang = cabang_cmd.Execute
	set cabangasal = cabang_cmd.execute	
	

	dim b
	b= decode(request.QueryString("b"))

	'response.write b & "<HR>"
	'isi textfield
	dim hr, bl, th
	dim etgl, ebtt, ehist, ekredityn
	dim eplg, ekdplg, enmplg, ealmplg, ektplg, etlpplg, elayanan, oplayanan, ekdlayanan
	dim eagen, ekdagen, enmpenerima, eup, ealmpenerima, etlppenerima, ektpenerima, ekecpenerima,ekelpenerima, ekdpos, epulau 
	dim ecarteryn, ejncarter, eservis, enosmu, eisi, enosj, eketerangan, ejmlunit, eberatasli, eberatvol, ekubik, ejnskiriman, ekdkiriman
	dim ekdpembayaran, ejnspembayaran, ebiaya, epenerus, epacking, ettlbiaya, ediskon, ejumlah, ejdiskon, etotal


	dim btt_cmd, btt
	Set btt_cmd = Server.CreateObject ("ADODB.Command")
	btt_cmd.ActiveConnection = MM_cargo_STRING
	btt_cmd.CommandText = "SELECT MKT_M_Customer.Cust_Name, BTTT_AsalEmail, BTTT_TujuanEmail, GLB_M_Agen.Agen_Nama, MKT_M_Customer.Cust_KreditYN, MKT_T_eConote.BTTT_ID, MKT_T_eConote.BTTT_Tanggal, MKT_T_eConote.BTTT_ServID, MKT_T_eConote.BTTT_NoBTTManual, MKT_T_eConote.BTTT_AsalCustID, MKT_T_eConote.BTTt_AsalAgenID, MKT_T_eConote.BTTT_AsalName, MKT_T_eConote.BTTT_AsalAlamat, MKT_T_eConote.BTTT_AsalKota, MKT_T_eConote.BTTT_AsalTelp, MKT_T_eConote.BTTT_TujuanCustID, MKT_T_eConote.BTTt_TujuanAgenID, MKT_T_eConote.BTTT_TujuanNama, MKT_T_eConote.BTTT_TujuanAlamat, MKT_T_eConote.BTTT_TujuanKota, MKT_T_eConote.BTTT_TujuanTelp, MKT_T_eConote.BTTT_TujuanKelurahan, MKT_T_eConote.BTTT_TujuanKecamatan, MKT_T_eConote.BTTT_TujuanPulau, MKT_T_eConote.BTTT_TujuanKodepos, MKT_T_eConote.BTTT_Pembayaran, MKT_T_eConote.BTTT_Up, MKT_T_eConote.BTTT_Ket, MKT_T_eConote.BTTT_NoSuratJalan, MKT_T_eConote.BTTT_NamaBarang, MKT_T_eConote.BTTT_JenisHarga, MKT_T_eConote.BTTT_JmlUnit, MKT_T_eConote.BTTT_JmlPck, MKT_T_eConote.BTTT_Berat, MKT_T_eConote.BTTT_Beratvol, MKT_T_eConote.BTTT_Ukuran, MKT_T_eConote.BTTT_Harga, MKT_T_eConote.BTTT_BiayaPenerus, MKT_T_eConote.BTTT_BayarYN, MKT_T_eConote.BTTT_PostingYN, MKT_T_eConote.BTTT_AktifYN, MKT_T_eConote.BTTT_CBYN, MKT_T_eConote.BTTT_Disc, MKT_T_eConote.BTTT_HistID, MKT_T_eConote.BTTT_Service, MKT_T_eConote.BTTT_SMUNo, MKT_T_eConote.BTTT_TagihTujuan,  PCK_T_Packing.PCK_ID, PCK_T_Packing.PCK_Biaya, GLB_M_Agen_1.Agen_Nama AS AsalAgen FROM MKT_T_eConote LEFT OUTER JOIN GLB_M_Agen AS GLB_M_Agen_1 ON MKT_T_eConote.BTTt_AsalAgenID = GLB_M_Agen_1.Agen_ID LEFT OUTER JOIN PCK_T_Packing ON MKT_T_eConote.BTTT_PackingID = PCK_T_Packing.PCK_ID LEFT OUTER JOIN GLB_M_Agen ON MKT_T_eConote.BTTt_TujuanAgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN MKT_M_Customer ON MKT_T_eConote.BTTT_AsalCustID = MKT_M_Customer.Cust_ID WHERE BTTT_ID= '"& b &"' " 
	'Response.Write(btt_cmd.CommandText) & "<br><br>"
	Set btt = btt_cmd.Execute

'if trim(btt("BTTT_AsalCustID"))<>"2710000007" then
'if trim(btt("BTTT_AsalCustID"))<>"5610000003" then
if trim(btt("BTTT_AsalCustID"))<>"5610000004" then
	response.write "Invalid Customer"
else

	Set inv_cmd = Server.CreateObject ("ADODB.Command")
	inv_cmd.ActiveConnection = MM_cargo_STRING
	inv_cmd.CommandText = "SELECT ART_T_InvoiceD.ARTID_BTTID, ART_T_InvoiceH.ARTIH_Delete FROM ART_T_InvoiceD LEFT OUTER JOIN ART_T_InvoiceH ON ART_T_InvoiceD.ARTID_ARTIHID = ART_T_InvoiceH.ARTIH_ID WHERE (ART_T_InvoiceH.ARTIH_Delete <> 'Y') AND (ART_T_InvoiceD.ARTID_BTTID = '"& b &"') " 
	Set inv = inv_cmd.Execute

	if btt.fields.item("BTTT_CBYN") = "Y" then
		Response.Write("Transaksi Sudah di Closing")
	'	Response.AddHeader "Refresh", "3;URL=mkt_t_econote.asp" 	
	elseif not inv.eof then
		Response.Write("BTT Ini Sudah Dibuat Invoice")
	'	Response.AddHeader "Refresh", "3;URL=mkt_t_econote.asp" 
	else

	bl = month(btt.fields("BTTT_Tanggal").value)
	if len(bl) < 2 then
		bl = "0" & bl
	end if
	hr = day(btt.fields("BTTT_Tanggal").value)
	if len(hr) < 2 then
		hr = "0" & hr
	end if
	th = year(btt.fields("BTTT_Tanggal").value)

	'etgl = month(btt.fields("BTTT_Tanggal").value) &"/"& day(btt.fields("BTTT_Tanggal").value) &"/"& year(btt.fields("BTTT_Tanggal").value)
	etgl = bl &"/"& hr &"/"& th
	ebtt = btt.fields("BTTT_ID").value
	eplg = btt.fields("Cust_Name").value 
	ekdplg = btt.fields("BTTT_AsalCustID").value 
	enmplg = btt.fields("BTTT_AsalName").value 
	ealmplg = btt.fields("BTTT_AsalAlamat").value 
	ektplg = btt.fields("BTTT_AsalKota").value 
	etlpplg = btt.fields("BTTT_AsalTelp").value 
	'elayanan = 
	ekdlayanan = btt.fields("BTTT_ServID").value 

	if isnull(btt.fields("Agen_Nama").value) then
		eagen = ""
	else
		eagen = btt.fields("Agen_Nama").value 
	end if
	ekredityn = btt.fields("Cust_KreditYN").value 

	ekdagen = btt.fields("BTTT_TujuanAgenID").value 
	enmpenerima = btt.fields("BTTT_TujuanNama").value 
	eup = btt.fields("BTTT_Up").value 
	ealmpenerima = btt.fields("BTTT_TujuanAlamat").value 
	etlppenerima = btt.fields("BTTT_TujuanTelp").value 
	ektpenerima = btt.fields("BTTT_TujuanKota").value 
	ekecpenerima = btt.fields("BTTT_TujuanKecamatan").value 
	ekelpenerima = btt.fields("BTTT_TujuanKelurahan").value 
	ekdpos = btt.fields("BTTT_TujuanKodepos").value 
	epulau = btt.fields("BTTT_TujuanPulau").value 

	'ecarteryn = btt.fields("BTTT_PaketYN").value 
	'ejncarter = 
	eservis = btt.fields("BTTT_Service").value 
	enosmu = btt.fields("BTTT_SMUNo").value 
	eisi = btt.fields("BTTT_NamaBarang").value 
	enosj = btt.fields("BTTT_NoSuratJalan").value 
	eketerangan = btt.fields("BTTT_Ket").value 
	ejmlunit = btt.fields("BTTT_JmlUnit").value 
	eberatasli = btt.fields("BTTT_Berat").value 
	eberatvol = btt.fields("BTTT_Beratvol").value 
	ekubik = btt.fields("BTTT_Ukuran").value 
	ekdkiriman = btt.fields("BTTT_JenisHarga").value 
	ehist = btt.fields("BTTT_HistID").value
	
	eNoBttManual = btt.fields("BTTT_NoBTTmanual").value

	ekdpembayaran = btt.fields("BTTT_Pembayaran").value 
	ebiaya = btt.fields("BTTT_Harga").value 
	epenerus = btt.fields("BTTT_BiayaPenerus").value 
	if (isnull(btt("PCK_Biaya"))) or (trim(btt("PCK_Biaya"))="") then
		epacking = 0
	else 
		epacking = btt.fields("PCK_Biaya").value 
	end if
	ejumlah = ebiaya + epenerus + epacking
	etotal = ejumlah
	ecod = btt.fields.item("BTTT_TagihTujuan")
	
	easalcbnm = btt("AsalAgen")
	easalcbkd = btt("BTTT_AsalAgenID")
	%>


	<!-- javascript enter sebagai tab -->
	<script type='text/javascript' src="js/enterToTab.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$("input").not( $(":button") ).keypress(function (evt) {
		  if (evt.keyCode == 13) {
			iname = $(this).val();
			if (iname !== 'Submit'){  
			  var fields = $(this).parents('form:eq(0),body').find('button,input,textarea,select');
			  var index = fields.index( this );
			  if ( index > -1 && ( index + 1 ) < fields.length ) {
				fields.eq( index + 1 ).focus();
			  }
			  return false;
			}
		  }
		});
		});

	</script>





<!-- CSS form aplikasi -->
<style>


.carter
{
	visibility:hidden;
}

#txtHint
{
	width:auto;
	border-radius:5px;
	box-shadow:15px 15px 15px 1px;
	position:absolute;
	top:10%;
	left:38%;
	color:#000;
	background-color:#CCC;
	font-size:110%;
	z-index:0;
}

#txtHint2
{
	width:auto;
	border-radius:5px;
	box-shadow:15px 15px 15px 1px;
	position:absolute;
	top:82%;
	left:38%;
	color:#000;
	background-color:#CCC;
	font-size:110%;
	z-index:0;
}


#bantuan
{
	top:15%;
	right:0%;
	
	width: 350px; height: 150px; 
	background-color:#FFF;
	overflow:auto;
	font-size:100%;

	border-radius:0.1em;
	padding-left:10px;
	padding-right:5px;
	box-shadow:3px 3px 3px 3px;
	z-index:88;
}

#smuNoLabel
{
	visibility:hidden;
}
#smuNoInput
{
	visibility:hidden;
}
#kreditYNdiv
{
/*	visibility:hidden; */
	visibility:hidden;
}

	
#txtkdpos
{
	overflow:auto;
	overflow-x:hidden;
}

#txtcustomer
{
	overflow:auto;
	overflow-x:hidden;
}

		
	
/* end format form css */	

</style>
<!--
<script>
  $(function() {
    $( "#bantuan" ).draggable();
  });
  </script>

-->

	<!-- ajax untuk memfilter nama customer  -->
	<script>
	function showumum(agen)
	{
//	alert(agen);
	var xmlhttp;    
	document.getElementById("CustID").value="";
	document.getElementById("custIDNomor").value="";
	if (agen=="")
	  {
	  document.getElementById("CustID").value="";
	  document.getElementById("custIDNomor").value="";
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  	{
		document.getElementById("CustID").value="UMUM";
		document.getElementById("custIDNomor").value=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","get-btt_edit_set_umum.asp?agen="+agen,true);
	xmlhttp.send();
	
	}
	</script>




	<!-- ajax untuk memfilter nama customer  -->
	<script>
	function showCustomer(str,agen)
	{
	document.getElementById('custIDNomor').value="";
	var xmlhttp;    
	if (str=="")
	  {
	  document.getElementById("txtcustomer").innerHTML="";
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		document.getElementById("txtcustomer").innerHTML=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","get-btt_edit_cust.asp?q="+str+"&agen="+agen,true);
	xmlhttp.send();
	}
	</script>


	<!-- ajax untuk memfilter Kota  -->

	<script>
	function showKota(kota,agen)
	{
	var xmlhttp;    
	if (kota=="")
	  {
	  document.getElementById("txtHint2").innerHTML="";
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		document.getElementById("txtHint2").style.padding = "35px";	
		document.getElementById("txtHint2").innerHTML=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","get-kota.asp?k="+kota+"&a="+agen,true);
	xmlhttp.send();
	}
	</script>

	<!-- ajax untuk mengambil agen_ID  -->

	<script>
	function showAgen(Agen)
	{
	var xmlhttp;    
	if (Agen=="")
	  {
	  document.getElementById("agenID").value = "";
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		document.getElementById("agenID").value=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","get-agenID.asp?agen="+Agen,true);
	xmlhttp.send();
	}
	</script>


    <!-- ajax untuk mengambil agen_ID  -->
	<script>
	function showPacking(pck,cust)
	{
	var xmlhttp;    
	if (pck=="")
	  {
	  document.getElementById("bpacking").value = "0";
	  document.getElementById("txtpacking").innerHTML="";
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		document.getElementById("txtpacking").innerHTML=xmlhttp.responseText;
		}
	  }
	  
	 //alert("get-BiayaPacking.asp?pck="+pck+"&cust="+cust); 
	xmlhttp.open("GET","get-BiayaPacking.asp?pck="+pck+"&cust="+cust,true);
	xmlhttp.send();
	}
	</script>

<script>
function parseValue(pckID,pckBiaya)
{
	document.getElementById('pckID').value = pckID;
	document.getElementById('bpacking').value = pckBiaya;
	document.getElementById('txtpacking').innerHTML = "";

}

</script>


	<!-- mengambil nilai ajax yang di clik kedalam text box nama kota -->

	<script type="text/javascript">
	function KotaName(Kota)
	{
		document.getElementById("tujuankota").value = Kota;
		document.getElementById("txtHint2").innerHTML="";
		document.getElementById("txtHint2").style.padding = "0px";

	}
	</script>


	<!-- input numeric only -->

	<script>
	function isNumberKey(evt){
		var charCode = (evt.which) ? evt.which : event.keyCode
		if (charCode > 31 && (charCode < 48 || charCode > 57))
		{
			return false;
		}
		return true;
	}    
	</script>

	<!-- hidden visible pilihan carter -->
	<script type="text/javascript">
		function carter()
		{
			document.getElementById("carter").style.visibility = "visible";
		}
		
		function paket()
		{
			document.getElementById("carter").style.visibility = "hidden";
		}
	</script>

	<!-- hitung total biaya kirim yang harus dibayarkan -->
	<script type="text/javascript">
	function totalbiaya()
	{
		document.getElementById("SumBiaya").value = parseInt(document.getElementById("biayaKirim").value) + parseInt(document.getElementById("lainlain").value) + parseInt(document.getElementById("bpacking").value);
		document.getElementById("jumlahbayar").value = document.getElementById("SumBiaya").value;
	}
	</script>

	<!-- hitung keseluruhan biaya kirim yang harus dibayarkan -->
	<script type="text/javascript">
	function jumlahbayarall()
	{
		var potongan = parseInt(document.getElementById("potongan").value);
		var sumbiaya = parseInt(document.getElementById("SumBiaya").value);
		if (potongan > 0 )
		{
		potongan = (potongan/100)*sumbiaya;
		document.getElementById("jumlahbayar").value = sumbiaya - potongan;
		document.getElementById("potonganRP").value = potongan;
		}
		else
		{
		document.getElementById("jumlahbayar").value = sumbiaya;
		}
	}

	</script>

	<!-- hitung keseluruhan berat/colly/volume -->
	<script type="text/javascript">
	function jumlahberatall()
	{
		document.getElementById("totalBerat").value = (parseInt(document.getElementById("beratAsli").value) + parseInt(document.getElementById("beratVolume").value)+ parseInt(document.getElementById("volume").value))
	}

	</script>


	<!-- javascript pengambilan kode jenis harga -->
	<script type="text/javascript">
	function kodeHarga(kode)
	{
		if(kode == "BERAT")
		{
			document.getElementById("KdJenisHarga").value = "0";
		}
		else if(kode == "KUBIKASI")
		{
			document.getElementById("KdJenisHarga").value = "1";
		}
		else
		{
			document.getElementById("KdJenisHarga").value = "2";
		}
		
	}
	</script>

	<!-- javascript pengambilan kode jenis layanan -->
	<script type="text/javascript">
	function jenisLayanan(kode)
	{
		if(kode == "Darat")
		{
			document.getElementById("KodeLayanan").value = "1";
			document.getElementById("smuNoLabel").style.visibility = 'hidden';
			document.getElementById("smuNoInput").style.visibility = 'hidden';
			document.getElementById("svclaut").style.visibility = 'hidden';
		}
		else if(kode == "Laut")
		{
			document.getElementById("KodeLayanan").value = "2";
			document.getElementById("smuNoLabel").style.visibility = 'hidden';
			document.getElementById("smuNoInput").style.visibility = 'hidden';
			document.getElementById("svclaut").style.visibility = 'visible';
		}
		else
		{
			document.getElementById("KodeLayanan").value = "3";
			document.getElementById("smuNoLabel").style.visibility = 'visible';
			document.getElementById("smuNoInput").style.visibility = 'visible';
			document.getElementById("svclaut").style.visibility = 'hidden';
		}
		
	}
	</script>

	<!-- javascript pengambilan kode jenis pembayaran -->
	<script type="text/javascript">
	function caraBayar(kode)
	{
		if(kode == "TUNAI")
		{
			document.getElementById("MetodeBayar").value = "1";
			document.getElementById("MetodeBayarYN").value = "Y";
		}
		else if(kode == "KREDIT")
		{
			document.getElementById("MetodeBayar").value = "2";
			document.getElementById("MetodeBayarYN").value = "N";
		}
		else
		{
			document.getElementById("MetodeBayar").value = "3";
			document.getElementById("MetodeBayarYN").value = "N";
		}
	}
	</script>

	<!-- javascript pengambilan jenis service -->
	<script type="text/javascript">
	function jenisService(kode)
	{
		if(kode == "REGULER")
		{
			document.getElementById("serviceid").value = "R";
		}
		else if(kode == "ONS")
		{
			document.getElementById("serviceid").value = "O";
		}
		else if(kode == "SAMEDAY")
		{
			document.getElementById("serviceid").value = "S";
		}
		else
		{
			document.getElementById("serviceid").value = "T";
		}
	}
	</script>


	<!-- javascript pengambilan jenis layanan -->
	<script type="text/javascript">
	function jenisPaketCarter(kode)
	{

		if(kode == "paket")
		{
			document.getElementById("pilihcarter").disabled = true;
		}
		else
		{
			document.getElementById("pilihcarter").disabled = false;
		}
	}
	</script>

	<!-- kasih petunjuk hint
	<script type="text/javascript">
	function tanggal()
	{
		document.getElementById("bantuan").innerHTML = "Anda diminta untuk memasukkan tanggal yang di pilih dari kalender yang muncul disebelah kanan bawah. Format dari tanggal ini adalah MM/DD/YYYY atau Bulan, tanggal dan tahun.";
	}

	function pengirim()
	{
		document.getElementById("bantuan").innerHTML = "Ketikkan nama PT, CV, atau Nama Pelanggan maka bantuan akan muncul, kemudian pilih dengan MOUSE pelanggan yang akan di buatkan BTT";
	}

	function nama()
	{
		document.getElementById("bantuan").innerHTML = "Nama dari pengirim yang menyerahkan barang langsung, Wajib di isi. Mohon perhatiannya ! untuk customer UMUM, nama penyerah barang harus di isi";
	}

	function alamat()
	{
		document.getElementById("bantuan").innerHTML = "Jika ada perubahan data dari customer, anda harus memberikan informasi kepada bagian piutang supaya data customer selalu ter-update";
	}

	function jalur()
	{
		document.getElementById("bantuan").innerHTML = "Pilih jalur pengiriman yang diinginkan oleh customer, bisa melalui darat, laut dan udara. Untuk pengiriman Udara, Kolom No. SMU dapat dikosongkan dan di isi setelah nanti mendapatkan nomor SMU paket.";
	}

	function service()
	{
		document.getElementById("bantuan").innerHTML = "Pilih layanan jasa yang diinginkan pelanggan sesuai dengan kemungkinan jarak tempuh antara daerah asal kirim dan tujuan yang paling rasional" + "<br>" + "<b>Reguler</b> : 3-5 hari atau tanpa janji waktu" + "<BR>" + "<b>TDS</b> : barang yang diterima di cabang pada hari itu akan mencapai tujuan atau penerima tidak lebih dari 2 hari kerja." + "<BR>" + "<B>Overnight</b> : Barang akan diterima 1 hari 1 malam setelah barang terhitung sejak tanggal barang diterima" + "<BR>" + "<B>ONS</B> : Barang yang di kirim akan diterima oleh penerima ke'esokan hari nya terhitung dari tanggal barang diterima" ;
	}

	function sj()
	{
		document.getElementById("bantuan").innerHTML = "Masukkan nomor surat jalan yang disertakan dalam dokumen barang/paket yang di kirim" ;
	}

	function keterangan()
	{
		document.getElementById("bantuan").innerHTML = "Informasi-informasi singkat lain yang mungkin diperlukan untuk memperjelas paket / kiriman" ;
	}

	function isiKiriman()
	{
		document.getElementById("bantuan").innerHTML = "<u>Staff Marketing</u> wajib untuk menanyakan isi dari paket kiriman yang terbungkus atau lainnya dan memberikan pernyataan tertulis jika diperlukan apabila isi kiriman tidak diperiksa terlebih dahulu" ;
	}

	function jenisharga()
	{
		document.getElementById("bantuan").innerHTML = "Pilih satuan yang digunakan untuk pengiriman paket/barang kiriman" ;
	}

	function unit()
	{
		document.getElementById("bantuan").innerHTML = "Sesuaikan jumlah unit / koli barang atau paket dengan jumlah asli yang akan di kirim, pastikan tidak ada kesalahan." ;
	}

	function berat()
	{
		document.getElementById("bantuan").innerHTML = "Sesuaikan berat barang atau paket dengan berat asli yang akan di kirim, pastikan tidak ada kesalahan." ;
	}

	function beratvolume()
	{
		document.getElementById("bantuan").innerHTML = "Sesuaikan berat volume barang atau paket dengan nilai asli yang akan di kirim, pastikan tidak ada kesalahan." ;
	}

	function vol()
	{
		document.getElementById("bantuan").innerHTML = "Sesuaikan kubikasi / volume barang atau paket dengan kubikasi / volume asli yang akan di kirim, pastikan tidak ada kesalahan." ;
	}

	function cabangagen()
	{
		document.getElementById("bantuan").innerHTML = "Pilih cabang/agen/counter penerima barang atau lokasi barang turun di tempat tujuan jangan sampai ada kesalahan" ;
	}

	function namapenerima()
	{
		document.getElementById("bantuan").innerHTML = "Masukkan nama tujuan pengiriman barang/paket dengan jelas dan tepat" ;
	}

	function namaup()
	{
		document.getElementById("bantuan").innerHTML = "Masukkan nama penerima barang/paket di tempat tujuan dengan jelas dan tepat. <u>UP = Untuk Penerima</u>" ;
	}

	function alamatpenerima()
	{
		document.getElementById("bantuan").innerHTML = "Masukkan alamat tujuan pengiriman barang/paket dengan jelas dan tepat, hindari penggunaan singkatan yang tidak sesuai" ;
	}



	</script>

	<script type="text/javascript">
	function hideBantuan()
	{
		document.getElementById("bantuan").style.visibility=hidden;
	}
	</script>
	 -->

	<!-- Form Validation -->
	<script type="text/javascript">
	function checkForm(f)
	{
		if (f.elements['tanggalStart'].value == "" && f.elements['tanggalStart'].value == "")
		{
			alert("Tanggal harus di isi");
			document.getElementById("tanggalStart").focus();
			return false;
		}
		else if (f.elements['CustID'].value == "" && f.elements['CustID'].value == "")
		{
			alert("Nama pengirim harus di isi");
			document.getElementById("CustID").focus();
			return false;
		}
		else if (f.elements['custName'].value == "" && f.elements['custName'].value == "")
		{
			alert("Nama orang yang menyerahkan barang/paket harus di isi / no KTP (opsional)");
			return false;
		}
		else if (f.elements['custAlamat'].value == "" && f.elements['custAlamat'].value == "")
		{
			alert("Alamat pengirim harus di isi dengan lengkap, dan jelas");
			return false;
		}
		else if (f.elements['kota'].value == "" && f.elements['kota'].value == "")
		{
			alert("Kota lokasi pengirim harus di isi");
			return false;
		}
		else if (f.elements['Jenis Layanan'].value == "" && f.elements['Jenis Layanan'].value == "")
		{
			alert("Jenis Layanan harus dipilih");
			return false;
		}
		else if (f.elements['custTelepon'].value == "" && f.elements['custTelepon'].value == "")
		{
			alert("Nomor Telepon Pengirim harus di isi");
			return false;
		}
		else if (f.elements['isi'].value == "" && f.elements['isi'].value == "")
		{
			alert("Isi kiriman wajib di isi, tanyakan dengan jelas dan lengkap kepada customer pengirim");
			document.getElementById("isi").focus();
			return false;
		}
	/*	
		else if (f.elements['total'].value == 0 || f.elements['total'].value == 'NaN')
		{
			alert("Parameter Koli'an(UNIT) / Berat Asli / Berat Volume / Kubikasi minimal salah satu harus di isi");
			document.getElementById("colly").focus();
			return false;
		}
	*/	
		else if (f.elements['tujuannama'].value == '') 
		{
			alert("Nama Penerima harus di isi dengan lengkap dan jelas");
			document.getElementById("tujuannama").focus();
			return false;
		}
		else if (f.elements['tujuanup'].value == '') 
		{
			alert("Nama Penerima paket/barang ditempat tujuan harus di isi dengan lengkap dan jelas");
			document.getElementById("tujuanup").focus();
			return false;
		}
		else if (f.elements['TujuanAlamat'].value == '') 
		{
			alert("Alamat Tujuan harus di isi lengkap, jelas, dan teliti");
			document.getElementById("TujuanAlamat").focus();
			return false;
		}
		else if (f.elements['tujuankelurahan'].value == '') 
		{
			alert("Kelurahan tujuan pengiriman harus di isi, hindari singkatan untuk mempermudah pengantaran barang / paket kiriman");
			document.getElementById("tujuankelurahan").focus();
			return false;
		}
		else if (f.elements['tujuantelp'].value == '') 
		{
			alert("Nomor telepon penerima barang/paket kiriman wajib di isi, untuk mempermudah pengantaran barang / paket kiriman");
			document.getElementById("tujuantelp").focus();
			return false;
		}
		else if (f.elements['biayaKirim'].value == '0') 
		{
			alert("Biaya pengiriman tidak boleh = 0");
			document.getElementById("biayaKirim").focus();
			return false;
		}
		else if (f.elements['tujuankota'].value == '') 
		{
			alert("Kota Tujuan Pengiriman harus di isi dengan baik dan benar");
			document.getElementById("tujuankota").focus();
			return false;
		}
		
		
		
		else
		{
			f.submit();
			return false;
		}
	}

	</script>

	<!-- javascript uppercase letter -->
	<script type="application/javascript">
	function uppercase(string)
		{
			string.value=string.value.toUpperCase();
		}
	</script>

	<!-- Fungsi Terbilang -->
	<script type="text/javascript" src="js/terbilang.js"></script>
	<script type="text/javascript">
	 function ubah(){
	 //memanggil fungsi terbilang() dari file terbilang.js
	 var nilai = document.getElementById("jumlahbayar").value;
	 var hasil = terbilang(nilai);
	 var hasil_div= document.getElementById('txtTerbilang');
	 //masukkan hasil konversi ke dalam hasil_div
	 hasil_div.innerHTML = hasil + " rupiah";
	 }
	</script>

	<script>

	function showKelurahan(kelurahan,kecamatan,kodepos,provinsi,kota)
	{
	//document.getElementById('tujuankelurahan').value = "";
	//document.getElementById('tujuankecamatan').value = "";
	//document.getElementById('kodepos').value = "";
	//document.getElementById('pulau').value = "";
	//document.getElementById('tujuankota').value = "";
	var xmlhttp;    
	if ((provinsi=="") && (kelurahan=="") && (kecamatan=="") && (kodepos=="") && (kota==""))
	  {
	  document.getElementById("kelurahan").innerHTML="";
	  document.getElementById("kelurahan").height='0px';
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		document.getElementById("kelurahan").innerHTML=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","GetKodePos.asp?kelurahan="+kelurahan+"&kecamatan="+kecamatan+"&kodepos="+kodepos+"&provinsi="+provinsi+"&kota="+kota,true);
	xmlhttp.send();

	}
	</script>

	<!-- javascript validasi kredit -->
	<script type="application/javascript">
	function cekkredit()
	{
		if(document.getElementById('vcustkredit').value == 'Y')
		{
			document.getElementById('kreditYNdiv').style.visibility = 'visible';	
		}
		else
		{
			document.getElementById('kreditYNdiv').style.visibility = 'hidden';
			document.getElementById('pembayaranTunai').checked = true ; 
		}
	}
	</script>

</head>

<body onLoad="eConoteNumber();display_ct();ubah();">
<div class="wrap-90">
		<!--<div id="label">  <span id="ct" ></span> </div>-->
	<div class="row">
		<header class="kepala tengah">
			<div class="kep-jud"> <h2>MARKETING - INPUT - eBTT MANUAL</h2> </div>
			<div><%=b%> [<%=session("cabang")%>] user login [<%=session("username") %> ]</div><span id="ct" ></span>
		</header>
	</div>
	<hr />

    <!-- bagian opsi pilihan filter -->
    <form name="formEconote" action="p-mkt_t_econote_csv_upload_skv_e.asp" method="post" id="commentForm" onSubmit="return checkForm(this); return false;">
 

	<fieldset>
		<legend>TANGGAL PENGIRIMAN BARANG</legend>
		<div class="row col-12">
			<div class="col-3">
				<labeL>TANGGAL :</labeL>
				<input name="tanggalStart" id="tanggalStart" type="text" size="15" onFocus="tanggal();" required value="<%=etgl%>" readonly/>
				<input type="hidden" name="nomorBTT" id="nomorBTT" hidden="" value="<%=ebtt%>" >
				<input type="hidden" name="histBTT" id="histBTT" hidden="" value="<%=ehist%>" >
				<input name="email" id="email" type="hidden" maxlength="150" value="<%=btt("BTTT_AsalEmail")%>" >
				<input name="tujuanemail" id="tujuanemail" type="hidden" maxlength="150" value="<%=btt("BTTT_TujuanEmail")%>" >
			</div>
            
            <div class="col-3">
				<label>CABANG / AGEN ASAL :</label>
					<select  name="cbgasal" id="cbgasal" onBlur="showumum(this.value);" readonly onChange="showumum(this.value);">
						<option value="<%=easalcbkd%>"><%=easalcbnm%></option>

					</select>
                
				
			</div>
            
		</div>
	</fieldset>

	<fieldset>
	<legend>INFORMASI PENGIRIM BARANG</legend>
		<div class="row col-12">
			<div class="col-6">
				<div id="txtcustomer"></div>
			</div>
		</div>
		<div class="row col-12">
			<div class="col-4">
				<label>PELANGGAN :</label>
				<input size="35" id="CustID" name="CustID" type="text" onKeyDown="showCustomer(this.value,document.getElementById('cbgasal').value);" onKeyPress="showCustomer(this.value,document.getElementById('cbgasal').value)" onKeyUp="showCustomer(this.value,document.getElementById('cbgasal').value);"  onClick="pengirim();" value="<%=eplg%>" readonly/>
			</div>
			<div class="col-2">
				<label>Cust ID</label>
				<input type="text" size="8" id="custIDNomor" name="custIDNomor" value="<%=ekdplg%>" readonly>
				<input type="hidden" size="1" value="<%=ekredityn%>" name="vcustkredit" id="vcustkredit" hidden="">
			
				
			</div>	
			<div class="col-4">
				<label>NAMA PENGIRIM :</label>
				<input name="custName" id="custname" type="text" size="35" onFocus="nama();" onClick="cekCustomer();" maxlength="30" 
				value="<%=enmplg%>"/>
			</div>
		</div>
		<div class="row col-12">
			<div class="col-6">
				<label>ALAMAT :</label>
				<textarea name="custAlamat" id="custalamat"  onFocus="alamat();"  /><%=ealmplg%></textarea>
			</div>
		</div>
		<div class="row col-12">
			<div class="col-3">
				
				<label>KOTA :</label>
				<input name="kota" id="custkota" type="text" onFocus="alamat();"  size="35" maxlength="20"  value="<%=ektplg%>"/>
			</div>
			<div class="col-3">
				<label>TELEPON :</label>
				<input name="custTelepon" type="text" id="custtel" onFocus="alamat();" size="15" maxlength="15"  value="<%=etlpplg%>"/>
			</div>
			<div class="col-3">
				<%
					if ekdlayanan="1" then
						oplayanan="Darat"
					elseif ekdlayanan="2" then
						oplayanan="Laut"
					elseif ekdlayanan="3" then
						oplayanan="Udara"
					end if
				%>
				<label>LAYANAN : </label>
				<select name="layanan" onFocus="jalur();" id="layanan" onChange="jenisLayanan(this.value)" onBlur="jenisLayanan(this.value)">
					<option value="<%=oplayanan%>"><%=oplayanan%></option>
						<option value="Darat">Darat</option>
						<option value="Laut">Laut</option>
						<option value="Udara">Udara</option>
					  </select>
				<input type="hidden" id="KodeLayanan" name="KodeLayanan"  size="2"  hidden="" value="<%=ekdlayanan%>">
			</div>
		</div>
	</fieldset>

	<fieldset>
	<legend>INFORMASI PENERIMA BARANG</legend>
		<div class="row col-12">
			
			<div class="col-4">
				<label>NAMA PENERIMA BARANG :</label>
				<input id="tujuannama" name="tujuannama" type="text" size="35" onFocus="namapenerima();" maxlength="30" value="<%=enmpenerima%>"/>
			</div>	
			<div class="col-4">	
				<label>UP / DITUJUKAN KEPADA :</label>
				<input id="tujuanup" name="tujuanup" type="text" size="15" onFocus="namaup();" maxlength="50" value="<%=eup%>"/>
			</div>		
		</div>		
		<div class="row col-12">
			<div class="col-6">	
				<label>ALAMAT PENERIMA :</label>
				<textarea id="TujuanAlamat" name="TujuanAlamat" onFocus="alamatpenerima();"  /><%=ealmpenerima%></textarea>
			</div>
			<div class="col-6">
				<label>TELEPON :</label>
				<textarea name="tujuantelp"  id="tujuantelp2"  onKeyPress="return isNumberKey(event)"><%=etlppenerima%></textarea>
			</div>
		</div>
		<div class="row col-12">
			<div class="col-3">
				<label>PROPINSI :</label>
				<input id="pulau" name="pulau" type="text" value="<%=epulau%>" onKeyPress="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyDown="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyUp="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" readonly/>
			</div>	
			<div class="col-3">
				<label>KOTA :</label>
				<input name="tujuankota" id="tujuankota" type="text" value="<%=ektpenerima%>" onKeyPress="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyDown="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyUp="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" readonly />
			</div>	
			<div class="col-3">
				<label>KECAMATAN :</label>
				<input name="tujuankecamatan" id="tujuankecamatan" type="text" value="<%=ekecpenerima%>" onKeyPress="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyDown="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyUp="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" readonly />
			</div>
			<div class="col-2">
				<label>KELURAHAN :</label>
				<input name="tujuankelurahan" id="tujuankelurahan" type="text" value="<%=ekelpenerima%>" onKeyPress="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyDown="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyUp="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" />
			</div>	
			<div class="col-1">
				<label>KODEPOS:</label>
				<input type="text" id="kodepos" name="kodepos" value="<%=ekdpos%>" onKeyPress="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyDown="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" onKeyUp="showKelurahan(document.getElementById('tujuankelurahan').value,document.getElementById('tujuankecamatan').value,document.getElementById('kodepos').value,document.getElementById('pulau').value,document.getElementById('tujuankota').value)" />
				
			</div>
		</div>
		<div class="row col-12">
			<div class="col-6">
				<label>CABANG / AGEN PENERIMA :</label>
				<select name="cabang" id="cabang" onChange="showAgen(this.value)" onBlur="showAgen(this.value)" onFocus="cabangagen();">
				<option value="<%=eagen%>"><%=eagen%></option>
				<option value=""></option>
				<% While NOT cabang.EOF %>
					<option value="<%=(cabang.Fields.Item("Agen_nama").Value)%>"><%=(cabang.Fields.Item("Agen_nama").Value)%></option>
				<% cabang.MoveNext() %>                
				<% wend %>  
				</select>
				<input type="hidden" size="5" name="agenID" id="agenID" value="<%=ekdagen%>" readonly >
			</div>
		</div>
		<div class="row col-12" style="overflow: auto;">
				<div id="kelurahan"></div>
		</div>
	</fieldset>

	<fieldset>
	<legend>INFORMASI PENGIRIMAN BARANG</legend>
		<div class="row col-12">
			<div class="col-2">
				<label>JENIS PELAYANAN :</label>
				<div class="row space">
				<input name="Jenis Layanan" type="radio" id="JenisLayanan_0" onBlur="jenisPaketCarter('paket')" onChange="jenisPaketCarter('paket')" onClick="paket();" value="paket" checked="checked" />
				PAKET 
				<input name="Jenis Layanan" type="radio" id="JenisLayanan_1" onBlur="jenisPaketCarter('carter')" onChange="jenisPaketCarter('carter')" onClick="carter();" value="carter" />
				CARTER 
				</div>
			</div>
			<div class="col-1">
				<label>Carter</label>
				<select name="Carter" id="pilihcarter">
						<option value=""></option>
						<option value="BuiltUp">Built Up</option>
						<option value="ColtDiesel">Colt Diesel</option>
						<option value="Fuso">Fuso</option>
						<option value="Freezer Box">Freezer Box</option>
						<option value="Tronton">Tronton</option>
						<option value="Wingbox">Wing Box</option>
				</select>  
				<input type="hidden" name="paketcarter" id="paketcarter" hidden="" value="Y">
			</div>
			<div class="col-5">
				<label>SERVICE :</label>
				<div class="row space">
				<% if eservis="R" then%>
					<input onFocus="service()" type="radio" name="JenisPaket" value="REGULER" id="JenisPaket_0" onChange="jenisService(this.value)" onClick="jenisService(this.value)" checked="checked"/>REGULER 
					<input onFocus="service()" type="radio" name="JenisPaket" value="TWODAYS" id="JenisPaket_1" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />TWO DAYS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="ONS" id="JenisPaket_2" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />ONS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="SAMEDAY" id="JenisPaket_3" onChange="jenisService(this.value)" onClick="jenisService(this.value)" /> SAME DAY

				<% elseif eservis="T" then%>
					<input onFocus="service()" type="radio" name="JenisPaket" value="REGULER" id="JenisPaket_0" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />REGULER 
					<input onFocus="service()" type="radio" name="JenisPaket" value="TWODAYS" id="JenisPaket_1" onChange="jenisService(this.value)" onClick="jenisService(this.value)" checked="checked"/>TWO DAYS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="ONS" id="JenisPaket_2" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />ONS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="SAMEDAY" id="JenisPaket_3" onChange="jenisService(this.value)" onClick="jenisService(this.value)" /> SAME DAY

				<% elseif eservis="O" then%>
					<input onFocus="service()" type="radio" name="JenisPaket" value="REGULER" id="JenisPaket_0" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />REGULER  
					<input onFocus="service()" type="radio" name="JenisPaket" value="TWODAYS" id="JenisPaket_1" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />TWO DAYS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="ONS" id="JenisPaket_2" onChange="jenisService(this.value)" onClick="jenisService(this.value)" checked="checked"/>ONS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="SAMEDAY" id="JenisPaket_3" onChange="jenisService(this.value)" onClick="jenisService(this.value)" > SAME DAY

				<% elseif eservis="S" then%>
					<input onFocus="service()" type="radio" name="JenisPaket" value="REGULER" id="JenisPaket_0" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />REGULER  
					<input onFocus="service()" type="radio" name="JenisPaket" value="TWODAYS" id="JenisPaket_1" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />TWO DAYS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="ONS" id="JenisPaket_2" onChange="jenisService(this.value)" onClick="jenisService(this.value)" />ONS 
					<input onFocus="service()" type="radio" name="JenisPaket" value="SAMEDAY" id="JenisPaket_3" onChange="jenisService(this.value)" onClick="jenisService(this.value)" checked="checked"/> SAME DAY
					
				<%end if%>
				</div>
				<input type="hidden" name="service" id="serviceid" hidden="" value="<%=eservis%>" >
			</div>		
		
			<div class="col-2">
				<label><div id="smuNoLabel">NO. SMU</div></label>
				<div id="smuNoInput">
					<input name="nosmu" type="text" onFocus="jalur()" size="15" class="noSmu" value="<%=enosmu%>"/>
				</div>
			</div>
			
		</div>
		<div class="row col-12">
			<div class="col-4">
				<label>ISI KIRIMAN :</label>
				<input name="isi" id="isi" type="text" onFocus="isiKiriman()" size="35" maxlength="30" value="<%=eisi%>"/>
			</div>
			<div class="col-4">
				<label>NO. SURAT JALAN :</label>
				<textarea name="NoSJ" onFocus="sj();"  /><%=enosj%></textarea>
			</div>
			<div class="col-4">
				<label>KETERANGAN :</label>
				<textarea name="ket" onFocus="keterangan()"><%=eketerangan%></textarea>
			</div>
		</div>
		<div class="row col-12">
			<div class="col-3">
				<label>JML BARANG:</label>
				<input name="colly" type="text" id="colly" onFocus="if(this.value=='0') this.value='';unit();" onBlur="if(this.value=='') this.value='0';" onKeyPress="return isNumberKey(event)" onKeyDown="jumlahberatall()" onKeyUp="jumlahberatall()" size="5" maxlength="5" value="<%=ejmlunit%>" readonly/>Koli
			</div>
			<div class="col-3">
				<label>BERAT ASLI:</label>
				<input name="beratAsli" id="beratAsli" type="text" onKeyPress="return isNumberKey(event)" onKeyUp="jumlahberatall()" onKeyDown="jumlahberatall()" onFocus="if(this.value=='0') this.value='';berat();" onBlur="if(this.value=='') this.value='0';" size="5" value="<%=eberatasli%>"  <%
			'cek kondisi hak akses tombol
			sqlButton = "SELECT username FROM WebRights where username ='"& session("username") &"' and serverID = '"& session("server-ID") &"' and appIDRights = 'E2b2'"

			rsButton.open sqlButton, connection
			
			if rsButton.eof = true then
			
			%>
            readonly
            
            <% end if
			rsButton.close
			 %>/>Kilogram
			</div>
			<div class="col-3">
				<label>BERAT VOLUM:</label>
				<input name="beratVolume" id="beratVolume" type="text" onKeyPress="return isNumberKey(event)" onKeyUp="jumlahberatall()" onKeyDown="jumlahberatall()" onFocus="if(this.value=='0') this.value='';beratvolume();" onBlur="if(this.value=='') this.value='0';" size="5" value="<%=eberatvol%>" <%
			'cek kondisi hak akses tombol
			sqlButton = "SELECT username FROM WebRights where username ='"& session("username") &"' and serverID = '"& session("server-ID") &"' and appIDRights = 'E2b3'"

			rsButton.open sqlButton, connection
			
			if rsButton.eof = true then
			
			%>
            readonly
            
            <% end if
			rsButton.close
			 %>/>Kilogram / m3
			</div>
		</div>
		<div class="row col-12">
			
				<%	if ekdkiriman="0" then %>
				<div class="col-3">
					<label>JENIS KIRIMAN : </label>
					<div class="row space">
						<input type="radio" name="KdJenisHarga" id="KdJenisHarga1" value="0" checked>BERAT
					
						<input type="radio" name="KdJenisHarga" id="KdJenisHarga3" value="2" >UNIT/KOLI
					</div>
				</div>
					
					<div id="svclaut" style="visibility:hidden">    
						<div class="col-2">
							<div class="row space">   
								<input type="radio" name="KdJenisHarga" id="KdJenisHarga2" value="1" >KUBIKASI
							</div>
						</div>
							<div class="col-3">
							<label>KUBIKASI : </label>
						
							<input name="volume" id="volume" type="text" onKeyPress="return isNumberKey(event)" value="0" onKeyUp="jumlahberatall()" onKeyDown="jumlahberatall()" onFocus="if(this.value=='0') this.value='';vol();" onBlur="if(this.value=='') this.value='0';" size="5" />m3 
							</div>				
					</div>				
										
						
				<% elseif ekdkiriman="1" then %>
				<div class="col-3">
					<label>JENIS KIRIMAN : </label>
					<div class="row space">
						<input type="radio" name="KdJenisHarga" id="KdJenisHarga1" value="0" >BERAT
					
						<input type="radio" name="KdJenisHarga" id="KdJenisHarga3" value="2" >UNIT/KOLI
					</div>
				</div>
					
					<div id="svclaut" style="visibility:visible">    
						<div class="col-2">
							<div class="row space">
								<input type="radio" name="KdJenisHarga" id="KdJenisHarga2" value="1" checked>KUBIKASI
							</div>
						</div>
					<div class="col-3">
						<label>KUBIKASI : </label>
						
						<input name="volume" id="volume" type="text" onKeyPress="return isNumberKey(event)" value="<%=ekubik%>" onKeyUp="jumlahberatall()" onKeyDown="jumlahberatall()" onFocus="if(this.value=='0') this.value='';vol();" onBlur="if(this.value=='') this.value='0';" size="5" />m3 
					</div>
					</div>
						

				<% elseif ekdkiriman="2" then %>
				<div class="col-3">
					<label>JENIS KIRIMAN : </label>
					<div class="row space">
						<input type="radio" name="KdJenisHarga" id="KdJenisHarga1" value="0" >BERAT
						<label></label>
						<input type="radio" name="KdJenisHarga" id="KdJenisHarga3" value="2" >UNIT/KOLI
					</div>		
				</div>		
					
					<div id="svclaut" style="visibility:hidden">    
						<div class="col-2">
							<div class="row space">
								<input type="radio" name="KdJenisHarga" id="KdJenisHarga2" value="1" checked>KUBIKASI
							</div>	
						</div>	
						<div class="col-3">
						<label>KUBIKASI : </label>
						
						<input name="volume" id="volume" type="text" onKeyPress="return isNumberKey(event)" value="0" onKeyUp="jumlahberatall()" onKeyDown="jumlahberatall()" onFocus="if(this.value=='0') this.value='';vol();" onBlur="if(this.value=='') this.value='0';" size="5" />m3 
						</div>		
					</div>		
						
				<% end if %>
			
		
			<div class="col-3">
				<label>COD :</label>
				<input name="bcod" type="text" id="bcod" onKeyPress="return isNumberKey(event)" value="<%=ecod%>" onFocus="if(this.value=='0') this.value='';" onBlur="if(this.value=='') this.value='0';" readonly/>
			</div>
		</div>
	</fieldset>



	<fieldset>
		<legend>INFORMASI PACKING</legend>
		<div class="row col-12">
			<div class="col-3">
				<label>KODE PACKING :</label>
				<input name="pckID" type="text" id="pckID" maxlength="14" onKeyDown="showPacking(this.value,document.getElementById('custIDNomor').value)" value = "<%=btt("PCK_ID")%>"/>
			</div>
            
            <div class="col-3">
				<label>BIAYA PACKING :</label>
				<input name="bpacking" type="number" id="bpacking" value="<%if not isnull(btt("PCK_Biaya")) then response.write btt("PCK_Biaya") else response.Write "0" end if%>" readonly/>
			</div>
            <div class="col-3">
            <input type="button" value="HAPUS PACKING DARI BTT" class="tombol full_12 tombolorens" onClick="document.getElementById('pckID').value=''; document.getElementById('bpacking').value = 0;totalbiaya();jumlahbayarall();ubah();">
            </div>

			


		</div>
        
        <div class="row col-12">
        <div class="col-6">
           		<div id="txtpacking"></div>
			</div>
        
        </div>
	</fieldset>







	<fieldset>
	<legend>INFORMASI PEMBAYARAN KIRIMAN</legend>
	<div class="row col-12">
		<div class="col-8">
	
			<label>PEMBAYARAN :</label>
			<div class="row space">
			<%if ekdpembayaran="1" then %>
				<input type="radio" name="pembayaran" id="pembayaranTunai" value="1" checked>TUNAI
                <input type="radio" name="pembayaran" id="pembayaranTransfer" value="6" >TRANSFER
				<div id="kreditYNdiv" style="visibility:hidden">
					
					<input type="radio" name="pembayaran" id="pembayaranKredit" value="2">KREDIT 
					
					<input type="radio" name="pembayaran" id="pembayaranTagih" value="3">TAGIH TUJUAN
				</div>
			<%elseif ekdpembayaran="2" then %>
				<input type="radio" name="pembayaran" id="pembayaranTunai" value="1">TUNAI
                                <input type="radio" name="pembayaran" id="pembayaranTransfer" value="6" >TRANSFER
				<div id="kreditYNdiv" style="visibility:visible">
					
					<input type="radio" name="pembayaran" id="pembayaranKredit" value="2" checked>KREDIT
					
					<input type="radio" name="pembayaran" id="pembayaranTagih" value="3">TAGIH TUJUAN
				</div>
			<%elseif ekdpembayaran="3" then %>
				<input type="radio" name="pembayaran" id="pembayaranTunai" value="1">TUNAI
                                <input type="radio" name="pembayaran" id="pembayaranTransfer" value="6" >TRANSFER
				<div id="kreditYNdiv" style="visibility:visible">
						
					<input type="radio" name="pembayaran" id="pembayaranKredit" value="2">KREDIT 
					
					<input type="radio" name="pembayaran" id="pembayaranTagih" value="3" checked>TAGIH TUJUAN
				</div>
             <%elseif ekdpembayaran="4" then %>
				<input type="radio" name="pembayaran" id="pembayaranTunai" value="1">TUNAI
                                <input type="radio" name="pembayaran" id="pembayaranTunai" value="6" checked>TRANSFER
				<div id="kreditYNdiv" style="visibility:visible">
						
					<input type="radio" name="pembayaran" id="pembayaranKredit" value="2">KREDIT 
					
					<input type="radio" name="pembayaran" id="pembayaranTagih" value="3" >TAGIH TUJUAN
				</div>
			<%end if%>
			</div>
		</div>
	</div>
	<div class="row col-12">
		<div class="col-3">
			<label>BIAYA KIRIM :</label>
			<input name="biayaKirim" type="text" id="biayaKirim" onBlur="totalbiaya();if(this.value=='') this.value='0';jumlahbayarall();ubah();" onChange="totalbiaya();if(this.value=='')this.value='0';jumlahbayarall();ubah();" onKeyPress="return isNumberKey(event);if(this.value=='') this.value='0';totalbiaya();jumlahbayarall();" onFocus="if(this.value=='0') this.value='';" value="<%=ebiaya%>" >


		</div>
		<div class="col-3">
			<label>BIAYA LAIN/PENERUS:</label>
			<input name="LainLain" type="text" id="lainlain" onBlur="totalbiaya();if(this.value=='') this.value='0';ubah();" onChange="totalbiaya();jumlahbayarall();ubah();" onKeyPress="return isNumberKey(event)" onFocus="if(this.value=='0') this.value='0';" value="<%=epenerus%>" >
		</div>
<!--        
		<div class="col-3">
			<label>PACKING:</label>
			<input name="packing" type="text" id="packing" onChange="totalbiaya();jumlahbayarall();ubah();" onKeyPress="return isNumberKey(event)" onFocus="if(this.value=='') this.value='0';" onBlur="totalbiaya();if(this.value=='') this.value='0';jumlahbayarall();ubah();"value="<%=epacking%>"/> 
		</div>
-->        
	</div>
	<hr> 
	<div class="row col-12">			
		<div class="col-3">			
			<label>TOTAL BIAYA :</label>
			<input type="text" name="TotalBiaya" id="SumBiaya" readonly onChange="jumlahbayarall();" onBlur="jumlahbayarall();"  value="<%=ejumlah%>"/> 
			<input name="total" type="hidden" value="0" id="totalBerat" hidden=""  />
		</div>	
        <div class="col-4">
            	<label>No. BTT Manual :</label>
                <input type="text" maxlength="16" value="<%=eNoBttManual%>" name="noBTTmanual" id="noBTTmanual" placeholder="Masukkan Nomor BTT Manual disini" onBlur="lengkapin();">
            </div>	
	</div>
	</fieldset>


	
	
	<%if trim(btt("BTTT_AktifYN"))="N" then%>
		<input type="button" class="tombol full_12 tombolorens" name="Aktifkan" id="Aktifkan" value="AKTIFKAN" onClick="window.open('p-mkt_t_econote_h_a.asp?b=<%=encode(b)%>','_self')" /> 
	<%end if%>
<!--
		  <input type="button" class=" tombol full_12 tombolblue " name="Packing" id="Packing" value="PACKING" />      
		  <input type="reset" name="Packing2" id="Packing2" value="RESET"  class=" tombol full_12 tombolblack "  />      
-->
		  <input onClick="getbulantahun();"  type="submit" value="SIMPAN" class="submit tombol full_12 tombolbirumuda" />      
		  <input type="button" value="BATAL" class="tombol full_12 tombolred float-r" onClick="window.open('mkt_t_econote.asp','_self')" />
	
  </form> 
</div>
	<div id="txtHint"></div>
	<div id="txtHint2"></div>
	<% 
	server.Execute("futer.asp")
	%>


<!-- javascript floating div bantuan mengambang 
<script>
if (!document.layers)
document.write('<div id="divStayTopLeft" style="position:absolute">')
</script>

<layer id="divStayTopLeft">
      <% 'server.Execute("bantuan.asp") 
	  %> 
</layer>
-->

<script type="text/javascript">
var verticalpos="frombottom"

if (!document.layers)
document.write('</div>')

function JSFX_FloatTopDiv()
{
	var startX = 1024,
	startY = 400;
	var ns = (navigator.appName.indexOf("Netscape") != -1);
	var d = document;
	function ml(id)
	{
		var el=d.getElementById?d.getElementById(id):d.all?d.all[id]:d.layers[id];
		if(d.layers)el.style=el;
		el.sP=function(x,y){this.style.left=x;this.style.top=y;};
		el.x = startX;
		if (verticalpos=="fromtop")
		el.y = startY;
		else{
		el.y = ns ? pageYOffset + innerHeight : document.body.scrollTop + document.body.clientHeight;
		el.y -= startY;
		}
		return el;
	}
	window.stayTopLeft=function()
	{
		if (verticalpos=="fromtop"){
		var pY = ns ? pageYOffset : document.body.scrollTop;
		ftlObj.y += (pY + startY - ftlObj.y)/8;
		}
		else{
		var pY = ns ? pageYOffset + innerHeight : document.body.scrollTop + document.body.clientHeight;
		ftlObj.y += (pY - startY - ftlObj.y)/8;
		}
		ftlObj.sP(ftlObj.x, ftlObj.y);
		setTimeout("stayTopLeft()", 10);
	}
	ftlObj = ml("divStayTopLeft");
	stayTopLeft();
}
JSFX_FloatTopDiv();
</script>
</body>

<% end if 
end if%>