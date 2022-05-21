<!-- #include file="../connection.asp"-->
<!--#include file="../constend/constanta.asp"-->
<% 
if session("username") = "" then
response.Redirect("../login.asp")
end if


dim event, userupdate, url, root, q, r, s, t, u, v, w, x, y a, b, c, d, e, f, g, h, i

q = Request.QueryString("q")
r = Request.QueryString("r")
s = Request.QueryString("s")
t = Request.QueryString("t")
u = Request.QueryString("u")
v = Request.QueryString("v")
w = Request.QueryString("w")
x = Request.QueryString("x")
y = Request.QueryString("y")

' filter descending
a = Request.QueryString("a")
b = Request.QueryString("b")
c = Request.QueryString("c")
d = Request.QueryString("d")
e = Request.QueryString("e")
f = Request.QueryString("f")
g = Request.QueryString("g")
h = Request.QueryString("h")
i = Request.QueryString("i")

event = request.QueryString("event")
if event = "" then 
	nip = request.form("event")
end if

nama = request.QueryString("userupdate")
if userupdate = "" then 
	nama = request.form("userupdate")
end if

url = Request.QueryString("url")
if url = "" then 
	cabang = request.form("url")
end if

root = ""

Set event_cmd = Server.CreateObject ("ADODB.Command")
event_cmd.ActiveConnection = MM_cargo_STRING

if  event = "" And userupdate = "" And url = "" then 
	root = "SELECT HRD_M_Karyawan.*, agen_Nama from HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE (ISNULL(Kry_DDBID, '') <>'') and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
elseIf cabang <> "" And nama = "" And Nip = "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
elseIf cabang <> "" And nama <> "" And nip = "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_Nama LIKE '%"& nama &"%' and Kry_AktifYN = '"& aktif &"'AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
elseIf cabang = "" And nama <> "" And nip = "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nama LIKE '%"& nama &"%' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
elseIf cabang = "" And nama <> "" And nip <> "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nama LIKE '%"& nama &"%' and Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
elseIf cabang = "" And nama = "" And nip <> "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
elseIf cabang <> "" And nama = "" And nip <> "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
else 
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_Nama LIKE '%"& nama &"%' and Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip NOT LIKE '%A%' AND Kry_Nip NOT LIKE '%H%'" 
end if

event_cmd.commandText = root
set rs = event_cmd.execute

set conn = Server.CreateObject("ADODB.Connection")
conn.open MM_Cargo_string

set event_cmd = Server.CreateObject("ADODB.Command")
event_cmd.ActiveConnection = MM_cargo_STRING

Set Connection = Server.CreateObject("ADODB.Connection")
Connection.Open MM_Cargo_string

dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal
dim tglmasuk, tglkeluar, aktif, orderBy
dim angka
dim filtertanggal, keyword, filterkeyword

angka = request.QueryString("angka")
if len(angka) = 0 then 
	angka = Request.form("urut") + 1
end if

'ambil lagi cabang, nama, nip untuk di jadikan paggination
If q <> "" then
	orderBy = "ORDER BY LogEvent ASC"
elseIf r <> "" then
	orderBy = "ORDER BY LogKeterangan ASC"
elseIf s <> "" then
	orderBy = "ORDER BY LogURL ASC"
elseIf t <> "" then
	orderBy = "ORDER BY LogKey ASC" 
elseIf u <> "" then
	orderBy = "ORDER BY LogUser ASC"
elseif v <> "" then
    orderBy ="ORDER BY LogAgenID ASC"
elseif w <> "" then
    orderBY ="ORDER BY LogDateTime ASC"
elseif x <>  "" then
    orderBy = "ORDER BY LogIP ASC"
elseif y <> "" then
    orderBy = "ORDER BY LogBrowser ASC"

elseIf a <> "" then
	orderBy = "ORDER BY  LogEvent DESC" 
elseIf b <> "" then
	orderBy = "ORDER BY  LogKeterangan DESC" 
elseIf c <> "" then
	orderBy = "ORDER BY  LogURL DESC" 
elseIf d <> "" then
	orderBy = "ORDER BY  LogKey DESC" 
elseIf e <> "" then
	orderBy = "ORDER BY  LogUser DESC" 
elseIf f <> "" then
	orderBy = "ORDER BY  LogAgenID DESC"  
lseIf f <> "" then
	orderBy = "ORDER BY  LogDateTime DESC"
lseIf f <> "" then
	orderBy = "ORDER BY  LogIP DESC"
lseIf f <> "" then
	orderBy = "ORDER BY  LogBrowser DESC"
