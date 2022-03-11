<!-- #include file='../../connection.asp' -->
<% 
  dim pinjaman_cmd,pinjaman, no, tgla, tgle, nama, nip, area, root

  ckTgl = Request.Form("ckTgl")
  if ckTgl = "" then
    ckTgl = Request.QueryString("ckTgl")
  end if

  ckNama = Request.Form("ckNama")
  if ckNama = "" then
    ckNama = Request.QueryString("ckNama")
  end if
  
  ckArea = Request.Form("ckArea")
  if ckArea = "" Then 
    ckArea = Request.QueryString("ckArea")
  End if

  tgla = Request.Form("tgla")
  if tgla = "" then
    tgla = Request.QueryString("tgla")
  end if

  tgle = Request.Form("tgle")
  if tgle = "" then
    tgle = Request.QueryString("tgle")
  end if

  nip = Request.Form("nip")
  if nip = "" then
    nip = Request.QueryString("nip")
  end if

  nama = Request.Form("nama")
  if nama = "" then
    nama = Request.QueryString("nama")
  end if

  area = Request.Form("area")
  if area = "" then
    area = Request.QueryString("area")
  end if

  set pinjaman_cmd = Server.CreateObject("ADODB.Command")
  pinjaman_cmd.activeConnection = mm_cargo_String

  query = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_T_PK.TPK_ID, HRD_T_PK.TPK_Tanggal, HRD_T_PK.TPK_Nip, HRD_T_PK.TPK_Ket, HRD_T_PK.TPK_PP, HRD_T_PK.TPK_Bunga, HRD_T_PK.TPK_Lama, HRD_T_PK.TPK_AktifYN FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_PK ON HRD_M_karyawan.Kry_Nip = HRD_T_PK.TPK_Nip LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_T_PK.TPK_Ket NOT LIKE '%elektronik ke%' AND TPK_ID IS NOT NULL"

  if tgla <> "" and tgle <> "" then
    filterTgl = " AND HRD_T_PK.TPK_tanggal BETWEEN '"& Cdate(tgla) &"' AND '"& Cdate(tgle) &"'"
  else
    filterTgl = ""
  end if

  if nama <> "" then
    filterNama = " AND HRD_M_karyawan.Kry_Nama LIKE '%"& nama &"%'"
  else  
    filterNama = ""
  end if

  if area <> "" then
    filterArea = " AND HRD_M_Karyawan.Kry_AgenID = '"& area &"'"
  else
    filterArea = ""
  end if
  orderBy = " ORDER BY HRD_T_PK.TPK_Tanggal DESC"

  If ckTgl <> "" and ckNama <> "" then
    root = query + filterTgl + filterNama + orderBy
  elseIf ckTgl <> "" and ckArea <> "" then
    root = query + filterTgl + filterArea + orderBy
  elseIf ckNama <> "" and ckArea <> "" then
    root = query + filterNama + filterArea + orderBy
  elseIf ckTgl <> "" then
    root = query + filterTgl + orderBy
  elseIf ckNama <> "" then
    root = query + filterNama + orderBy
  elseIf ckArea <> "" then
    root = query + filterAre + orderBy
  else
    root = query + orderBy
  end if  

  pinjaman_cmd.commandText = root
  ' Response.Write pinjaman_cmd.commandText & "<br>"
  set pinjaman = pinjaman_cmd.execute

  ' select area aktif
  pinjaman_cmd.commandText = "SELECT Agen_id, Agen_Nama FROM GLB_M_Agen WHERE Agen_AktifYN = 'Y' ORDER BY Agen_Nama ASC"
  set agen = pinjaman_cmd.execute

  ' paggination
  Set Connection = Server.CreateObject("ADODB.Connection")
  Connection.Open MM_Cargo_string

  dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal, sql
  dim orderBy
  dim angka

  angka = request.QueryString("angka")
  if len(angka) = 0 then 
    angka = 1
  else 
    angka = angka + 1
  end if

  set rs = Server.CreateObject("ADODB.Recordset")

  sqlawal = root

  sql= sqlawal 

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

  sqlawal = root

  sql=sqlawal 

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
    <title>PINJAMAN KARYAWAN</title>
    <!-- #include file='../../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <script>
      function format(number){
        var rupiah = '';
        var angkarev = number.toString().split('').reverse().join('');
        for (var i = 0; i < angkarev.length; i++) if (i % 3 === 0) rupiah += angkarev.substr(i, 3) + '.';
          return rupiah.split('', rupiah.length - 1).reverse().join('') + ',-';
      }
      function aktifPinjaman(id,p) {
        if (confirm("YAKIN UNTUK DI RUBAH??") === true ){
          return window.location.href = "aktif.asp?id="+id+"&p="+p
        }else{
          return false;
        }
      }
      function validasiPinjaman() {
        let nip = $("#nip").val();
        let ket = $("#keterangan").val();
        if (nip.length > 10){
          alert('Maximal Nip 10 character');
          return false;
        }else if (ket.length > 100 ){
          alert("Maximal Keterangan 100 Chacracter!!!");
          return false;
        }else{
          return true;
        }
      }
      function tambahPinjaman(){
        $('#tgl').attr("type","date");
        $('#tgl').attr("readonly",false);
        $('#cicilan').attr("readonly",true);
        $('#calender').hide();

        $('#nomor').val('');
        $('#tgl').val('');
        $('#nip').val('');
        $('#nama').val('');
        $('#keterangan').val('');
        $('#hutang').val('');
        $('#bunga').val('');
        $('#lama').val('');
        $('#cicilan').val('');
        $('#tpinjaman').val('');
        
        $('.modal-body form').attr('action', 'pinjaman_add.asp');
      }
      function updatePinjaman(i,j,k,l,m,n,o,p){
        // hitung cicilan
        let cicilan = 0;
        cicilan = n / p;
        cicilan = Math.round(cicilan);

        $('#calender').show();
        let tgl = $('#tgl');
                
        tgl.attr("type","text");
        tgl.attr("readonly",true);
        $('#cicilan').attr("readonly",true);
              
        $('#nomor').val(i);
        tgl.val(k);
        $('#nip').val(j);
        $('#nama').val(l);
        $('#keterangan').val(m);
        $('#hutang').val(format(n));
        $('#bunga').val(format(o));
        $('#lama').val(p);
        $('#cicilan').val(format(cicilan));
        $('#tpinjaman').val(format(n));
        $('.modal-body form').attr('action', 'pinjamanUpdate_add.asp');
      }
      function rupiah(nilai,nama) {
        let hutang = 0;
        let tpinjaman = 0;
        let cicilan = 0;
        if (nama === "hutang"){
          if ( nilai == 0 ){
            $('#hutang').val(format(0));
          }else{
            hutang = parseInt(nilai)
            $('#hutang').val(format(hutang));
          }
        }else if ( nama === "tpinjaman" ){
          if (nilai == 0){
            $('#tpinjaman').val(format(0));
          }else{
            tpinjaman = parseInt(nilai);
            $('#tpinjaman').val(format(tpinjaman));
          }
        }else if ( nama === "cicilan" ){
          if ( nilai == 0 ){
            $('#cicilan').val(format(0));
          }else{
            cicilan = parseInt(nilai);
            $('#cicilan').val(format(cicilan));
          }
        }
      }
      function getTgl(){
        $('#tgl').attr("readonly",false);
        $('#tgl').attr("type","date");
      }
      // form seach data 
      function hitungCicilan(){
        let hutang = $('#hutang').val();
        let lama = parseInt($('#lama').val());
        let tcicilan = 0;
        
        let thutang =  parseInt(hutang.replace(/[^\w\s]/gi, ''));

        tcicilan = thutang / lama;
        if (!$('#lama').val()){
          $('#cicilan').val("0");
        }else{
          $('#cicilan').val(format(Math.round(tcicilan)));
        }

        $("#tpinjaman").val(hutang);
      }
    </script>
    <style>
      #form-tgla{
        background:none;
      }
      #form-tgle{
        background:none;
      }
      #form-nip{
        background:none;
      }
      #form-nama{
        background:none;
      }
      #area{
        background:none;
      }
      hr{
        padding:0;
        margin-top:-1px;
        margin-bottom:-3px;
      }
      .checkTgl{
        width:15px;
        margin-top:7px;
      }
      @media only screen and (max-width: 600px){
        #cariPenjaman{
          margin-top:15px;
        }
        .modalPinjaman{
          max-width:410px;
        }
      }
      #notifPinjaman{
        width:70%;
        height:15vh;
        margin:auto;
        margin-top:50px;
        text-align: center;
        position:relative;
      }
      #notifPinjaman h2{
        position:absolute;
        top:60%;
        left:50%;
        transform:translate(-50%, -50%);
      }
      @media screen and (min-width: 676px) {
          .modal-dialog {
            max-width: 600px;
          }
      }
    </style>
