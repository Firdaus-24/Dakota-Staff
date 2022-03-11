<!-- #include file="../connection.asp"-->
<!--#include file="../constend/constanta.asp"-->
<% 
if session("username") = "" then
response.Redirect("../login.asp")
end if


dim cabang, nama, nip, root, q, r, s, t, u, a, b, c, d, e, f

q = Request.QueryString("q")
r = Request.QueryString("r")
s = Request.QueryString("s")
t = Request.QueryString("t")
u = Request.QueryString("u")
' filter descending
a = Request.QueryString("a")
b = Request.QueryString("b")
c = Request.QueryString("c")
d = Request.QueryString("d")
e = Request.QueryString("e")
f = Request.QueryString("f")

nip = request.QueryString("nip")
if nip = "" then 
	nip = request.form("nip")
end if

nama = request.QueryString("nama")
if nama = "" then 
	nama = request.form("nama")
end if

cabang = Request.QueryString("cabang")
if cabang = "" then 
	cabang = request.form("cabang")
end if

aktif = Request.QueryString("aktif")
if aktif = "" then 
	aktif = request.form("aktif")
end if

if aktif = "" Or aktif = "N" then
	aktif = "N"
else 
	aktif = "Y"
end if

root = ""

Set karyawan_cmd = Server.CreateObject ("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_cargo_STRING

if  nama = "" And nip = "" And cabang = "" then 
	root = "SELECT HRD_M_Karyawan.*, agen_Nama from HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE (ISNULL(Kry_DDBID, '') <>'') and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
elseIf cabang <> "" And nama = "" And Nip = "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
elseIf cabang <> "" And nama <> "" And nip = "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_Nama LIKE '%"& nama &"%' and Kry_AktifYN = '"& aktif &"'AND Kry_Nip LIKE '%H%'" 
elseIf cabang = "" And nama <> "" And nip = "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nama LIKE '%"& nama &"%' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
elseIf cabang = "" And nama <> "" And nip <> "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nama LIKE '%"& nama &"%' and Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
elseIf cabang = "" And nama = "" And nip <> "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
elseIf cabang <> "" And nama = "" And nip <> "" then
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
else 
	root ="SELECT HRD_M_Karyawan.*, agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Kry_ActiveAgenID = '"& cabang &"' and Kry_Nama LIKE '%"& nama &"%' and Kry_Nip = '"& nip &"' and Kry_AktifYN = '"& aktif &"' AND Kry_Nip LIKE '%H%'" 
end if

karyawan_cmd.commandText = root
set rs = karyawan_cmd.execute

set conn = Server.CreateObject("ADODB.Connection")
conn.open MM_Cargo_string

set cabang_cmd = Server.CreateObject("ADODB.Command")
cabang_cmd.ActiveConnection = MM_cargo_STRING

set cabangaktif_cmd = Server.CreateObject("ADODB.Command")
cabangaktif_cmd.ActiveConnection = MM_cargo_STRING

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
	orderBy = "ORDER BY Kry_Nip ASC"
elseIf r <> "" then
	orderBy = "ORDER BY Kry_Nama ASC"
elseIf s <> "" then
	orderBy = "ORDER BY Kry_ActiveAgenID ASC"
elseIf t <> "" then
	orderBy = "ORDER BY Kry_TglMasuk ASC" 
elseIf u <> "" then
	orderBy = "ORDER BY Kry_TglKeluar ASC"
elseIf a <> "" then
	orderBy = "ORDER BY Kry_Nip DESC" 
elseIf b <> "" then
	orderBy = "ORDER BY Kry_Nama DESC" 
elseIf c <> "" then
	orderBy = "ORDER BY Kry_ActiveAgenID DESC" 
elseIf d <> "" then
	orderBy = "ORDER BY Kry_TglMasuk DESC" 
elseIf e <> "" then
	orderBy = "ORDER BY Kry_TglKeluar DESC" 
elseIf f <> "" then
	orderBy = "ORDER BY Kry_TglKeluar DESC"  
else 
	orderBy = " order by Kry_Nip, Kry_Nama, Kry_TglMasuk, Kry_TglKeluar, Kry_ActiveAgenID"
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
    <title>FORM CARI KARYAWAN</title>
	<!-- #include file='../layout/header.asp' -->
	<style>
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
			<button type="button" class="btn btn-secondary" id="tombolkembalicari" onclick="return window.location.href='../karyawanharian.asp'"><i class="fa fa-backward" aria-hidden="true" id="iconkembalicari"></i> KEMBALI</button>
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
			<table class="table table-dark table-striped" cellpadding="10" cellspacing="0" id="table">
			<tr>
				<th>
					<% if orderBy = "ORDER BY Kry_Nip ASC" then %>
						<a href="CariKaryawan.asp?a=OBK_N&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> NIP</a>
					<% else %>
						<a href="CariKaryawan.asp?q=OBK_N&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> NIP</a>
					<% end if %>
				</th>
				<th>
					<% if orderBy = "ORDER BY Kry_Nama ASC" then %>
						<a href="CariKaryawan.asp?b=OBK_NM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> NAMA</a>
					<% else %>
						<a href="CariKaryawan.asp?r=OBK_NM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> NAMA</a>
					<% end if %>
				</th>
				<th>
					<% if orderBy = "ORDER BY Kry_ActiveAgenID ASC" then %>
						<a href="CariKaryawan.asp?c=OBK_A&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> PENGGAJIAN DI</a>
					<% else %>
						<a href="CariKaryawan.asp?s=OBK_A&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> PENGGAJIAN DI</a>
					<% end if %>
				</th>
				<th>
						<a href="#" style="text-decoration:none;color:#fff;"> AKTIF AGEN</a>
				</th>
				<th>
					<% if orderBy = "ORDER BY Kry_TglMasuk ASC" then %>
						<a href="CariKaryawan.asp?d=OBK_TM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> TANGGAL MASUK</a>
					<% else %>
						<a href="CariKaryawan.asp?t=OBK_TM&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> TANGGAL MASUK</a>
					<% end if %>
				</th>
				<th>
					<% if orderBy = "ORDER BY Kry_TglKeluar ASC" then %>
						<a href="CariKaryawan.asp?e=OBK_TK&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> TANGGAL KELUAR</a>
					<% else %>
						<a href="CariKaryawan.asp?u=OBK_TK&cabang=<%= cabang %>&nama=<%= nama %>&nip=<%= nip %>&aktif=<%= aktif %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> TANGGAL KELUAR</a>
					<% end if %>
				</th>
				<th>AKTIF</th>
				<th class="text-center">DETAIL</th>
			</tr>
		
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
					<% if requestrecords <> 0 then %>
						<a class="page-link" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= requestrecords - recordsonpage%>&angka=<%=angka%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">&#x25C4; Prev </a>
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
				%>
					<a class="page-link" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= pagelist %>&angka=<%=angka%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>"><%= pagelistcounter %></a> 
				<%
				pagelist = pagelist + recordsonpage
				loop
				%>
				</li>
				<li class="page-item">
					<%  if(recordcounter > 1) and (lastrecord <> 1) then %>
					<a class="page-link" href="<%= url %>/ajax/CariKaryawan.asp?cabang=<%=trim(cabang2)%>&offset=<%= requestrecords + recordsonpage %>&angka=<%=angka%>&nip=<%=nip2%>&nama=<%=nama2%>&aktif=<%=aktif%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">Next &#x25BA;</a>
					<% else %>
					<p class="page-link-p">Next &#x25BA;</p>
					<% end if %>
				</li>
			</ul>
		</nav>	
		<% end if %>


</body>
<!-- #include file='../layout/footer.asp' -->