else 
	orderBy = " order by LogEvent, LogKeterangan, LogURL, LogKey, LogUser, LogAgenID, logDateTime, LogIP, LogBrowser"
end if
set rs = Server.CreateObject("ADODB.Recordset")

sqlawal = root

sql=sqlawal + orderBy

rs.open sql, Connection

' records per halaman
recordsonpage = 15

' count all records
allrecords = 0
do until rs.EOF
  allrecords = allrecords + 1
  rs.movenext
loop
nip2 = nip
nama2 = nama
cabang2 = cabang

' if offset is zero then the first page will be loaded
offset = Request.QueryString("offset")
if offset = 0 OR offset = "" then
  requestrecords = 0
else
  requestrecords = requestrecords + offset
end if

rs.close

set rs = server.CreateObject("adodb.recordset")

sqlawal = root
sql=sqlawal + orderBy

rs.open sql, Connection

' reads first records (offset) without showing them (can't find another solution!)
hiddenrecords = requestrecords
do until hiddenrecords = 0 OR rs.EOF
  hiddenrecords = hiddenrecords - 1
  rs.movenext
  if rs.EOF then
    lastrecord = 1
  end if	
loop

 %>
 <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FORM CARI EVENT</title>
	<!-- #include file='../layout/header.asp' -->
	<style>
		th a{
			font-size:12px;
		}
		@media screen and (max-width:540px)
		{
			.container h1
			{
				font-size:25px;
			}
			#tombolkembalicari{
				display:block;
				max-width:200px;
				font-size:12px;
			}
			#iconkembalicari{
				font-size:10px;
			}
			#table
			{
				max-width:20%;
				font-size:12px;
			}
			#table button{
				max-width:80px;
				font-size:12px;
			}
			.container table a
			{
				font-size:10px;
			}
		}
	</style>
</head>