</head>
<body>
<div class='container'>
    <div class='row'>
        <div class='col text-center mt-3'>
            <h3>PINJAMAN KARYAWAN</h3>
        </div>
    </div>
    <div class='row mt-2'>
      <div class='col'>
        <div class="btn-group" role="group" aria-label="Basic mixed styles example">
          <button type="button" class="btn btn-secondary btn-sm" onclick="window.location.href='../index.asp'"><i class="fa fa-backward" aria-hidden="true"></i> Kembali</button>
          <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#modalPimjaman" onclick="return tambahPinjaman()"><i class="fa fa-plus" aria-hidden="true"></i> Tambah</button>
          <% if tgla <> "" OR tgle <> "" OR nama <> "" OR area <> "" then %>
          <button type="button" class="btn btn-success btn-sm" onclick="window.open('Export-AllPinjaman.asp?tgla=<%=tgla%>&tgle=<%=tgle%>&nama=<%=nama%>&area=<%=area%>&ckTgl=<%= ckTgl %>&ckNama=<%= ckNama %>&ckArea=<%= ckArea %>')"><i class="fa fa-print" aria-hidden="true"></i> Cetak</button>
          <% end if %>
        </div>
      </div>
    </div>
    <div class="header p-2 mt-2">
      <div class='row'>
      <form action="pinjamanKaryawan.asp" method="post" id="form-cari">
        <div class='col'>
          <div class="mb-3 row ">
            <div class='col-sm-1 checkTgl'>
              <input class="form-check-input" type="checkbox" id="ckTgl" name="ckTgl">
            </div>
            <label for="ckTgl" class="col-sm-2 col-form-label">Priode Tanggal</label>
            <div class="col-sm-2">
              <input type="date" class="form-control border-0" id="form-tgla" name="tgla" >
              <hr>
            </div>
            <div class="col-sm-2">
              <input type="date" class="form-control border-0" id="form-tgle" name="tgle">
              <hr>
            </div>
          </div>
        </div>
      </div>
      <div class='row'>
        <div class='col'>
          <div class="mb-3 row">
            <div class='col-sm-1 checkTgl'>
              <input class="form-check-input" type="checkbox" name="ckNama" id="ckNama">
            </div>
            <label for="ckNama" class="col-sm-2 col-form-label">Nama Karyawan</label>
            <div class="col-sm-7">
              <input type="text" class="form-control border-0" id="form-nama" name="nama" placeholder="Nama" autocomplete="off">
              <hr>
            </div>
          </div>
        </div>
      </div>
      <div class='row'>
        <div class='col'>
          <div class="mb-3 row">
            <div class='col-sm-1 checkTgl'>
              <input class="form-check-input" type="checkbox" name="ckArea" id="ckArea">
            </div>
            <label for="ckArea" class="col-sm-2 col-form-label">Area Aktif</label>
            <div class="col-sm-7">
              <select class="form-select border-0" aria-label="Default select example" id="area" name="area">
                <option value="">Pilih</option>
                <% do until agen.eof %>
                  <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                <% 
                agen.movenext
                loop
                 %>
              </select>
              <hr>
            </div>
            <div class='col align-self-end'>
              <button type="submit" class="btn btn-primary btn-sm" id="cariPenjaman"><i class="fa fa-search" aria-hidden="true"></i> cari</button>
            </div>
      </form>
          </div>
        </div>
      </div>
    </div>
    <!--pencarian -->
    <div class='row'>
      <div class='col text-center'>
        <% if rs.eof then%>
          <div data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman"><h3>DATA TIDAK TERDAFTAR ATAU ANDA SALAH MEMASUKAN KEYWORD MOHON COBA KEMBALI</h3></div>
        <% else %>
      </div>
    </div>
    <div class='row'>
        <div class='col'>
            <table class="table">
            <thead>
                <tr>
                <th scope="col">No</th>
                <th scope="col">Tanggal</th>
                <th scope="col">Nip</th>
                <th scope="col">Nama</th>
                <th scope="col">Ketarangan</th>
                <th scope="col">Bunga</th>
                <th scope="col">Pinjaman</th>
                <th scope="col">Aktif</th>
                <th scope="col" class="text-center">Aksi</th>
                </tr>
            </thead>
            <tbody>
                <% 
                showrecords = recordsonpage
                recordcounter = requestrecords
                do until showrecords = 0 OR  rs.EOF
                recordcounter = recordcounter + 1
                %>
                <tr>
                    <th scope="row"><%= rs("TPK_ID") %></th>
                    <td><%= rs("TPK_Tanggal") %></td>
                    <td><%= rs("TPK_Nip") %></td>
                    <td><%= rs("Kry_Nama") %></td>
                    <td><%= rs("TPK_Ket") %></td>
                    <td><%= rs("TPK_Bunga") %></td>
                    <td><%= replace(formatCurrency(rs("TPK_PP")),"$","") %></td>
                    <td><%if rs("TPK_AktifYN") = "Y" then %>Aktif <% else %> NonAktif <% end if %></td>
                    <td>
                      <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="button" class="btn btn-primary btn-sm py-0 px-2" onclick="return updatePinjaman('<%=rs("TPK_ID")%>','<%= rs("TPK_Nip") %>','<%= rs("TPK_Tanggal") %>','<%= rs("Kry_Nama") %>','<%= rs("TPK_ket") %>','<%= rs("TPK_pp") %>','<%= rs("TPK_Bunga") %>','<%= rs("TPK_lama") %>')" data-bs-toggle="modal" data-bs-target="#modalPimjaman">Edit</button>
                        <% if rs("TPK_AktifYN") = "Y" then %>
                          <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return aktifPinjaman('<%=rs("TPK_ID")%>','<%= rs("TPK_AktifYN") %>')">NonAktif</button>
                        <% else %>
                          <button type="button" class="btn btn-warning btn-sm py-0 px-2" onclick="return aktifPinjaman('<%=rs("TPK_ID")%>','<%= rs("TPK_AktifYN") %>')">Aktif</button>
                        <% end if %>
                          <button type="button" class="btn btn-secondary btn-sm py-0 px-2" onclick="window.open('EXPORT-Pinjaman.asp?p=<%= rs("TPK_ID") %>')">Cetak</button>
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
                if requestrecords <> 0 then 
                %>
								  <a class="page-link" href="pinjamanKaryawan.asp?offset=<%= requestrecords - recordsonpage%>&page=<%= npage %>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNip=<%= ckNip %>&ckArea=<%= ckArea %>">&#x25C4; Previous </a>
								<% else %>
								  <p class="page-link-p">&#x25C4; Previous </p>
								<% end if %>
							</li>
							<li class="page-item d-flex" style="overflow-y:auto;">	
								<%
                ' Response.Write tgla 
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
									<a class="page-link d-flex bg-primary text-light" href="pinjamanKaryawan.asp?offset=<%= pagelist %>&Page=<%=pagelistcounter%>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNip=<%= ckNip %>&ckArea=<%= ckArea %>"><%= pagelistcounter %></a>  
                <% else %>
									<a class="page-link d-flex" href="pinjamanKaryawan.asp?offset=<%= pagelist %>&Page=<%=pagelistcounter%>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNip=<%= ckNip %>&ckArea=<%= ckArea %>"><%= pagelistcounter %></a>  
                <% end if %>
								<%
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
								<a class="page-link next" href="pinjamanKaryawan.asp?offset=<%= requestrecords + recordsonpage %>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&page=<%=page%>&ckTgl=<%= ckTgl %>&ckNip=<%= ckNip %>&ckArea=<%= ckArea %>">Next &#x25BA;</a>
								<% else %>
								<p class="page-link next-p">Next &#x25BA;</p>
								<% end if %>
							</li>	
						</ul>
					</nav>
                <!--end pagging -->
        </div>
      <% end if %>
    </div>
