<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../../login.asp")
end if
 %>
<!--#include file="../includes/query.asp"-->
<% 

dim key

key = Request.QueryString("key")

jabatan_cmd.commandText = "SELECT * FROM HRD_M_Jabatan  WHERE Jab_Nama LIKE '%" & key & "%' "
jabatan_cmd.prepared = true
set jabatan = jabatan_cmd.execute

set conn = Server.CreateObject("ADODB.Connection")
conn.open MM_Cargo_string

dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal
dim angka
dim code, nama, aktifId, UpdateId, uTIme, orderBy

' untuk angka
angka = request.QueryString("angka")
if len(angka) = 0 then 
	angka = Request.form("urut") + 1
end if

' untuk data
code = Request.QueryString("code")
if len(code) = 0 then
    code = Request.form("code")
end if

nama = Request.QueryString("nama")
if len(nama) = 0 then 
    nama = Request.form("nama")
end if

aktifId = Request.QueryString("aktifId")
if len(aktifId) = 0 then    
    aktifId = Request.form("aktifId")
end if

updateId = Request.QueryString("updateId")
if len(updateId) = 0 then
    updateId = Request.form("updateId")
end if

uTime = Request.QueryString("uTime")
if len(uTime) = 0 then
    uTime = Request.form("uTime")
end if

orderBy = " order by Jab_Code, Jab_Nama, Jab_AktifYN, Jab_UpdateID, Jab_UpdateTime"

set rs = Server.CreateObject("ADODB.Recordset")

sqlawal = "SELECT * FROM HRD_M_Jabatan  WHERE Jab_Nama LIKE '%" & key & "%'"

sql=sqlawal + orderBy

rs.open sql, conn

' records per halaman
recordsonpage = 10

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

set rs = server.CreateObject("ADODB.RecordSet")

sqlawal = "SELECT * FROM HRD_M_Jabatan  WHERE Jab_Nama LIKE '%" & key & "%'"
sql=sqlawal + orderBy

rs.open sql, conn

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
  <%if rs.eof then%>
  <div class='mt-3 text-center' data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman">
    <div class='notiv-header'>
			<label>WARNING !!!</label>
		</div>
		<div class='content-pernama'>
			<p>DATA TIDAK DI TEMUKAN</p>
			<p>MOHON MASUKAN KEYWORD KEMBALI UNTUK PENCARIAN ULANG</p>
		</div>
	</div>
  </div>
  <% else %>
  <div class="content">
    <table class="table table-striped"> 

      <input name="urut" id="urut"  type="hidden" value="<%response.write angka%>" size="1" hidden="">
        <thead class="bg-secondary text-light">
          <tr>
            <th class="text-center" scope="col">No</th>
            <th class="text-center" scope="col">ID</th>
            <th class="text-center" scope="col">Nama</th>
            <th class="text-center" scope="col">Aktif ID</th>
            <th class="text-center" scope="col">Update ID</th>
            <th class="text-center" scope="col">Terakhir Update</th>
            <th class="text-center" scope="col">Aksi</th>
          </tr>
        </thead>
                
        <tbody>
          <%
          i = 0

				    showrecords = recordsonpage
					recordcounter = requestrecords
					do until showrecords = 0 OR  rs.EOF
					recordcounter = recordcounter + 1
          i = i + 1
				  %>
        <tbody> 
            <tr class="text-center"> 
              <td><%= i %> </td>
              <td><%= rs("Jab_Code") %> </td>
              <td><%= rs("Jab_Nama") %> </td>
              <td><%= rs("Jab_AktifYN") %> </td>
              <td><%= rs("Jab_UpdateID") %> </td>
              <td><%= rs("Jab_UpdateTime") %> </td>
              <td>
                <div class="btn-group" role="group" aria-label="Basic mixed styles example" id="buttonjenjang">
                  <%if session("HA6A") = true then%>
                    <button type="button" class="btn btn-primary btn-sm" id='ubahJabatan' data-bs-toggle="modal" data-bs-target="#formModal" onclick="return ubahJabatan('<%= rs("Jab_Code") %>','<%= rs("Jab_Nama") %>')">UPDATE</button>
                  <%end if%>
                  <%if session("HA6B") = true then%>
                    <% if rs("Jab_AktifYN") = "Y" then %>
                      <button type="button" class="btn btn-danger btn-sm" onclick="return ubahAktif('<%= rs("Jab_Code") %>','<%= rs("Jab_AktifYN") %>')">NO</button>
                    <% else %>
                      <button type="button" class="btn btn-warning btn-sm" onclick="return ubahAktif('<%= rs("Jab_Code") %>','<%= rs("Jab_AktifYN") %>')">YES</button>
                    <%end if%>
                  <% end if %>   
                </div>
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
        </tbody>
    </table>
  </div>
  <% end if %>