<!--#include file="../includes/query.asp"-->
<% 

dim key

key = Request.QueryString("key")

Set divisi_cmd = Server.CreateObject ("ADODB.Command")
divisi_cmd.ActiveConnection = MM_cargo_STRING

divisi_cmd.commandText ="SELECT * FROM HRD_M_Divisi  WHERE Div_Nama LIKE '%" & key & "%' "

set rs = divisi_cmd.execute

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

orderBy = " order by Div_Code, Div_Nama, Div_AktifYN, Div_UpdateID, Div_UpdateTime"

set rs = Server.CreateObject("ADODB.Recordset")

sqlawal = "SELECT * FROM HRD_M_Divisi  WHERE Div_Nama LIKE '%" & key & "%' "


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

sqlawal = "SELECT * FROM HRD_M_Divisi  WHERE Div_Nama LIKE '%" & key & "%' "

sql=sqlawal + orderBy

rs.open sql, conn

hiddenrecords = requestrecords
do until hiddenrecords = 0 OR rs.EOF
  hiddenrecords = hiddenrecords - 1
  rs.movenext
  if rs.EOF then
    lastrecord = 1
  end if	
loop
%>
<style>
  .content{
        overflow-x:auto;
      }
      .table{
        font-size:14px;
      }
      .table thead{
        white-space: nowrap;
      }
      .btn-group{
				  font-size:12px;
        }
       @media screen and (max-width:540px)
      {
        .btn-group{
				  font-size:12px;
        }
        .table
        {
          font-size:12px;
        }
      }
</style>
<div class="content">
    <table class="table table-striped"> 
      <input name="urut" id="urut"  type="hidden" value="<%response.write angka%>" size="1" hidden="">
        <thead class="bg-secondary text-light">
          <tr>
            <th class="text-center" scope="col">No</th>
            <th class="text-center" scope="col">Code</th>
            <th class="text-center" scope="col">Nama</th>
            <th class="text-center" scope="col">Aktif ID</th>
            <th class="text-center" scope="col">Update ID</th>
            <th class="text-center" scope="col">Terakhir Update</th>
            <th class="text-center" scope="col">Aksi</th>
          </tr>
        </thead>
                
        <tbody>
				<%
          showrecords = recordsonpage
          recordcounter = requestrecords
          do until showrecords = 0 OR  rs.EOF
          recordcounter = recordcounter + 1
				%>
            <tr class="text-center"> 
              <td><%= recordcounter %> </td>
              <td><%= rs("Div_Code") %> </td>
              <td><%= rs("Div_Nama") %> </td>
              <td><%= rs("Div_AktifYN") %> </td>
              <td><%= rs("Div_UpdateID") %> </td>
              <td><%= rs("Div_UpdateTime") %> </td>
              <td>
                <div class="btn-group" role="group" aria-label="Basic mixed styles example" id="buttondivisi">
                  <% if session("HA4B") = true then%>
                    <button class="btn btn-primary btn-sm modalUbah" data-bs-toggle="modal" data-bs-target="#formModal" type="button" onclick="return ubahData('<%= rs("Div_Code") %>', '<%= rs("Div_Nama") %>')">Update</button>
                  <% end if %>
                  <% if session("HA4C") = true then%>
                    <%if rs("Div_aktifYN") = "Y" then%>
                      <button class="btn btn-warning btn-sm" type="button" onclick="return aktifDivisi('<%= rs("Div_Code") %>')">NoAktif</button>
                    <%else%>
                      <button class="btn btn-danger btn-sm" type="button" onclick="return aktifDivisi('<%= rs("Div_Code") %>')">Aktif</button>
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
