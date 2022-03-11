<%
	' keharusan user login sebelum masuk ke menu utama aplikasi
	if session("username") = "" then
	response.Redirect("login.asp")
	end if
%>

<!--#include file="../Connections/cargo.asp" -->

<script>
	function updateRights(uname,serverID,appRightsID)
	{
	
	var xmlhttp;    
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
			document.getElementById("txtHint").style.padding = "35px";
		document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
		}
	  }
	xmlhttp.open("GET","get-user-rights.asp?uname="+uname+"&serverID="+serverID+"&appRightsID="+appRightsID,true);
	//alert("get-user-rights.asp?uname="+uname+"&serverID="+serverID+"&appRightsID="+appRightsID);
	xmlhttp.send();
	}
</script>


<%
	dim username 
	username = request.QueryString("uname")
%>

<%
	Set Connection = Server.CreateObject("ADODB.Connection")
	Connection.Open MM_Cargo_string
%>



<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>

	<script type="text/javascript" src="js/jquery.min.js"></script>

	<script type="text/javascript" src="js/ddaccordion.js">


	/***********************************************
	* Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
	* Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
	* This notice must stay intact for legal use
	***********************************************/

	</script>
	<meta name="viewport" content="width=device-width">
	<!-- Javascript Tanggal kalender Date Picker -->

		 
	<script type="text/javascript" src="js/jquery-1.4.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.8.min.js"></script>
	<script type="text/javascript" src="js/tcal.js"></script>
	<!-- CSS Tanggal Date kalender Picker -->
	<link rel="stylesheet" type="text/css" href="css/tcal.css" />
	<link rel="stylesheet" type="text/css" href="css/style_t.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/styletable.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/properti.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/grid.css"/> <!-- CSS All -->
	<link href="css/mobile_t.css" rel="stylesheet" type="text/css" media="only screen and (max-width:700px)"> 
	<link href="css/menu_t.css" rel="stylesheet" type="text/css" media="only screen and (min-width:701px)">

	<script type="text/javascript">


		ddaccordion.init({
			headerclass: "submenuheader", //Shared CSS class name of headers group
			contentclass: "submenu", //Shared CSS class name of contents group
			revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
			mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
			collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
			defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
			onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
			animatedefault: false, //Should contents open by default be animated into view?
			persiststate: true, //persist state of opened contents within browser session?
			toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
			togglehtml: ["suffix", "<img src='image/plus.gif' class='statusicon' />", "<img src='image/minus.gif' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
			animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
			oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
				//do nothing
			},
			onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
				//do nothing
			}
		})


	</script>


	<style type="text/css">
		.space-10{
			padding-left: 10px;
		}	
		
		.space-20{
			padding-left: 20px;
		}

		.glossymenu{
			margin: 5px 0;
			padding: 0;
			width: 100%; /*width of menu*/
			/* border: 1px solid #9A9A9A; */
			border-bottom-width: 0;
			/* position:absolute; */
			top:10%;
			bottom:90%;
			left:2px;
		}

		.glossymenu a.menuitem{
			background: black url(image/glossyback.gif) repeat-x bottom left;
			font: bold 14px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
			color: white;
			display: block;
			position: relative; /*To help in the anchoring of the ".statusicon" icon image*/
			width: auto;
			padding: 4px 0;
			padding-left: 10px;
			text-decoration: none;
		}


		.glossymenu a.menuitem:visited, .glossymenu .menuitem:active{
			color: white;
		}

		.glossymenu a.menuitem .statusicon{ /*CSS for icon image that gets dynamically added to headers*/
			position: absolute;
			top: 5px;
			right: 5px;
			border: none;
		}

		.glossymenu a.menuitem:hover{
			background-image: url(image/glossyback2.gif);
		}

		.glossymenu div.submenu{ /*DIV that contains each sub menu*/
			background: white;
		}

		.glossymenu div.submenu ul{ /*UL of each sub menu*/
			list-style-type: none;
			margin: 0;
			padding: 0;
		}

		.glossymenu div.submenu ul li{
			border-bottom: 1px solid blue;
		}

		.glossymenu div.submenu ul li a{
			display: block;
			font: normal 13px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
			color: black;
			text-decoration: none;
			padding: 2px 0;
			padding-left: 10px;
		}

		.glossymenu div.submenu ul li a:hover{
			background: #DFDCCB;
			colorz: white;
		}

		.TagMenu
		{
			display:block;
			background-color:#9F6;
			color:#006;
		}

	</style>


	<%
		Set Connection = Server.CreateObject("ADODB.Connection")
		Connection.Open MM_Cargo_string

		set rs = server.CreateObject("adodb.recordset")
	%>




