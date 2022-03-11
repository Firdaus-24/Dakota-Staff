<!-- #include file="../connection.asp" -->
<% 
  set jabatan_cmd = Server.CreateObject("ADODB.Command")
  jabatan_cmd.activeConnection = MM_Cargo_string

  jabatan_cmd.commandText = "SELECT * FROM HRD_M_Jabatan"
  jabatan_cmd.prepared = true
  set jabatan = jabatan_cmd.execute

  set conn = Server.CreateObject("ADODB.Connection")
  conn.open MM_Cargo_string

  dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal
  dim angka
  dim code, nama, aktifId, UpdateId, uTIme, orderBy

  ' untuk angka
  angka = request.QueryString("angka")
  page = Request.QueryString("page")
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


  orderBy = " order by Jab_Code, Jab_Nama, Jab_AktifYN, Jab_UpdateID, Jab_UpdateTime"

  set rs = Server.CreateObject("ADODB.Recordset")

  sqlawal = "SELECT * FROM HRD_M_Jabatan"

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

  sqlawal = "SELECT * from HRD_M_Jabatan"
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
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JABATAN</title>
    <!-- #include file='../layout/header.asp' -->
     <script src="../js/jquery-3.5.1.min.js"></script>
    <script src="<%= url %>/jabatan/js/script.js"></script>
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
      .btn-group :.btn{
				font-size:12px;
      }
      @media screen and (max-width:540px)
      {
        .tombolTambah{
          display:block;
				  font-size:12px;
        }
        .btn-group{
				  font-size:10px;
        }
        .table
        {
          font-size:12px;
        }
      }
    </style>
</head>

<body>
<!--#include file="../landing.asp"-->
<div class="container">
    <div class="row">
      <div class="col-md-12 mt-3 mb-3">   
        <h3 class="text-uppercase text-center"> FORM JABATAN </h3>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
      <%if session("HA6D") = true then%>
        <button type="button" class="btn btn-primary tombolTambah mb-3" data-bs-toggle="modal" data-bs-target="#formModal" name="tombolTambah" id="tombolTambah"><i class="fa fa-plus" aria-hidden="true"></i>
        Tambah
        </button>
      <%end if%>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <!-- pencarian -->
        <div class="input-group input-group-sm mb-3 cari">
          <input type="text" class="form-control" name="key" id="key" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="Cari Berdasarkan Nama...." autocomplete="off">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
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
                'prints records in the table
                  showrecords = recordsonpage
                recordcounter = requestrecords
                do until showrecords = 0 OR  rs.EOF
                recordcounter = recordcounter + 1
                %>
              <tbody> 
                  <tr class="text-center"> 
                    <td><%= recordcounter %> </td>
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
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <!-- paggination -->
        <nav aria-label="Page navigation example">
          <ul class="pagination">
            <li class="page-item">
              <% 
              if page = "" then
								npage = 1
							else
								npage = page - 1
							end if
              if requestrecords <> 0 then %>
                <a class="page-link" href="index.asp?offset=<%= requestrecords - recordsonpage%>&angka=<%=angka%>&page=<%=npage%>">&#x25C4; Prev </a>
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
                <a class="page-link hal d-flex bg-primary text-light" href="index.asp?offset=<% = pagelist %>&angka=<%=angka%>&page=<%=pagelistcounter%>"><%= pagelistcounter %></a> 
                <%else%>
                <a class="page-link hal d-flex" href="index.asp?offset=<% = pagelist %>&angka=<%=angka%>&page=<%=pagelistcounter%>"><%= pagelistcounter %></a> 
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
              <% if(recordcounter > 1) and (lastrecord <> 1) then %>
                <a class="page-link next" href="index.asp?offset=<%= requestrecords + recordsonpage %>&angka=<%=angka%>&page=<%=page%>">Next &#x25BA;</a>
              <% else %>
                <p class="page-link next-p">Next &#x25BA;</p>
              <% end if %>
          <!-- end pagging -->	
            </li>	
          </ul>
        </nav>
      </div>
    </div>
  
        	

<!-- tampil modal -->
<div class="modal fade" id="formModal" tabindex="-1" aria-labelledby="formModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="formModalLabel">Update Data</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form method="post" action="tambah.asp">
            <div class="mb-3">
                <label for="id" class="form-label" id="labelID">ID</label>
                <input type="text" class="form-control" name="id" id="id" autofocus="on" autocomplate="off" required>
                <label for="nama" class="form-label">Nama</label>
                <input type="text" class="form-control" name="nama" id="nama" autofocus="on" autocomplate="off" required>
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" name="submit" id="submit" >Update Data</button>
      </form>
      </div>
    </div>
  </div>
</div>
<script>
function ubahJabatan(id, data) {
  $('#formModalLabel').html('UPDATE DATA');
  $('.modal-footer button[type=submit]').html('UPDATE');
  $('.modal-body form').attr('action', 'update.asp');
  // $('#labelID').hide();
  $('#id').attr('readonly', true);
  $('#id').val(id);
  $('#nama').val(data);
}
</script>
<!-- #include file='../layout/footer.asp' -->