</div>
<!-- Modal -->
<div class="modal fade modalPinjaman" id="modalPimjaman" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">From Pinjaman</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
      <form action='pinjaman_add.asp' method='post' onsubmit="return validasiPinjaman()">
        <div class="row mb-3">
          <label for="nomor" class="col-sm-4 col-form-label col-form-label-sm">Nomor</label>
          <div class="col-sm-5">
            <input type="text" class="form-control form-control-sm" id="nomor" name='nomor' placeholder="Nomor" readonly>
          </div>
        </div>
        <div class="row mb-3">
          <label for="tgl" class="col-sm-4 col-form-label col-form-label-sm">Tanggal</label>
          <div class="col-sm-5">
            <input type="date" class="form-control form-control-sm" id="tgl" name='tgl' required>
          </div>
          <div class="col-sm-2">
            <button type="button" class="ui-datepicker-trigger" style="display:none;background-color:none;" onclick="return getTgl()" id="calender"><i class="fa fa-calendar-check-o" aria-hidden="true"></i></button>
          </div>
        </div>
        <div class="row mb-3">
          <label for="nama" class="col-sm-4 col-form-label col-form-label-sm">Nama Karyawan</label>
          <div class="col-sm-3">
            <input type="number" class="form-control form-control-sm  m-0" id="nip" name='nip' placeholder="Nip" readonly>
          </div>
          <div class="col-sm-5">
            <input type="text" class="form-control form-control-sm m-0" id="nama" name='nama' placeholder="Masukan Nama" autocomplete="off" required>
          </div>
        </div>
        <div class='row justify-content-end'>
          <div class="col-sm-8 p-0 tableKaryawan">
          </div>
        </div>
        <div class="row mb-3">
          <label for="keterangan" class="col-sm-4 col-form-label col-form-label-sm">Keterangan</label>
          <div class="col-sm-8">
            <textarea class="form-control" placeholder="Leave a comment here" id="keterangan" name='keterangan' placeholder="Keterangan" required></textarea>
          </div>
        </div>
        <div class="row mb-3">
          <label for="pinjamanan" class="col-sm-4 col-form-label col-form-label-sm">Pinjaman</label>
          <div class="col-sm-4">
            <input type="text" class="form-control form-control-sm" id="hutang" name='hutang' onchange="rupiah(this.value,'hutang')" required>
          </div>
        </div>
        <div class="row mb-3">
          <label for="bunga" class="col-sm-4 col-form-label col-form-label-sm">Total Bunga</label>
          <div class="col-sm-4">
            <input type="text" class="form-control form-control-sm" id="bunga" name='bunga' required>
          </div>
          <div class="col-sm-2 y-0 x-0 p-0">
            <p>%</p>
          </div>
        </div>
        <div class="row mb-3">
          <label for="tpinjaman" class="col-sm-4 col-form-label col-form-label-sm">Total Pinjaman</label>
          <div class="col-sm-4">
            <input type="text" class="form-control form-control-sm" id="tpinjaman" name='tpinjaman' oninput="return hitungCicilan()" readonly>
          </div>
        </div>
        <div class="row mb-3">
          <label for="lama" class="col-sm-4 col-form-label col-form-label-sm">Lama Pinjaman</label>
          <div class="col-sm-4">
            <input type="number" class="form-control form-control-sm" id="lama" name='lama' oninput="return hitungCicilan()" placeholder="Lama Pinjaman" required>
          </div>
          <div class="col-sm-4">
            <p>/Bulan</p>
          </div>
            <input type="hidden" class="form-control form-control-sm" id="id" name='id' value ="<%= session("username") %>" >
        </div>
        <div class="row mb-3">
          <label for="cicilan" class="col-sm-4 col-form-label col-form-label-sm">Cicilan</label>
          <div class="col-sm-4">
            <input type="text" class="form-control form-control-sm" id="cicilan" name='cicilan' value="0" readonly>
          </div>
        </div>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Save</button>
      </div>

      </form>
    </div>
  </div>