</head>

<body>

<div class="wrap-90">
	<div class="row col-12">
			<header class="kepala">
				<div class="kep-jud"> <h1>PENGATURAN HAK AKSES MENU & OTORISASI PENGGUNAAN APLIKASI </h1> </div>
			</header>
		</div>
		<hr />

	<div class="row col-12">
		<div class="col-4">
		
		</div>
		<div class="col-4">
			<header class="kepala">
				<div class="kep-jud"> <h3>USER <%=username %></h3> </div>
			</header>
			
			<div class="glossymenu">

				<!-- Menu System -->
					<input type="hidden" id="uname" value="<%=request.QueryString("uname")%>" hidden="">
					<input type="hidden" id="serverID" value="<%=request.QueryString("serverID")%>" hidden="">
			
				<a class="menuitem submenuheader" href="#">SYSTEM</a>
					<div class="submenu">
						<ul>
							<li>
								<span class="TagMenu">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'B');" id="checkbox" 
								
									<%
										'cek kondisi hak akses menu system
										sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'B'"

										rs.open sql, connection
										if not rs.eof then
									%>
									checked
									<% 
								
										end if 
										rs.close
									%>
									>
									<label>Menu Sytem Konfigurasi</label>
								</span>
						  </li>
						</ul>
					</div>  

				<!-- Menu Master -->
				<a class="menuitem submenuheader" href="#">MASTER</a>

					<div class="submenu">
						<ul>
							<li>
								<span class="TagMenu ">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C');" id="checkbox2" 
								
									<%
										'cek kondisi hak akses menu system
										sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C'"

										rs.open sql, connection
										if not rs.eof then
									%>
									checked
									<% 
									
										end if 
										rs.close
									%>
									>
									<label>MENU MASTER</label>
								</span>
							</li>
							<li>
								<span class="TagMenu space-10">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1');" id="checkbox4" 
								
									<%
										'cek kondisi hak akses menu system
										sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C1'"

										rs.open sql, connection
										if not rs.eof then
									%>
									checked
									<% 
								
										end if 
										rs.close
									%>
									>
									<label>AGEN</label>
								</span>

								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1a');" id="checkbox4" 
								
										<%
												'cek kondisi hak akses menu system
										sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C1a'"

										rs.open sql, connection
										if not rs.eof then
										%>
										checked
										<% 
									
										end if 
										rs.close
										%>
										>
									Tombol MASTER AGEN Tambah
									
								</div>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1b');" id="checkbox3" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C1b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol MASTER AGEN Ubah
								</div>
							
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1c');" id="checkbox5" 
								
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C1c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol MASTER AGEN Hapus
								</div>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1d');" id="checkbox5" 
								
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C1d'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol MASTER AGEN Virtual Account
								</div>
								
								
							<span class="TagMenu space-10">
								<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1');" id="#" >
								<label>AREA LOPER #</label>
								
							</span>
							
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1c');" id="#" >
									Tombol Print #
								</div>	
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1c');" id="#" >
									Tombol Ubah #
								</div>	
							
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C1c');" id="#" >
									Tombol Hapus #
								</div>	
							
								
								
								
							<span class="TagMenu space-10">
								<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C2');" id="checkbox6" 
								
								<%
								'cek kondisi hak akses menu system
								sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C2'"

								rs.open sql, connection
								if not rs.eof then
								%>
								checked
								<% 
								
								end if 
								rs.close%>
								> 
								<label>KENDARAAN</label>
							
							</span>
							
							
							
							
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C2a');" id="checkbox7" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C2a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Kendaran Tambah
									
								</div>
							
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C2b');" id="checkbox8" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C2b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Kendaran Ubah
								</div>
									
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C2c');" id="checkbox9" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C2c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Kendaran No/Aktif
								</div>	
									
									
							<span class="TagMenu space-10">
								<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C3');" id="checkbox10" 
								
								<%
								'cek kondisi hak akses menu system
								sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C3'"

								rs.open sql, connection
								if not rs.eof then
								%>
								checked
								<% 
								
								end if 
								rs.close%>
								> <label>KODE POS</label>
								
							</span>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C3a');" id="checkbox11" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C3a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Kode Pos Tambah
								</div>
							
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C3b');" id="checkbox12" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C3b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Kode Pos Ubah
								</div>	
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C3c');" id="checkbox13" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C3c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Kode Pos Hapus
								</div>
								
							<span class="TagMenu space-10">
								<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C4');" id="checkbox14" 
								
								<%
								'cek kondisi hak akses menu system
								sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C4'"

								rs.open sql, connection
								if not rs.eof then
								%>
								checked
								<% 
								
								end if 
								rs.close%>
								>
								<label>KOTA</label>
								
							</span>
							
								<div class="space-20">
							
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C4a');" id="checkbox15" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C4a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Kota Tambah
									
								</div>
									
								
								<div class="space-20">
									
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C4b');" id="checkbox16" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C4b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Kota Ubah
									
								</div>
									
								<div class="space-20">
									
									
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C4c');" id="checkbox17" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C4c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Kota Hapus
									
								</div>
							
							<span class="TagMenu">
								<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C5');" id="checkbox18" 
								
								<%
								'cek kondisi hak akses menu system
								sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C5'"

								rs.open sql, connection
								if not rs.eof then
								%>
								checked
								<% 
								
								end if 
								rs.close%>
								>
								<label>SERVICE</label>
							</span>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C5a');" id="checkbox19" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C5a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Servis Tambah
									
								</div>	
								<div class="space-20">
									
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C5b');" id="checkbox20" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C5b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Servis Ubah
									
								</div>	
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'C5c');" id="checkbox21" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'C5c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Servis Hapus
								</div>
						  </li>
						</ul>
					</div> 
				
				
				<!-- Menu Operation -->
				<a class="menuitem submenuheader" href="#">OPERATION</a>
					<div class="submenu">
						<ul>
							<li>
								<span class="TagMenu">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox2" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>MENU OPERASIONAL</label>
								</span>	
							</li>
								<span class="TagMenu space-10">
									<input type="checkbox" onClick=	"updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D9');" id="checkbox60" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D9'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>BTT BERHASIL TERLOPER - ADMIN PUSAT  # </label>
								</span>
						 
						 
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D9a');" id="checkbox53" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D9a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button BTT Berhasil Terloper - ADMIN PUSAT Tambah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D9b');" id="checkbox54" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D9b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button BTT Berhasil Terloper - ADMIN PUSAT Ubah
								</div>	
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D9c');" id="checkbox55" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D9c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button BTT Berhasil Terloper - ADMIN PUSAT Hapus
								</div>
								
								
								<span class="TagMenu space-10">
								
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4');" id="checkbox71" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>BTT BERHASIL TERLOPER</label>
								</span>
								
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4a');" id="checkbox91" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button BTT Berhasil Terloper Tambah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4b');" id="checkbox92" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button BTT Berhasil Terloper Ubah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4c');" id="checkbox93" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button BTT Berhasil Terloper Hapus
							
								</div>
								<span class="TagMenu space-10">
									<input type="checkbox" > <label>Laporan Barang Turun</label>
								
								</span>
								
								<div class="space-20">
									<input type="checkbox" > Tampilkan Laporan
								
								</div>
								
								<div class="space-20">
									<input type="checkbox" > Tampilkan Tipe 2
									
								</div>
								
							
							
							
							
							
							
							
								<span class="TagMenu space-10">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D1');" id="checkbox38" 
									
									<%
										'cek kondisi hak akses menu system
										sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D1'"

										rs.open sql, connection
										if not rs.eof then
									%>
									checked
									<% 
									
										end if 
										rs.close
									%>
									>
									<label>SURAT PENGANTAR PENGIRIMAN [ SP BARANG NAIK ]</label>
								</span>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D1a');" id="checkbox39" 
									
									<%
										'cek kondisi hak akses menu system
										sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D1a'"

										rs.open sql, connection
										if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button SP Pengiriman Naik Tambah
								</div>
						
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D1b');" id="checkbox40" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D1b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button SP Pengiriman Naik Ubah
								</div>	
									
								
								<div class="space-20">
								
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D1c');" id="checkbox41" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D1c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button SP Pengiriman Naik Hapus
								</div>	
									
								
								<span class="TagMenu">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D2');" id="checkbox42" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D2'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>SURAT PENGANTAR TURUN [ SP BARANG TURUN ]</label>
								</span>
						 
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D2a');" id="checkbox43" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D2a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Surat Pengantar Turun Tambah
									
								</div>
								<div class="space-20">

									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D2b');" id="checkbox44" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D2b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Surat Pengantar Turun Ubah
								</div>
								
								<div class="space-20">
						 
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D2c');" id="checkbox45" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D2c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Surat Pengantar Turun Hapus
								</div>
									
						 

								<span class="TagMenu space-10">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D6');" id="checkbox46" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D6'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>PENGEMBALIAN BTT</label>
								</span>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D6a');" id="checkbox47" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D6a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Pengembalian BTT Tambah
								</div>
									
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D6b');" id="checkbox48" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D6b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Pengembalian BTT Ubah
								</div>	
									
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D6c');" id="checkbox49" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D6c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Menu Pengembalian BTT
								</div>
								
								
								<span class="TagMenu">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D3');" id="checkbox59" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D3'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>LOPER BARANG</label>
									
								</span>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D3a');" id="checkbox50" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D3a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Loper Barang Tambah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D3b');" id="checkbox51" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D3b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Loper Barang Ubah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D3c');" id="checkbox52" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D3c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Button Loper Barang Hapus
								</div>
								
								
								
								<span class="TagMenu space-10">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D5');" id="checkbox63" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D5'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>PENGAMBILAN BARANG SENDIRI</label>
								</span>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D5a');" id="checkbox64" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D5a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Pengambilan Barang Sendiri Tambah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D5b');" id="checkbox65" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D5b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Pengambilan Barang Sendiri Ubah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D5c');" id="checkbox66" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D5c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Pengambilan Barang Sendiri Hapus
								
								</div>
								<span class="TagMenu space-10">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D8');" id="checkbox61" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D8'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>SURAT MUATAN UDARA</label>
								</span>
								
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D8a');" id="checkbox56" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D8a'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Input SMU Tambah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D8b');" id="checkbox57" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D8b'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Input SMU Ubah
								</div>
								<div class="space-20">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D8c');" id="checkbox58" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D8c'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									Tombol Input SMU Hapus
								</div>
								<span class="TagMenu space-10">
									<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D7');" id="checkbox62" 
									
									<%
									'cek kondisi hak akses menu system
									sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D7'"

									rs.open sql, connection
									if not rs.eof then
									%>
									checked
									<% 
									
									end if 
									rs.close%>
									>
									<label>STOK BARANG GUDANG</label>
								</span>
							
						</ul>
					</div>

					
					
					
					

				<!-- Menu Marketing -->
				<a class="menuitem submenuheader" href="#">MARKETING</a>
					<div class="submenu">
						<ul>
						<li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E');" id="checkbox2" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							MENU MARKETING</span></li>
							<li>
							<span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E1');" id="checkbox22" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E1'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							CUSTOMER / PELANGGAN</span>
							  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E1a');" id="checkbox23" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E1a'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button Customer Tambah<br>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E1b');" id="checkbox24" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E1b'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button Customer Ubah<br>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E1c');" id="checkbox25" 
									
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E1c'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button Customer Hapus<br>
							<span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2');" id="checkbox26" 
									
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							BTT PENGIRIMAN / eCONOTE</span>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2a');" id="checkbox27" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2a'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button BTT Pengiriman Tambah<br>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2b');" id="checkbox28" 
									
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2b'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button BTT Pengiriman Ubah<br>

							  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2b1');" id="checkbox94" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2b1'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							--- Button BTT Pengiriman Ubah - HARGA<br>

							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2b2');" id="checkbox95" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2b2'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							--- Button BTT Pengiriman Ubah - BERAT/VOLUME/UKURAN<br>

							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2b3');" id="checkbox96" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2b3'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							--- Button BTT Pengiriman Ubah - KOLI<br>
							  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2b4');" id="checkbox29" 
									
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2b4'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							
							--- Button BTT Pengiriman Ubah - NAMA/ALAMAT TUJUAN<br>
							  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E2c');" id="checkbox29" 
									
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E2c'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							
							Button BTT Pengiriman Hapus<br>
							<span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E3');" id="checkbox30" 
									
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E3'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							PENERIMAAN BTT KEMBALI</span>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E3a');" id="checkbox31" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E3a'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button Penerimaan BTT Kembali Tambah<br>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E3b');" id="checkbox32" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E3b'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button Penerimaan BTT Kembali Ubah<br>
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E3c');" id="checkbox33" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E3c'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							Button Penerimaan BTT Kembali Hapus<br>
							<span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E4');" id="checkbox34" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E4'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							PELACAKAN KIRIMAN</span><span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E5');" id="checkbox35" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E5'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							LAPORAN PENJUALAN</span>
							<span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E6');" id="checkbox36" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E6'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							LAPORAN PENJUALAN HARIAN</span>
							
							
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E6a');" id="checkbox36a" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E6a'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close
							%>
							>
							Unposting<br />
							
							<span class="TagMenu">
							<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'E7');" id="checkbox37" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'E7'"

							rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
							LAPORAN PENGIRIMAN BELUM DIBUAT LAPORAN PENJUALAN</span>
							
							</li>
					  </ul>
					</div> 


				
					<!-- Menu Piutang -->
					<a class="menuitem submenuheader" href="#">ACCOUNT RECEIVABLE</a>
					<div class="submenu">
						<ul>
						<li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F');" id="checkbox67" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F'"

					rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
						  MENU ACCOUNT RECEIVABE (PIUTANG)</span>
						</li>
						<li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F1');" id="checkbox68" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F1'"

					rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
						  APPROVAL CUSTOMER</span>
						 </li>
						 <li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F11a');" id="checkbox69" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F11a'"

					rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
						  Button Invoice Tambah</span>
						</li>
						<li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F11b');" id="checkbox69" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F11b'"

					rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
						  Button Invoice Ubah</span>
						</li>
						<li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F11c');" id="checkbox69" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F11c'"

					rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
						  Button Invoice AR</span>
						</li>
						<li><span class="TagMenu">
						  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F11d');" id="checkbox69" 
							
							<%
							'cek kondisi hak akses menu system
							sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F11d'"

					rs.open sql, connection
							if not rs.eof then
							%>
							checked
							<% 
							
							end if 
							rs.close%>
							>
						  Button Invoice Hapus</span>
						</li>
					</ul>

				</div>

				<!-- Menu Packing -->
				<a class="menuitem submenuheader" href="#">PACKING</a>
				<div class="submenu">
					<ul>
						<li><span class="TagMenu">Permintaan Packing<BR /></span>
						<input type="checkbox"  value="">Button Hapus Packing<br>
				<input type="checkbox"  value="">Button Posting Packing<br>
				<input type="checkbox"  value="">Button Tambah Packing<br>
				<input type="checkbox"  value="">Button Ubah Packing<br>
				<input type="checkbox"  value="">Menu Packing<br>
						</li>
					</ul>
				</div>  

				<!-- Menu Maintenance Flag -->
				<a class="menuitem submenuheader" href="#">MAINTENANCE FLAG</a>
				<div class="submenu">
					<ul>
						<li><input type="checkbox"  value="">Menu Maintenance flag<br></li>
					</ul>
				</div> 

				<!-- Menu General Ledger -->
				<a class="menuitem submenuheader" href="#">GENERAL LEDGER</a>
				<div class="submenu">
					<ul>
					  <li><span class="TagMenu">
					  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I');" id="checkbox2" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
					  MENU GENERAL LEDGER</span>
					  <span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox72" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Jurnal</span>
				<input type="checkbox"  onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4a');" id="checkbox72a" 
				<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4a'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%> >Button Jurnal Tambah<br>
				<input type="checkbox"  onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4b');" id="checkbox72b" <%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4b'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%> >Button Jurnal EDIT<br>
				<input type="checkbox"  onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D4c');" id="checkbox72c" <%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D4c'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>>Button Jurnal Hapus<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox73" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Daftar Kelompok Perkiraan</span>
				<input type="checkbox"  value="">Button Kelompok Perkiraan Tambah<br>
				<input type="checkbox"  value="">Button Kelompok Perkiraan Ubah<br>
				<input type="checkbox"  value="">Menu Kelompok Perkiraan<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox74" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Daftar Kas Masuk/Keluar</span>
				<input type="checkbox"  value="">Button Kas Masuk/Keluar Hapus<br>
				<input type="checkbox"  value="">Button Kas Masuk/Keluar Tambah<br>
				<input type="checkbox"  value="">Button Kas Masuk/Keluar Ubah<br>
				<input type="checkbox"  value="">Menu Kas Masuk/Keluar<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox75" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Rugi/Laba </span>
				<input type="checkbox"  value="">Menu Cetak Rugi/Laba <br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox76" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Rugi/Laba 1</span>
				<input type="checkbox"  value="">Menu Cetak Rugi/Laba 1<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox77" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Rugi/Laba Setahun</span>
				<input type="checkbox"  value="">Menu Cetak Rugi/Laba Setahun<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox78" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Daftar Kode Perkiraan</span>
				<input type="checkbox"  value="">Button Kode Perkiraan Hapus<br>
				<input type="checkbox"  value="">Button Kode Perkiraan Tambah<br>
				<input type="checkbox"  value="">Button Kode Perkiraan Ubah<br>
				<input type="checkbox"  value="">Menu Kode Perkiraan<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox79" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Daftar Bank</span>
				<input type="checkbox"  value="">Button Master Bank Hapus<br>
				<input type="checkbox"  value="">Button Master Bank Tambah<br>
				<input type="checkbox"  value="">Button Master Bank Ubah<br>
				<input type="checkbox"  value="">Menu Master Bank<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox80" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Buku Besar</span>
				<input type="checkbox"  value="">Menu Cetak Buku Besar<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox81" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Daftar Awal Saldo Perkiraan</span>
				<input type="checkbox"  value="">Button Saldo Awal Perkiraan Tambah<br>
				<input type="checkbox"  value="">Button Saldo Awal Perkiraan Ubah<br>
				<input type="checkbox"  value="">Menu Saldo Awal Perkiraan<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox82" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Neraca Saldo</span>
				<input type="checkbox"  value="">Menu Cetak Neraca Saldo<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox83" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Neraca Saldo 1</span>
				<input type="checkbox"  value="">Menu Cetak Neraca Saldo 1<br>
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'D');" id="checkbox84" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'D'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Cetak Neraca</span>
				<input type="checkbox"  value="">Menu Cetak Neraca
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I7');" id="checkbox85" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I7'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Kas Masuk/Keluar</span>
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I7a');" id="checkbox70" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I7a'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Button Transaksi Kas Masuk/Keluar Tambah<br>

				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I7c');" id="checkbox88" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I7c'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Button Transaksi Kas Masuk/Keluar Hapus<br>
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I7b');" id="checkbox89" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I7b'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Button Transaksi Kas Masuk/Keluar Ubah<br>
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I7d');" id="checkbox90" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I7d'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Button Transaksi Kas Masuk/Keluar Unposting<br>

				
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I11');" id="checkbox87" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I11'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Posting Pembukuan Akhir Bulan</span>

				
				
				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I12');" id="checkbox86" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I12'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Unposting Pembukuan Akhir Bulan</span>
								
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I13');" id="checkbox90" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I13'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Unposting Pembukuan Periode Mundur<br>

				<span class="TagMenu">
				<input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'I14');" id="checkbox86" 
						
						<%
						'cek kondisi hak akses menu system
						sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'I14'"

				rs.open sql, connection
						if not rs.eof then
						%>
						checked
						<% 
						
						end if 
						rs.close%>
						>
				Kalkulasi Fiskal</span>
				
					  </li>
					</ul>
				</div> 

				<!-- Menu HRD -->
				<a class="menuitem submenuheader" href="#">HRD</a>
				<div class="submenu">
					<ul>
						<li><span class="TagMenu">Proses Piutang Karyawan<br></span>
				<input type="checkbox"  value="">Menu Proses Piutang Karyawan <br>
				<span class="TagMenu">Hari Libur Periodik<br></span>
				<input type="checkbox"  value="">Button Hari Libur Periodek Hapus<br>
				<input type="checkbox"  value="">Button Hari Libur Periodek Tambah<br>
				<input type="checkbox"  value="">Button Hari Libur Periodek Ubah<br>
				<input type="checkbox"  value="">Menu Hari Libur Periodik<br>
				<span class="TagMenu">Periksa Absensi<br></span>
				<input type="checkbox"  value="">Button Periksa Absensi Hapus<br>
				<input type="checkbox"  value="">Button Periksa Absensi Ubah<br>
				<input type="checkbox"  value="">Menu Periksa Absensi<br>
				<span class="TagMenu">Laporan Absensi<br></span>
				<input type="checkbox"  value="">Menu Laporan Absensi<br>
				<span class="TagMenu">Transaksi Pembayaran Karyawan<br></span>
				<input type="checkbox"  value="">Menu Transaksi Pembayaran Karyawan<br>
				<input type="checkbox"  value="">Tombol Transaksi Pembayaran Karyawan Aktif/non Aktif<br>
				<input type="checkbox"  value="">Tombol Transaksi Pembayaran Karyawan Ubah<br>
				<span class="TagMenu">Hari Kerja Khusus<br></span>
				<input type="checkbox"  value="">Button Hari Kerja Khusus Hapus<br>
				<input type="checkbox"  value="">Button Hari Kerja Khusus Tambah<br>
				<input type="checkbox"  value="">Button Hari Kerja Khusus Ubah<br><input type="checkbox"  value="">Menu Hari Kerja Khusus<br>
				<span class="TagMenu">Entry Absensi<br></span>
				<input type="checkbox" value="">Button Entry Absensi Hapus<br>
				<input type="checkbox" value="">Button Entry Absensi Tambah<br>
				<input type="checkbox" value="">Button Entry Absensi Ubah<br>
				<input type="checkbox" value="">Menu Entry Absensi<br>
				<span class="TagMenu">Hari Libur Khusus<br></span>
				<input type="checkbox" value="">Button Entry Absensi Hapus<br>
				<input type="checkbox" value="">Button Entry Absensi Ubah<br>
				<input type="checkbox" value="">Button Entry Absensi Tambah<br>
				<input type="checkbox" value="">Menu Hari Libur Khusus<br>
				<span class="TagMenu">Perizinan<br></span>
				<input type="checkbox" value="">Button Entry Absensi Hapus<br>
				<input type="checkbox" value="">Button Entry Absensi Tambah<br>
				<input type="checkbox" value="">Button Entry Absensi Ubah<br>
				<input type="checkbox" value="">Menu Perizinan<br>
				<span class="TagMenu">Hari Libur Umum<br></span>
				<input type="checkbox" value="">Button Entry Absensi Hapus<br>
				<input type="checkbox" value="">Button Entry Absensi Tambah<br>
				<input type="checkbox" value="">Button Entry Absensi Ubah<br>
				<input type="checkbox" value="">Menu Hari Libur Umum<br>
				<span class="TagMenu">Laporan Status Kerja Karyawan<br></span>
				<input type="checkbox" value="">Menu Laporan Status Kerja Karyawan<br>
				<span class="TagMenu">Mutasi Piutang Karyawan<br></span>
				<input type="checkbox" value="">Menu Mutasi Piutang Karyawan<br>
				<span class="TagMenu">Saldo Awal Piutang Karyawan<br></span>
				<input type="checkbox" value="">Menu Saldo Awal Piutang Karyawan<br>
				<input type="checkbox" value="">Tombol Saldo Awal Piutang Karyawan Hapus<br>
				<input type="checkbox" value="">Tombol Saldo Awal Piutang Karyawan Tambah<br>
				<input type="checkbox" value="">Tombol Saldo Awal Piutang Karyawan Ubah<br>
				<span class="TagMenu">Laporan Jumlah Izin/Cuti/sakit/alpa<br></span>
				<input type="checkbox" value="">Menu Laporan Jumlah Izin/Cuti/sakit/alpa<br>
				<span class="TagMenu">Master Supir<br></span>
				<input type="checkbox" value="">Button Delete Master Supir<br>
				<input type="checkbox" value="">Button Tambah Master Supir<br>
				<input type="checkbox" value="">Button Ubah Master Supir<br>
				<input type="checkbox" value="">Menu Master Supir<br>
				<span class="TagMenu">Transaksi Pinjam Karyawan<br></span>
				<input type="checkbox" value="">Menu Transaksi Pinjam Karyawan<br>
				<input type="checkbox" value="">Tombol Transaksi Pinjam Karyawan Atif/Non Aktif<br>
				<input type="checkbox" value="">Tombol Transaksi Pinjam Karyawan Tambah<br>
				<input type="checkbox" value="">Tombol Transaksi Pinjam Karyawan Ubah<br>
					</li>
					</ul>
				</div> 

				<!-- Menu Piutang Cabang -->
				<a class="menuitem submenuheader" href="#">PIUTANG CABANG</a>
				<div class="submenu">
					<ul>
						<li><span class="TagMenu">Mutasi Piutang Cabang TT<br></span>
				<input type="checkbox" value="">Menu Mutasi Piutang Cabang TT<br>
				<input type="checkbox" value="">Tombol Mutasi Piutang Cabang TT Tambah<br>
				<input type="checkbox" value="">Tombol Mutasi Piutang Cabang TT Hapus<br>
				<input type="checkbox" value="">Tombol Mutasi Piutang Cabang TT Ubah<br>
				<span class="TagMenu">Pengambilan BTT TT Ke Cabang<br></span>
				<input type="checkbox" value="">Menu Pengambilan BTT TT Ke Cabang<br>
				<input type="checkbox" value="">Tombol Pengambilan BTT TT Ke Cabang Tambah<br>
				<input type="checkbox" value="">Tombol Pengambilan BTT TT Ke Cabang Ubah<br>
				<span class="TagMenu">Proses Piutang Cabang TT<br></span>
				<input type="checkbox" value="">Menu Proses Piutang Cabang TT<br>
				<span class="TagMenu">BTT Terbayar<br></span>
				<input type="checkbox" value="">Menu BTT Terbayar<br>
				<input type="checkbox" value="">Menu BTT Terbayar Hapus<br>
				<input type="checkbox" value="">Menu BTT Terbayar Tambah<br>
				<input type="checkbox" value="">Menu BTT Terbayar Ubah<br>
						</li>
					</ul>
				</div> 

				<!-- Menu Klaim -->
				<a class="menuitem submenuheader" href="#">KLAIM</a>
				<div class="submenu">
					<ul>
						<li><span class="TagMenu">Klaim Tidak Disetuju<br></span>
				<input type="checkbox" value="">Menu Klaim Tidak Disetuju<br>
				<input type="checkbox" value="">Tombol Klaim Tidak Disetuju Aktif/No Aktif<br>
				<input type="checkbox" value="">Tombol Klaim Tidak Disetuju Tambah<br>
				<input type="checkbox" value="">Tombol Klaim Tidak Disetuju Ubah<br>
				<span class="TagMenu">Klaim Masuk<br></span>
				<input type="checkbox" value="">Menu Klaim Masuk<br>
				<input type="checkbox" value="">Tombol Klaim Masuk Aktif/No Aktif<br>
				<input type="checkbox" value="">Tombol Klaim Masuk Tambah<br>
				<input type="checkbox" value="">Tombol Klaim Masuk Ubah<br>
				<span class="TagMenu">Klaim Disetuji<br></span>
				<input type="checkbox" value="">Menu Klaim Disetuji<br>
				<input type="checkbox" value="">Tombol Klaim Disetuji Aktif/No Aktif<br>
				<input type="checkbox" value="">Tombol Klaim Disetuji Tambah<br>
				<input type="checkbox" value="">Tombol Klaim Disetuji Ubah<br>
				<span class="TagMenu">Pembebanan Klaim<br></span>
				<input type="checkbox" value="">Menu Pembebanan Klaim<br>
				<input type="checkbox" value="">Tombol Pembebanan Klaim Hapus<br>
				<input type="checkbox" value="">Tombol Pembebanan Klaim Tambah<br>
				<input type="checkbox" value="">Tombol Pembebanan Klaim Ubah<br>
				<span class="TagMenu">Laporan Klaim<br></span>
				<input type="checkbox" value="">Menu Laporan Klaim<br>
				<input type="checkbox" value="">Tomblo Laporan Klaim Cetak<br>
				</li>
					</ul>
				</div> 


				<!-- Menu Laporan -->
				<a class="menuitem submenuheader" href="#">LAPORAN</a>
				<div class="submenu">
					<ul>
						<li><span class="TagMenu">Laporan Penjualan Conote Harian</span>
						<input type="checkbox"  value="">Menu Laporan Penjualan Coneto Harian<br>
						<span class="TagMenu">Laporan Coneto Terkirim<br></span>
						<input type="checkbox"  value="">Menu Laporan Coneto Terkirim<br>
						<span class="TagMenu">Laporan Coneto Belum Kembali<br></span>
				<input type="checkbox"  value="">Menu Laporan Coneto Kembali<br>
				<span class="TagMenu">Laporan Coneto Belum Terkirim<br></span>
				<input type="checkbox"  value="">Menu Laporan Coneto Belum Terkirim<br>
				<span class="TagMenu">Laporan Penilaian Kinerja<br></span>
				<input type="checkbox"  value="">Menu Penilaian Kinerja<br>
				 </ul>
				</div> 

				<!-- Menu Backup Dan Cuting Data -->
				<a class="menuitem submenuheader" href="#">BACKUP AND CUTTING DATA</a>
				<div class="submenu">
				<ul>
				<li><span class="TagMenu">Backup Dan Cuting Data<br></span>
				<input type="checkbox"  value="">Option Backup Dan Cuting Data<br>
				</li>
				</ul>
				</div> 


				<!-- Menu Packing -->
				<a class="menuitem submenuheader" href="#">PACKING</a>
				<div class="submenu">
					<ul>
						<li><span class="TagMenu">Packing<br></span>
				<input type="checkbox"  value="">Button Posting Packing<br>
				<input type="checkbox"  value="">Button Tambah Packing<br>
				<input type="checkbox"  value="">Button Ubah Packing<br>
				<input type="checkbox"  value="">Menu Packing<br>
						</li>
				   </ul>
				</div>  
				<!-- Menu KPI -->
				<a class="menuitem submenuheader" href="#">KPI</a>
				<div class="submenu">
					<ul>
						<li>
							<span class="TagMenu">
							  <input type="checkbox" onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'F22');" id="checkbox97" 
								
								<%
								'cek kondisi hak akses menu system
								sql = "SELECT * FROM WebRights where username ='"& request.QueryString("uname") &"' and serverID = '"& request.QueryString("serverID") &"' and appIDRights = 'F22'"

						rs.open sql, connection
								if not rs.eof then
								%>
								checked
								<% 
								
								end if 
								rs.close%>
								>
							  Laporan KPI</span>
					
						</li>
				   </ul>
				</div>  
				<input type="button" value="Set As Korwil" class="tombol tombolgreen full_12" onclick="window.open('user_manager_korwil.asp?uname=<%=request.QueryString("uname")%>','_self')"/>
				<input type="button" class="tombol tombolred full_12 float-r" value="Selesai" onClick="window.open('user_manager.asp','_self')">
			</div>
		</div>
		
		<div class="col-4">
		
		</div>
	</div>
</div>

<% server.Execute("futer.asp") %>

</body>
</html>