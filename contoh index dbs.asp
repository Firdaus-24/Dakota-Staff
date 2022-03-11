<!DOCTYPE html>
<html>

<head>
<!-- #include file="md5.asp" -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link rel="stylesheet" type="text/css" href="css/fontawesome-free/css/all.min.css/">
	
	<link href="css/sb-admin.css" rel="stylesheet">
    <title>
	<% if Trim(session("PT_ID"))="A" then  %>
									PT. DAKOTA BUANA SEMESTA
								<% elseif Trim(session("PT_ID"))="B" then  %>	
									PT. DAKOTA LINTAS BUANA
								<% elseif Trim(session("PT_ID"))="C" then  %>	
									PT DAKOTA LOGISTIK INDONESIA
								<%end if%>
	</title>

	<script>
	function cari(str)
	{
	//document.getElementById('resultcari').innerHTML="";
	var xmlhttp;    
	if (str=="")
	  {
	  document.getElementById("resultcari").innerHTML="";
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
		document.getElementById("resultcari").innerHTML=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","../hasil_bootstrap.asp?b="+str,true);
	xmlhttp.send();
	}
	</script>

	

</head>

<body>
   

			<% server.execute ("Menu.asp") %>
        
<script type="text/javascript" src="js/jquery.qrcode.js"></script>
<script type="text/javascript" src="js/qrcode.js"></script>	
        <!-- Page Content  -->
        <div id="content">

             <%  server.execute("showHideMenu.asp")%>
				<div class="alert alert-primary alert-dismissible fade show"" role="alert" >
						Hai <%=session("username")%> ! [<%=session("cabang")%>], Selamat datang
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
  </button>
				</div>
			<div class="container-fluid">
				
				<!--
					<div class="card mb-3">
						  <div class="card-header">
							<i class="fa fa-search fa-spin "></i>
							PELACAKAN KIRIMAN</div>
							<div class="card-body">
								<div class="scrolltable">
									<div class="form-row">
										<div class="form-group col-md-12">
											<header class="kepala">
												<div class="kep-jud"><h3><kbd>PELACAKAN KIRIMAN</kbd></h3></div>
											</header>
										</div>
									</div>
									<div class="form-row">
										<div class="form-group col-md-6">
										  <input type="text" name="btt" id="btt" value="" placeholder="Masukkan No Resi kiriman anda" />
										</div>
										<div class="form-group col-md-6">
										<div id="resultcari"></div>
											
										</div>
																						
										
									</div>
									<div class="form-row">
										<div class="form-group col-md-12">
											<input type="button" value="Cari" class="btn btn-success" onClick="cari(document.getElementById('btt').value);" />
										</div>
									</div>
								</div>
						  
							</div>
					</div>
				-->
				<div class="row">
					<div class="col-sm-6">
						  <div class="card-header">
								<i class="fa fa-search fa-spin "></i>
									PELACAKAN KIRIMAN</div>
									<div class="form-row">
										<div class="form-group col-md-12">
										  <input type="text" name="btt" id="btt" value="" placeholder="Masukkan No Resi kiriman anda" />
										</div>
									</div>
									<DIV CLASS="form-row">
										<div class="form-group col-md-12">
											<input type="button" value="Cari" class="btn btn-success" onClick="cari(document.getElementById('btt').value);" />
										</div>
									</div>
					
						
					</div>
					<div class="col-sm-6" style="background-image: url('image/si_dako_min.png');background-size: 40%;background-repeat: no-repeat;text-align:right;font-size:48%;">
						
						<div class="scrolltable">
								<div id="resultcari">
								<kbd>si Dako</kbd> .. <br>
								<br>
								Maskot Dakota Cargo berbentuk truck <br>
								yang selalu sigap mengirimkan paket anda <br>
								keseluruh pelosok nusantara secara <br>
								cepat, tepat, akurat, bertanggung jawab<br>
								dengan selalu mengedepankan pelayanan<br>
								yang murah senyum dan ramah<br>
								juga harga yang bersahabat, tentunya<br>
										
								</div>
						</div>
						
					</div>
				</div>
						
				<div class="row">
				  <div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-danger o-hidden h-100">
					  <div class="card-body">
						<div class="card-body-icon">
						  <i class="fa fa-fw fa-exclamation-circle blink"></i>
						</div>
						<div class="mr-5"><% server.Execute("get-total-info-barang-belum-berangkat.asp") %> BTT BELUM BERANGKAT!</div>
					  </div>
					  <a class="card-footer text-white clearfix small z-1" href="get-info-barang-belum-berangkat-view.asp">
						<span class="float-left">View Details</span>
						<span class="float-right">
						  <i class="fas fa-angle-right"></i>
						</span>
					  </a>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-primary o-hidden h-100">
					  <div class="card-body">
						<div class="card-body-icon">
						  <i class="fas fa-fw fa-truck"></i>
						</div>
						<div class="mr-5"> <%server.Execute("get-total-info-barang-masuk.asp")%> BTT AKAN MASUK!</div>
					  </div>
					  <a class="card-footer text-white clearfix small z-1" href="get-info-barang-masuk-view.asp">
						<span class="float-left">View Details</span>
						<span class="float-right">
						  <i class="fas fa-angle-right"></i>
						</span>
					  </a>
					</div>
				  </div>
				   <div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-success o-hidden h-100">
					  <div class="card-body">
						<div class="card-body-icon">
						  <i class="fas fa-fw fa-rocket"></i>
						</div>
						<div class="mr-5"><% server.Execute("get-total-info-barang-transit.asp") %> BTT TRANSIT!</div>
					  </div>
					  <a class="card-footer text-white clearfix small z-1" href="get-info-barang-transit-view.asp">
						<span class="float-left">View Details</span>
						<span class="float-right">
						  <i class="fas fa-angle-right"></i>
						</span>
					  </a>
					 </div>
					</div>
					<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-info o-hidden h-100">
					  <div class="card-body">
						<div class="card-body-icon">
						  <i class="fa fa-cog fa-fw"></i>
						</div>
						<div class="mr-5"><% server.Execute("get-total-info-barang-gagal-loper.asp") %> BTT Loperan Tertunda!</div>
					  </div>
					  <a class="card-footer text-white clearfix small z-1" href="get-info-barang-gagal-loper-view.asp">
						<span class="float-left">View Details</span>
						<span class="float-right">
						  <i class="fas fa-angle-right"></i>
						</span>
					  </a>
					</div>
					</div>
				</div>
				
		<div class="row">
			<div class="col-sm-6">
				<div class="card-header">
					<i class="fas fa-chart-area"></i>
					Grafik Barang Naik, Turun dan Transit. Tahun <%=year(now())%>
				</div>
				<div class="card-body">
						<% server.execute ("opr_t_chart_barangNaikTurunTransit.asp") %>
				</div>
				<div class="card-footer small text-muted">Updated daily at 01:00 AM</div>
			</div>
			<div class="col-sm-6">
				<div class="card-header">
					<i class="fas fa-coins"></i>
					Omset Penjualan
				</div>
				<div class="card-body">
						<% server.execute ("mkt_t_chart_laporanPenjualan.asp") %>
				</div>
				<div class="card-footer small text-muted">Updated daily at 02:00 AM</div>
			</div>
        </div>
		<div class="row">
			<div class="col-sm-6">
				<div class="card-header">
					<i class="fas fa-calendar-check"></i>
					SCAN CHECKPOINT SUPIR
				</div>
				<a href="agenQRcode_print.asp">
				<div class="card-body">
						<div id="qrcodeCanvas" align="center" ></div>
						
					<script>
						jQuery('#qrcodeCanvas').qrcode({
							text	: "<%=md5(session("server-id"))%>",
							width 	:275,
							height	:275
						});	
					</script>
				</div>
				</a>
				<div class="card-footer small text-muted">Mohon scan QR code diaplikasi checkpoint driver assingment</div>
			</div>
			<div class="col-sm-6">
				
			</div>
        </div>
			
    </div>
	



</body>

</html>