<body>
<div class='container'>
	<div class="row">
		<div class="col md-3">
			<h3 class="mt-3 mb-1 text-center">PENCARIAN KARYAWAN</h3>
		</div>
	</div>
	<div class='row'>
		<div class='col-md mb-3'>
			<button type="button" class="btn btn-secondary" id="tombolkembalicari" onclick="return window.location.href='../index.asp'"><i class="fa fa-backward" aria-hidden="true" id="iconkembalicari"></i> KEMBALI</button>
		</div>
	</div>
	<% if rs.eof then%>
	<div class='text-center bg-secondary p-2 text-white bg-opacity-25 mt-2'>
		<div class='notiv-header'>
			<label>WARNING !!!</label>
		</div>
		<div class='content-pernama'>
			<p>DATA TIDAK DI TEMUKAN</p>
			<p>MOHON MASUKAN KEYWORD KEMBALI UNTUK PENCARIAN ULANG</p>
		</div>
	</div>
	<% else %>
	<div class='row' style="overflow-x:auto;">
		<div class='col-md'>
			<table class="table table-dark table-striped" cellpadding="10" cellspacing="0" id="table" style="font-size:14px;">
				<thead>
					<tr>
						<th>
							<% if orderBy = "ORDER BY Kry_Nip ASC" then %>
								<a href="CariKaryawan.asp?a=OBK_N&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> NIP</a>
							<% else %>
								<a href="CariKaryawan.asp?q=OBK_N&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> NIP</a>
							<% end if %>
						</th>
						<th>
							<% if orderBy = "ORDER BY Kry_Nama ASC" then %>
								<a href="CariKaryawan.asp?b=OBK_NM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> NAMA</a>
							<% else %>
								<a href="CariKaryawan.asp?r=OBK_NM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> NAMA</a>
							<% end if %>
						</th>
						<th>
							<% if orderBy = "ORDER BY Kry_ActiveAgenID ASC" then %>
								<a href="CariKaryawan.asp?c=OBK_A&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> PENGGAJIAN DI</a>
							<% else %>
								<a href="CariKaryawan.asp?s=OBK_A&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> PENGGAJIAN DI</a>
							<% end if %>
						</th>
						<th>
								<a href="#" style="text-decoration:none;color:#fff;font-size:14px;"> AKTIF AGEN</a>
						</th>
						<th>
							<% if orderBy = "ORDER BY Kry_TglMasuk ASC" then %>
								<a href="CariKaryawan.asp?d=OBK_TM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> TANGGAL MASUK</a>
							<% else %>
								<a href="CariKaryawan.asp?t=OBK_TM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> TANGGAL MASUK</a>
							<% end if %>
						</th>
						<th>
							<% if orderBy = "ORDER BY Kry_TglKeluar ASC" then %>
								<a href="CariKaryawan.asp?e=OBK_TK&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> TANGGAL KELUAR</a>
							<% else %>
								<a href="CariKaryawan.asp?u=OBK_TK&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;font-size:14px;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> TANGGAL KELUAR</a>
							<% end if %>
						</th>
						<th>AKTIF</th>
						<th class="text-center">DETAIL</th>
					</tr>
				</thead>
					<%
					'prints records in the table

					showrecords = recordsonpage
					recordcounter = requestrecords
					do until showrecords = 0 OR  rs.EOF
					recordcounter = recordcounter + 1
					
					cabangaktif_cmd.commandText = "select agen_nama from glb_m_agen where agen_ID = '"& rs("Kry_activeAgenID") &"' "
					set aktifAgen = cabangaktif_cmd.execute
					%>
					<tr>
						<td><%= rs("Kry_NIP")%></td>
						<td><%= rs("Kry_Nama")%></td> 
						<td><%= rs("agen_nama") %></td>
						<td><a href="<%= url %>/forms/activeAGen.asp?nip=<%= rs("Kry_Nip") %>" style="text-decoration:none;color:#fff;"><%= aktifAgen("agen_Nama") %></a></td>
						<td><%= rs("Kry_TglMasuk")%></td>
						<td>
							<% if rs("Kry_TglKeluar") = "1/1/1900" then %>
											
							<% else %>
								<%= rs("Kry_TglKeluar") %>
							<% end if %>
						</td>
						<td>
						<% if session("HA1D") = true then %>
							<% if rs("Kry_AktifYN") = "Y" then %>
								<button type="button" class="btn btn-outline-success btn-sm" onclick="return confirm('YAKIN UNTUK DIRUBAH???') == true? window.location.href='../updateaktif.asp?p=Y&q=<%= rs("Kry_NIP")%>': false"><%= rs("Kry_AktifYN")%></button>
							<% else %>
								<button type="button" class="btn btn-outline-danger btn-sm" onclick="return confirm('YAKIN UNTUK DIRUBAH???') == true? window.location.href='../updateaktif.asp?p=N&q=<%= rs("Kry_NIP")%>': false"><%= rs("Kry_AktifYN")%></button>
							<% end if %>
						<% else %>
							<% if rs("Kry_AktifYN") = "Y" then %>
								Aktif
							<% else %>
								NonAktif
							<% end if %>
						<% end if %>
						</td>
						<td>
							<a href="<%=url%>/detail-Karyawan/index.asp?nip=<%= rs("Kry_NIP")%>" class="btn btn-outline-info btn-sm" name="detail">Detail</a>
						</td>
					</tr>
								
				<%
					
					showrecords = showrecords - 1
					rs.movenext
					if rs.EOF then
					lastrecord = 1
					end if
					loop
					rs.close
				%>
			</table>
		</div>
	</div>
		 <!-- paggination -->
		<nav aria-label="Page navigation example">
		
			<ul class="pagination">
				<li class="page-item">		
					<% 
						page = Request.QueryString("page")
						if page = "" then
							npage = 1
						else
							npage = page - 1
						end if
					if requestrecords <> 0 then %>
						<a class="page-link" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= requestrecords - recordsonpage%>&page=<%=npage%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">&#x25C4; Prev </a>
					<% else %>
						<p class="page-link-p">&#x25C4; Prev </p>
					<% end if %>
				</li>
				<li class="page-item d-flex" style="overflow-y:auto;">	
				<%
					pagelist = 0
					pagelistcounter = 0
					do until pagelist > allrecords  
					pagelistcounter = pagelistcounter + 1
						if page = "" then
							page = 1
						else
							page = page
						end if
									
						if Cint(page) = pagelistcounter then
				%>
							<a class="page-link d-flex bg-primary text-light" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= pagelist %>&page=<%=pagelistcounter%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>"><%= pagelistcounter %></a> 
						<% else %>							
							<a class="page-link d-flex" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= pagelist %>&page=<%=pagelistcounter%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>"><%= pagelistcounter %></a> 
				<%
						end if
					pagelist = pagelist + recordsonpage
					loop
				%>
				</li>
				<li class="page-item">
					<% 
						if page = "" then
							page = 1
						else
							page = page + 1
						end if
					%>
					<%  if(recordcounter > 1) and (lastrecord <> 1) then %>
					<a class="page-link" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= requestrecords + recordsonpage %>&page=<%=page%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">Next &#x25BA;</a>
					<% else %>
					<p class="page-link-p">Next &#x25BA;</p>
					<% end if %>
				</li>
			</ul>
		</nav>	
		<% end if %>
</div>
</body>
<!-- #include file='../layout/footer.asp' -->