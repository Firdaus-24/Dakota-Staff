<!-- koneksi untuk ke database -->
<!-- #include file="connection.asp"-->
<!--#include file="landing.asp"-->
<!-- #include file="constend/constanta.asp" -->

<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%>

<% 
'terima variable tambah data karyawan

dim karyawan, allkaryawan
dim karyawan_cmd, p, q, r, s, t, u, a,b,c,d,e,f

'filter ascending
p = Request.QueryString("p")
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


Set karyawan_cmd = Server.CreateObject ("ADODB.Command")

karyawan_cmd.ActiveConnection = MM_cargo_STRING

if p = "" OR p = "Y" then
	karyawan_cmd.commandText ="SELECT * from HRD_M_Karyawan WHERE Kry_Nip LIKE '%H%'"
	set karyawan = karyawan_cmd.execute
else
	karyawan_cmd.commandText ="SELECT * from HRD_M_Karyawan WHERE Kry_Nip LIKE '%H%'"
	set karyawan = karyawan_cmd.execute
end if

set cabang_cmd = Server.CreateObject("ADODB.Command")
cabang_cmd.ActiveConnection = MM_cargo_STRING

set cabangaktif_cmd = Server.CreateObject("ADODB.Command")
cabangaktif_cmd.ActiveConnection = MM_cargo_STRING


Set Connection = Server.CreateObject("ADODB.Connection")
Connection.Open MM_Cargo_string

dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal
dim tglmasuk, tglkeluar, nip, nama, aktif, orderBy
dim angka
dim filtertanggal, keyword, filterkeyword, tombolCari

angka = request.QueryString("angka")
if len(angka) = 0 then 
	angka = 1
else 
	angka = angka + 1
end if

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

if p = "" OR p = "Y" then
	sqlawal = "SELECT * from HRD_M_Karyawan WHERE (ISNULL(Kry_DDBID, '') <>'') and Kry_Nip LIKE '%H%'"
else
	sqlawal = "SELECT * from HRD_M_Karyawan WHERE (ISNULL(Kry_DDBID, '') <>'') and Kry_Nip LIKE '%H%'"
end if

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

' if offset is zero then the first page will be loaded
offset = Request.QueryString("offset")
if offset = 0 OR offset = "" then
  requestrecords = 0
else
  requestrecords = requestrecords + offset
end if

rs.close

set rs = server.CreateObject("adodb.recordset")
if p = "" OR p = "Y" then
	sqlawal = "SELECT * from HRD_M_Karyawan WHERE (ISNULL(Kry_DDBID, '') <>'') and Kry_Nip LIKE '%H%'"
else
	sqlawal = "SELECT * from HRD_M_Karyawan WHERE (ISNULL(Kry_DDBID, '') <>'') and Kry_Nip LIKE '%H%'"
