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

<div class="content">
    <table class="table table-striped"> 

      <input name="urut" id="urut"  type="hidden" value="<%response.write angka%>" size="1" hidden="">
        <thead>
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
					'cek query sql
					'response.Write sql & "<BR>" 
				  %>
		
				  <%
                
					'prints records in the table
          
				    showrecords = recordsonpage
					recordcounter = requestrecords
					do until showrecords = 0 OR  rs.EOF
					recordcounter = recordcounter + 1
				  %>
        <tbody> 
            <tr class="text-center"> 
              <td><%= i %> </td>
              <td><%= rs("Div_Code") %> </td>
              <td><%= rs("Div_Nama") %> </td>
              <td><%= rs("Div_AktifYN") %> </td>
              <td><%= rs("Div_UpdateID") %> </td>
              <td><%= rs("Div_UpdateTime") %> </td>
              <td>
                <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                  <a href="#" class="btn btn-primary modalUbah" data-bs-toggle="modal" data-bs-target="#formModal" data-id="<%= rs("Div_Code") %>" data-nm="<%= rs("Div_Nama") %> ">
                Update
                </a>
                  <a href="aktifId.asp?codeY=<%= rs("Div_Code") %>" class="btn btn-warning btn-sm" name="yes" id="yes">Yes</a>
                  <a href="aktifId.asp?codeN=<%= rs("Div_Code") %> " class="btn btn-danger btn-sm" name="no" id="no">No</a>    
              </td>
              </div>
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
      
      <% if requestrecords <> 0 then %>
				<a class="prev" href="index.asp?offset=<%= requestrecords - recordsonpage%>&angka=<%=angka%>&code=<%=code%>&nama=<%=nama%>&aktifId=<%=aktifId%>&updateId=<%=updateId%>&uTime=<%=uTime%>">&#x25C4; Prev </a>
			<% else %>
				<p class="prev-p">&#x25C4; Prev </p>
			<% end if %>

			<% if(recordcounter > 1) and (lastrecord <> 1) then %>
				<a class="next" href="index.asp?offset=<%= requestrecords + recordsonpage %>&angka=<%=angka%>&code=<%=code%>&nama=<%=nama%>&aktifId=<%=aktifId%>&updateId=<%=updateId%>&uTIme=<%=uTIme%>">Next &#x25BA;</a>
			<% else %>
				<p class="next-p">Next &#x25BA;</p>
			<% end if %>
					
					
			<%
			pagelist = 0
			pagelistcounter = 0
			do until pagelist > allrecords  
			pagelistcounter = pagelistcounter + 1
			%>
				<a class="hal" href="index.asp?offset=<% = pagelist %>&angka=<%=angka%>&code=<%=code%>&nama=<%=nama%>&aktifId=<%=aktifId%>&updateId=<%=updateId%>&uTime=<%=uTime%>"><%= pagelistcounter %></a> 
			<%
			pagelist = pagelist + recordsonpage
			loop
			%>
</div>