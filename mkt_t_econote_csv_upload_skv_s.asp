<!--#include file="Connections/cargo.asp" -->
<!--#include file="freeze_screen.asp" -->	
<!--#include file="securestring.asp" -->	

<link rel="stylesheet" type="text/css" href="css/freeze.css"/> 

<% 
'option explicit 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%>


<%
dim custid, custname, ttl
custid=trim(Request.QueryString("cust"))
tgl=trim(Request.QueryString("tgl"))

dim btt_cmd, btt
Set btt_cmd = Server.CreateObject ("ADODB.Command")
btt_cmd.ActiveConnection = MM_cargo_STRING

btt_cmd.CommandText = "SELECT COUNT(SJ) AS jml FROM MKT_T_CSV_SKV LEFT OUTER JOIN MKT_T_eConote ON MKT_T_CSV_SKV.Penerima = MKT_T_eConote.BTTT_TujuanNama AND MKT_T_CSV_SKV.Alamat = MKT_T_eConote.BTTT_TujuanAlamat AND MKT_T_CSV_SKV.Kota = MKT_T_eConote.BTTT_TujuanKota AND MKT_T_CSV_SKV.SJ = MKT_T_eConote.BTTT_NoSuratJalan WHERE (MKT_T_eConote.BTTT_Tanggal BETWEEN '"& tgl &" 00:00:00' AND '"& tgl &" 23:59:59') AND (MKT_T_eConote.BTTT_AsalCustID = '"& custid &"')" 
set btt = btt_cmd.execute
ttl = btt.fields.item("jml")
btt.close()

btt_cmd.CommandText = "SELECT FORMAT(MKT_T_CSV_SKV.Tanggal, 'MM/dd/yyyy') AS Tanggal, MKT_T_CSV_SKV.Penerima, MKT_T_CSV_SKV.Alamat, MKT_T_CSV_SKV.Kota, MKT_T_CSV_SKV.Telp, MKT_T_CSV_SKV.Kelurahan, MKT_T_CSV_SKV.Kecamatan, MKT_T_CSV_SKV.Propinsi, MKT_T_CSV_SKV.Kodepos, MKT_T_CSV_SKV.UP, MKT_T_CSV_SKV.Keterangan, MKT_T_CSV_SKV.SJ, MKT_T_CSV_SKV.Isi, MKT_T_CSV_SKV.Jml, MKT_T_CSV_SKV.Berat, MKT_T_CSV_SKV.Volume, MKT_T_eConote.BTTT_ID, ISNULL(GLB_M_Agen.Agen_Nama,'') AS Agen_Nama, MKT_T_eConote.BTTT_Harga FROM GLB_M_Agen RIGHT OUTER JOIN MKT_T_eConote ON GLB_M_Agen.Agen_ID = MKT_T_eConote.BTTt_TujuanAgenID RIGHT OUTER JOIN MKT_T_CSV_SKV ON MKT_T_eConote.BTTT_TujuanNama = MKT_T_CSV_SKV.Penerima AND MKT_T_eConote.BTTT_TujuanAlamat = MKT_T_CSV_SKV.Alamat AND MKT_T_eConote.BTTT_TujuanKota = MKT_T_CSV_SKV.Kota AND MKT_T_eConote.BTTT_NoSuratJalan = MKT_T_CSV_SKV.SJ WHERE (MKT_T_eConote.BTTT_Tanggal BETWEEN '"& tgl &" 00:00:00' AND '"& tgl &" 23:59:59') AND (MKT_T_eConote.BTTT_AsalCustID = '"& custid &"') ORDER BY GLB_M_Agen.Agen_Nama, MKT_T_eConote.BTTT_Harga, MKT_T_eConote.BTTT_ID " 
'response.write btt_cmd.CommandText &"<br>"
set btt = btt_cmd.execute

%><head>
	<meta name="viewport" content="width=device-width">
	
	<link rel="stylesheet" type="text/css" href="css/style_t.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/styletable.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/properti.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/grid.css"/> <!-- CSS All -->
	<link href="css/mobile_t.css" rel="stylesheet" type="text/css" media="only screen and (max-width:360px)"> 
	<link href="css/menu_t.css" rel="stylesheet" type="text/css" media="only screen and (min-width:769px)">
	<!-- Tambahan -->
	<link rel="stylesheet" type="text/css" href="css/tcal.css" />
	<script type="text/javascript" src="js/jquery-1.4.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.8.min.js"></script>
	<script type="text/javascript" src="js/tcal.js"></script>



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

<script type="text/javascript">
function killBackSpace(e){
e = e? e : window.event;
var t = e.target? e.target : e.srcElement? e.srcElement : null;
if(t && t.tagName && (t.type && /(password)|(text)|(file)/.test(t.type.toLowerCase())) || t.tagName.toLowerCase() == 'textarea')
return true;
var k = e.keyCode? e.keyCode : e.which? e.which : null;
if (k == 8){
if (e.preventDefault)
e.preventDefault();
return false;
};
return true;
};
if(typeof document.addEventListener!='undefined')
document.addEventListener('keydown', killBackSpace, false);
else if(typeof document.attachEvent!='undefined')
document.attachEvent('onkeydown', killBackSpace);
else{
if(document.onkeydown!=null){
var oldOnkeydown=document.onkeydown;
document.onkeydown=function(e){
oldOnkeydown(e);
killBackSpace(e);
};}
else
document.onkeydown=killBackSpace;
}
</script>

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