</div>
<script>
// $('#ckTgl').click(function (){
//   $('#form-tgla').attr('disabled', false);
//   $('#form-tgle').attr('disabled', false);
//   $('#form-nip').attr('disabled', true);
//   $('#form-nama').attr('disabled', true);
//   $('#area').attr('disabled', true);

//   $('#form-nip').text('');
//   $('#form-nama').text('');
//   $('#area').text('');

// });
// $('#ckNip').click(function (){
//   $('#form-tgla').attr('disabled', true);
//   $('#form-tgle').attr('disabled', true);
//   $('#form-nip').attr('disabled', false);
//   $('#form-nama').attr('disabled', false);
//   $('#area').attr('disabled', true);
// });
// $('#ckArea').click(function (){
//   $('#form-tgla').attr('disabled', true);
//   $('#form-tgle').attr('disabled', true);
//   $('#form-nip').attr('disabled', true);
//   $('#form-nama').attr('disabled', true);
//   $('#area').attr('disabled', false);
// });
$('#nama').on('keyup', function (result) {
     $.get(`cariKaryawan.asp?key=${$('#nama').val().toUpperCase().replace(' ', '%20')}`, function (data) {
      $(".tableKaryawan").show();
      $(".tableKaryawan").html(data);
    });
})
function clickRadio(value1,value2){
  $('#nip').val(value1);
  $('#nama').val(value2);
  $(".tableKaryawan").hide();
}
</script>
<!-- #include file='../../layout/footer.asp' -->   