end if
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
	<title>Master Karyawan</title>
	<!-- #include file='layout/header.asp' -->
	<style>
	@media screen and (max-width:540px)
	{
		.container h1
		{
			font-size:25px;
		}
		.container .tambah-karyawan
		{
			display:block;
			margin-top:5px;
			padding:5px;
			font-size:12px;
		}
		#carikaryawan .formcari{
			display:block;
			width:102rem;
		}
		#carikaryawan .formcari select{
			font-size:12px;
		}
		#carikaryawan .formcari input{
			margin-top:5px;
			font-size:12px;
		}
		#carikaryawan .formcari label{
			font-size:14px;
		}
		#submit{
			margin-top:5px;
			max-width:80px;
			font-size:12px;
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
	<div class="container">
		<div class="row">
			<div class="col md-3">
				<h1 class="mt-3 mb-1 text-center">DAFTAR KARYAWAN HARIAN</h1>
					<div class='row'>
					<!--
						<div class='d-grid gap-2 d-md-block'>
						<% if session("HA1A") = true then %>
							<a class ="btn btn-primary mb-2 tambah-karyawan" href="<%=url%>/tambah.asp">Tambah Data</a>	
						<% end if %>
						<% if session("HA1E") = true then %>
							<a class ="btn btn-danger mb-2" href="<%=url%>/updateNip.asp">Update Nip</a>
						<% end if %>	
						</div>
					-->
						<div class='d-grid gap-2 d-md-block'>
							<a class ="btn btn-primary mb-2" href="<%=url%>/index.asp">DAFTAR KARYAWAN KONTRAK/TETAP</a>
						</div>
					</div>
			<form action="ajax/CariKaryawanHarian.asp" method="post" name="carikaryawan" id="carikaryawan">
					<div class="row mb-3 formcari">
						<div class="col-3">
							<select class="form-select" aria-label="Default select example" name="cabang" id="selectCabang">
								<option value="">Pilih Area</option>	
							<%
							cabang_cmd.commandText = "select agen_nama,agen_id from glb_m_agen WHERE Agen_AktifYN ='Y' AND Agen_nama NOT LIKE '%XXX%' ORDER BY Agen_Nama"
							set cabang = cabang_cmd.execute
							do until cabang.eof
							%>
								<option value="<%= cabang("agen_id") %> "><%= cabang("agen_nama") %> </option>
							<% 
							cabang.movenext
							loop
							 %> 
							</select>
						</div>
						<div class="col-3">
							<input type="text" class="form-control" placeholder="Cari Berdasarkan Nama" name="nama" id="keyword" autocomplete="off">
						</div>
						<div class="col-3">
							<input type="text" class="form-control" placeholder="Cari Berdasarkan Nip" name="nip" id="keywordNip" autocomplete="off">
						</div>
						<div class="col">
							<div class="form-check form-switch">
								<% if rs("Kry_AktifYN") = "Y" then%>
									<input class="form-check-input" type="checkbox" name="aktif" id="keywordNonAktif" value="Y" onclick="return window.location.href='index.asp?p=N'" checked>
								<% else %>
									<input class="form-check-input" type="checkbox" name="aktif" id="keywordNonAktif" value="N" onclick="return window.location.href='index.asp?p=Y'">
								<% end if %>
								<label class="form-check-label" for="flexSwitchCheckChecked">Aktif </label>
							</div>
						</div>
						<div class='col'>
							<button type="submit" class="btn btn-success" name="submit" id="submit">Cari</button>
						</div>
					</div>
				<input name="urut" id="urut"  type="hidden" value="<%response.write angka%>" size="1" hidden="">
			</form>	
			<div class='row text-center loader'>
				<img src="loader/newloader.gif">
			</div>
				<div id="container2" style="overflow-x:auto;">
					<input name="urut" id="urut"  type="hidden" value="<%response.write angka%>" size="1" hidden="">	
						<table class="table table-dark table-striped" cellpadding="10" cellspacing="0" id="table">
						<tr>
							<th>
								<% if orderBy = "ORDER BY Kry_Nip ASC" then %>
									<a href="index.asp?a=OBK_N&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> NIP</a> 
								<% else %>
									<a href="index.asp?q=OBK_N&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> NIP</a>
								<% end if %>
							</th>
							<th>
								<% if orderBy = "ORDER BY Kry_Nama ASC" then %>
									<a href="index.asp?b=OBK_N&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> NAMA</a>
								<% else %>
									<a href="index.asp?r=OBK_NM&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> NAMA</a>
								<% end if %>
							</th>
							<th>
								<% if orderBy = "ORDER BY Kry_ActiveAgenID ASC" then %>
									<a href="index.asp?c=OBK_N&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> PENGGAJIAN DI</a>
								<% else %>
									<a href="index.asp?s=OBK_A&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> PENGGAJIAN DI</a>
								<% end if %>
							</th>
							<th>
									<a href="#" style="text-decoration:none;color:#fff;"> AKTIF AGEN</a>
							</th>
							<th>
								<% if orderBy = "ORDER BY Kry_TglMasuk ASC" then %>
									<a href="index.asp?d=OBK_N&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> TANGGAL MASUK</a>
								<% else %>
									<a href="index.asp?t=OBK_TM&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> TANGGAL MASUK</a>
								<% end if %>
							</th>
							<th>
								<% if orderBy = "ORDER BY Kry_TglKeluar ASC" then %>
									<a href="index.asp?e=OBK_N&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> TANGGAL KELUAR</a>
								<% else %>
									<a href="index.asp?u=OBK_TK&p=<%= p %>" style="text-decoration:none;color:#fff;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> TANGGAL KELUAR</a>
								<% end if %>
							</th>
							<th class="text-center" id="thaktif">AKTIF</th>
							<th class="text-center" id="thdetail">DETAIL</th>
						</tr>
						<%
							'prints records in the table
							showrecords = recordsonpage
							recordcounter = requestrecords
							do until showrecords = 0 OR  rs.EOF
							recordcounter = recordcounter + 1
							
						%>
						<tr>
							<td><%= rs("Kry_NIP")%></td>
							<td><%= rs("Kry_Nama")%></td> 
							<% 
							cbg=""
							cabang_cmd.commandText = "select agen_nama from glb_m_agen where agen_ID = '"& rs("Kry_AgenID") &"' "
							set cabang = cabang_cmd.execute
							
							
							cabangaktif_cmd.commandText = "select agen_nama from glb_m_agen where agen_ID = '"& rs("Kry_activeAgenID") &"' "
							set aktifAgen = cabangaktif_cmd.execute
							
							if not cabang.eof then cbg = cabang("agen_nama") end if
							' if not aktifAgen.eof  then aktifcbg = cabang("agen_nama") end if
							 %> 
							<td><%= cbg%></td>
							<td><a href="forms/activeAgen.asp?nip=<%= rs("Kry_Nip") %>" style="color:#fff;text-decoration:none;"><%= aktifAgen("Agen_nama") %></a></td>
							<td><%= rs("Kry_TglMasuk")%></td>
							<td>
								<% if rs("Kry_TglKeluar") = "1/1/1900" then %>
									
								<% else %>
									<%= rs("Kry_TglKeluar") %>
								<% end if %>
							</td>
							<td class="text-center">
								<% if session("HA1D") = true then %>
									<% if rs("Kry_AktifYN") = "Y" then %>
										<button type="button" class="btn btn-outline-success btn-sm" onclick="return confirm('YAKIN UNTUK DIRUBAH???') == true?window.location.href='updateaktif.asp?p=Y&q=<%= rs("Kry_Nip") %>': false"><%= rs("Kry_AktifYN")%></button>
									<% else %>
										<button type="button" class="btn btn-outline-danger btn-sm" onclick="return confirm('YAKIN UNTUK DIRUBAH???') == true? window.location.href='updateaktif.asp?p=N&q=<%= rs("Kry_Nip") %>': false"><%= rs("Kry_AktifYN")%></button>
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
								<a href="detail-karyawan/index.asp?nip=<%= rs("Kry_NIP")%>" class="btn btn-outline-info btn-sm" name="detail">Detail</a>
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
					 <!-- paggination -->
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item">
								<% if requestrecords <> 0 then %>
								<a class="page-link" href="index.asp?offset=<%= requestrecords - recordsonpage%>&angka=<%=angka%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">&#x25C4; Previous </a>
								<% else %>
								<p class="page-link-p">&#x25C4; Previous </p>
								<% end if %>
							</li>
							<li class="page-item d-flex" style="overflow-y:auto;">	
								<%
								pagelist = 0
								pagelistcounter = 0
								maxpage = 5
								nomor = 0
								do until pagelist > allrecords  
								pagelistcounter = pagelistcounter + 1

								%>	
									<a class="page-link hal d-flex active" href="index.asp?offset=<%= pagelist %>&angka=<%=angka%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>"><%= pagelistcounter %></a>  
								<%
								pagelist = pagelist + recordsonpage
								loop
								%>
							</li>
							<li class="page-item">
								<% if(recordcounter > 1) and (lastrecord <> 1) then %>
								<a class="page-link next" href="index.asp?offset=<%= requestrecords + recordsonpage %>&angka=<%=angka%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">Next &#x25BA;</a>
								<% else %>
								<p class="page-link next-p">Next &#x25BA;</p>
								<% end if %>
							</li>	
						</ul>
					</nav>
					 <!-- end pagging -->
			</div>
		</div>
  
</body>

<!-- #include file='layout/footer.asp' -->
	<!-- end koneksi ke database -->