<script type="text/javascript">
function prosesNoSp(pck)
{
	var x = pck;
	
	var n = x.length;
			if (n==14)
				{
					showSP(pck,document.getElementById("vcustid").value);
				}
				
}
</script>


<script>
function showSP(str,cid)
{
//alert(str);
var xmlhttp;    
if (str=="")
  {
  document.getElementById("txtHint").innerHTML="";
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
		
    document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","get-CSV_SF.asp?pck="+str+"&cid="+cid,true);
xmlhttp.send();
}
</script>


<!-- javascript pengambilan kode jenis layanan -->
<script type="text/javascript">
function jenisLayanan(kode)
{
	if(kode == "Darat")
	{
		document.getElementById("KodeLayanan").value = "1";
		
	}
	else if(kode == "Laut")
	{
		document.getElementById("KodeLayanan").value = "2";
		
	}
	else
	{
		document.getElementById("KodeLayanan").value = "3";
		
	}
	
}
</script>

</head>



<style type="text/css">
	#txtTerbilang
	{
		width:auto;
		padding-left:15%;
		font-size:150%;
		text-align:left;
		color:#F00;
	}


	#txtcustomer
	{
		overflow:auto;
		overflow-x:hidden;
	}


	#txtHint
	{
		width:auto;
		height:auto;
		z-index:0;
		
	}
</style>

<body onLoad="document.getElementById('pckID').focus();">
<div class="wrap-90">
	<div class="row">
		<header class="kepala">
			<div class="kep-jud"><h1>BTT SKV Sejahtera <%=tgl%></h1></div>
		</header>
	</div>
	<hr />
	<form method="post" action="#">   	
	<div class="row">
		<div class="col-12">
			<input type="button" value="REFRESH" class="tombol full_12 tombolijo" onClick="window.open('mkt_t_econote_csv_upload_skv_s.asp?cust=<%=custid%>&tgl=<%=tgl%>','_self')">
			<input type="button" value="SELESAI" class="tombol full_12 tombolred float-r" onClick="window.open('index.asp','_self')">
		</div>
	</div>
	<fieldset> 
	  <legend><B>TOTAL DATA : <%=formatnumber(ttl,0)%> </B></legend>
	 
	<table style="font-size:11px">
	<tr>
		<th>No Surat Jalan</th>
		<th>Tanggal</th>
		<th>Penerima</th>
		<th>Alamat</th>
		<th>Kota</th>
		<th>Telp</th>
		<th>Kelurahan</th>
		<th>Kecamatan</th>
		<th>Propinsi</th>
		<th>Kodepos</th>
		<th>UP</th>
		<th>Keterangan</th>
		<th>Isi</th>
		<th>Colly</th>
		<th>Berat</th>
		<th>Volume</th>
		<th>Cabang Penerima</th>
		<th>Harga</th>
		<th>No BTT</th>
		<th>Action</th>
	</tr>

	<%
	do while not btt.eof
	%>
		<tr id="listcust" class="pilih" <%if (trim(btt("Agen_Nama"))="" or trim(btt("BTTT_Harga"))="0") then%> style="color:#ff0000;" <%end if%> >
			<td width="8%"><%=btt("SJ")%></td>
			<td><%=btt("Tanggal")%></td>
			<td><%=btt("Penerima")%></td>
			<td><%=btt("Alamat")%></td>
			<td><%=btt("Kota")%></td>
			<td><%=btt("Telp")%></td>
			<td><%=btt("Kelurahan")%></td>
			<td><%=btt("Kecamatan")%></td>
			<td><%=btt("Propinsi")%></td>
			<td><%=btt("Kodepos")%></td>
			<td><%=btt("UP")%></td>
			<td><%=btt("Keterangan")%></td>
			<td><%=btt("Isi")%></td>
			<td align="right"><%=formatnumber(btt("Jml"),0)%></td>
			<td align="right"><%=formatnumber(btt("Berat"),0)%></td>
			<td align="right"><%=formatnumber(btt("Volume"),0)%></td>
			<td><%=btt("Agen_Nama")%></td>
			<td align="right"><%=formatnumber(btt("BTTT_Harga"),0)%></td>
			<td><%=btt("BTTT_ID")%></td>
			<td align="center" width="1">
				<%if (trim(btt("Agen_Nama"))="" or trim(btt("BTTT_Harga"))="0") then%>	
					<input type="Button" value="Edit" class="tombollink" onClick="window.open('mkt_t_econote_csv_upload_skv_e.asp?b=<%=encode(btt("BTTT_ID"))%>','_self')">
				<%else%>
					<input type="Button" value="Print" class="tombollink tombolijo" onClick="window.open('mkt_t_econote_print.asp?c=sk&b=<%=encode(btt("BTTT_ID"))%>','_self')">
				<%end if%>
			</td>
		</tr>
		
	<%
	btt.movenext
	loop


	%>


	</table>
	</fieldset>



</div>
	</form>

	<% 
		server.Execute("freeze_screen.asp")
	%>

</body>