<!-- #include file='connection.asp' -->
<!-- #include file='constend/constanta.asp' -->
<% 
set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = mm_cargo_string

set mutasi_cmd = Server.CreateObject("ADODB.Command")
mutasi_cmd.activeConnection = mm_cargo_string

set updateMutasi = Server.CreateObject("ADODB.Command")
updateMutasi.activeConnection = mm_cargo_string

mutasi_cmd.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_ExecutedYN = 'N' AND Mut_Tanggal <= '" & Month(now()) &"/"& day(now()) &"/"& Year(now()) &"' AND Mut_AktifYN = 'Y' ORDER BY Mut_Tanggal DESC"
' Response.Write mutasi_cmd.commandText & "<br>"
set mutasi = mutasi_cmd.execute

do while not mutasi.eof
    karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_AgenID = '"& mutasi("Mut_TujAgenID") &"', Kry_DDBID = '"& mutasi("Mut_TujDDBID") &"', Kry_JabCode = '"& mutasi("Mut_TujJabCode") &"', Kry_JJID = '"& mutasi("Mut_TujJJID") &"' WHERE Kry_Nip = '"& mutasi("Mut_Nip") &"'"
    ' Response.Write karyawan.commandText & "<br>"
    karyawan_cmd.execute
    
    updateMutasi.commandText = "UPDATE HRD_T_MUTASI SET Mut_ExecutedYN = 'Y' WHERE Mut_ID = '"& mutasi("Mut_ID") &"'"
    updateMutasi.execute 
mutasi.movenext
loop
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DASHBOARD</title>
    <!-- #include file='layout/header.asp' -->
 
     <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
<!--#include file="landing.asp"-->
<!--header -->
<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="<%=url%>/logo/logonavbar.PNG" class="d-block w-100" style="height: 35em;overflow:hidden;">
    </div>
    <div class="carousel-item">
      <img src="<%=url%>/logo/slider-1.jpg" class="d-block w-100" style="height: 35em;overflow:hidden;">
    </div>
    <div class="carousel-item">
      <img src="<%=url%>/logo/slider-2.jpg" class="d-block w-100" style="height: 35em;overflow:hidden;">
    </div>
    <div class="carousel-item">
      <img src="<%=url%>/logo/slider-3.jpg" class="d-block w-100" style="height: 35em;overflow:hidden;">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<section>
<!--end header -->
<div class='container mt-3'>
  <h3 class="text-center">MENU</h3>
  <hr style="color:#fff;">
    <!--convertgaji -->
    <div class='row cards'>
      <!--card laporan -->
      <div class='col-lg card-list' data-aos="fade-down" data-aos-easing="linear" data-aos-duration="700">
        <div class="card text-light mx-3 my-2 card-laporan" style="max-width: 25rem;">
          <div class="card-header">Laporan</div>
            <div class="card-body">
              <i class="fa fa-line-chart" aria-hidden="true" id="reportlogo"></i>
              <h5 class="card-title">Rekapitulasi</h5>
              <p class="card-text">Laporan Kerja Karyawan</p>
              <% if session("HL") = true then %>
                <button type="button" class="btn btn-primary btn-sm buttonLaporan" onclick="window.location.href='<%=url%>/laporan'"><i class="fa fa-eye" aria-hidden="true"></i> Lihat</button>
              <% else %>
                <span style="padding:20px;margin-top:50px;margin-bottom:50px"></span>
              <% end if %>
            </div>
        </div>
      </div>
      
      <div class='col-lg card-list' data-aos="fade-down" data-aos-easing="linear"data-aos-duration="900" data-aos-delay="150">
        <div class="card text-light mx-3 my-2 card-gaji" style="max-width: 25rem;">
          <div class="card-header">Gaji</div>
            <div class="card-body">
              <i class="fa fa-money" aria-hidden="true" id="reportlogo"></i>
              <h5 class="card-title">Warning !!</h5>
              <p class="card-text">Gaji Karyawan All</p>

              <% if session("HL7")=true then %>
                <button type="button" class="btn btn-primary btn-sm setGaji" onclick="return setGaji()" ><i class="fa fa-usd" aria-hidden="true"></i> Set Gaji</button>
              <% else %>
                <span style="padding:20px;margin-top:50px;margin-bottom:50px"></span>
              <% end if %>
            </div>
        </div>
      </div>        
      <!--Setting absensi karyawan -->
      <div class='col-lg card-list' data-aos="fade-down" data-aos-easing="linear"data-aos-duration="1000" data-aos-delay="200">
        <div class="card text-light mx-3 my-2 card-setcuti" style="max-width: 25rem;">
          <div class="card-header">Laporan Absensi</div>
            <div class="card-body">
              <i class="fa fa-plane" aria-hidden="true" id="reportlogo"></i>
              <h5 class="card-title">All Absensi</h5>
              <p class="card-text">Cek Absen Perdivisi</p>
              <% if session("HL2")=true then %>
              <button type="button" class="btn btn-primary btn-sm setCuti" onclick="window.location.href='laporanabsensi/'"><i class="fa fa-retweet" aria-hidden="true"></i> Lihat</button>
              <% else %>
                <span style="padding:20px;margin-top:50px;margin-bottom:50px"></span>
              <% end if %>
            </div>
        </div>
      </div>
    </div>
    <!--setting bpjs -->
    <div class='row'>
      <!--mutasi karyawan -->
      <div class='col-lg card-list' data-aos="fade-down" data-aos-easing="linear"data-aos-duration="1000" data-aos-delay="200">
        <div class="card text-light mx-3 my-2 card-mutasi" style="max-width: 25rem;">
          <div class="card-header">Perubahan Status</div>
            <div class="card-body">
              <i class="fa fa-bar-chart" aria-hidden="true" id="reportlogo"></i>
              <h5 class="card-title">Karyawan</h5>
              <p class="card-text">Mutasi, Demosi, Rotasi</p>
              <% if session("HL5") then %>
              <button class="btn btn-warning btn-sm setMutasi" type="button" aria-expanded="false" onclick="window.location.href='forms/'">
                  <i class="fa fa-ravelry" aria-hidden="true"></i> Detail
                </button>
              <% else %>
                <span style="padding:20px;margin-top:50px;margin-bottom:50px"></span>
              <% end if %>
            </div>
        </div>
      </div>
      <!--perubahan bpjs -->
      <div class='col-lg card-list' data-aos="fade-down" data-aos-easing="linear" data-aos-duration="1100" data-aos-delay="200">
        <div class="card text-light mx-3 my-2 card-bpjs" style="max-width: 25rem;">
          <div class="card-header" >BPJS</div>
            <div class="card-body">
              <i class="fa fa-pencil-square-o" aria-hidden="true" id="reportlogo"></i>
              <h5 class="card-title" >Aktifasi</h5>
              <p class="card-text">Perubahan BPJS</p>
                <% if session("HL4")=true then %>
                  <button class="btn btn-warning btn-sm setbpjs" type="button" aria-expanded="false" onclick="window.location.href='bpjs/'">
                    <i class="fa fa-hourglass-half" aria-hidden="true"></i> Detail
                  </button>
                <% else %>
                  <span style="padding:20px;margin-top:50px;margin-bottom:50px"></span>
                <% end if %>
            </div>
        </div>
      </div>

      <!--perubahan Approve CIS -->
      <div class='col-lg card-list' data-aos="fade-down" data-aos-easing="linear" data-aos-duration="1100" data-aos-delay="200">
        <div class="card text-light mx-3 my-2 card-atasan" style="max-width: 25rem;">
          <div class="card-header">Setting atasan</div>
            <div class="card-body">
              <i class="fa fa-grav" aria-hidden="true" id="reportlogo"></i>
              <h5 class="card-title">Cuti Izin Sakit</h5>
              <p class="card-text">Approve Cuti</p>
                <% if session("HL3")=true then %>
                  <button class="btn btn-warning btn-sm setatasan" type="button" aria-expanded="false" onclick="window.location.href='approve'">
                    <i class="fa fa-hourglass-half" aria-hidden="true"></i> Detail
                  </button>
                <% else %>
                  <span style="padding:20px;margin-top:50px;margin-bottom:50px"></span>
                <% end if %>
            </div>
        </div>
      </div>

    </div>
    <% if session("HL6") = true then %>
    <div class='row'>
      <div class='col'>
        <section class="akun" >
          <a href="gantipassword.asp?username=<%= session("username") %>&serverid=<%= session("server-id") %>"><i class="fa fa-user-circle-o fa-2x" aria-hidden="true"></i></a>
        </section> 
      </div>
    </div>
     <% end if %>
</div>
</section>


<!--footer content -->
<footer class="footer">
        <div class="icons">
            <p class="company-name">
                Copyright &copy; 2022, ALL Rights Reserved PT. DAKOTA BUANA SEMESTA </br>
                Jl. Wibawa Mukti II No.8 Jati Asih, Bekasi, Indonesia<br>
                V.1 Mobile Responsive 2022
            </p>
        </div>
</footer>
<!--end content -->

<!-- Modal -->
<div class="modal fade" id="modaldashboard" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">Convert Gaji Bulanan</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!--content -->
        <form action="<%=url%>/ajax/convertgaji.asp" method="post" id='form-dashboard'>
          <div class="mb-3 row justify-content-md-center">
            <label for="blnConvertgaji" class="col-sm-2 col-form-label">Bulan</label>
            <div class="col-sm-4">
              <input type="number" class="form-control" id="blnConvertgaji" name="blnConvertgaji" onkeyup="return convertgaji()" required>
            </div>
          </div>
          <div class="mb-3 row justify-content-md-center">
            <label for="thnConvertgaji" class="col-sm-2 col-form-label">Tahun</label>
            <div class="col-sm-4">
              <input type="number" class="form-control" id="thnConvertgaji" name="thnConvertgaji" onkeyup="return convertgaji()" required>
            </div>
          </div>
        <!--end content -->
      </div>
      <div class='loaderdasboard'>
        <img src="loader/DLL.GIF" name="dload" id="dload">
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary convert" id="btn-convert" onclick="return yakinconvert()">Convert</button>
        </form>
        <button type="button" class="btn btn-secondary closeconvert" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!--end modal -->

</body>
<script>
  // rubah action gaji 
  let form = document.getElementById('form-dashboard');

  const setGaji = () => {
    if (confirm("Anda Yakin Untuk Menggaji Seluruh Karyawan???") == true){
        document.write("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'><meta http-equiv='X-UA-Compatible' content='IE=edge'><meta name='viewport' content='width=device-width, initial-scale=1.0'><title>Ruang Tunggu</title></head><body><div class='loader' style='width:100%;height:100%;line-height:200px;text-align:center;'><img src='loader/DLL.gif' style='line-height: 3.5;display:inline-block;vertical-align: middle;'></div></body></html>");
        window.location.href = "<%=url%>/gajiAll/"
      }
    }

  function convertgaji(){
    var maxbln = 12;
    var dt = new Date();
    var maxthn = dt.getFullYear();
    var bln = document.getElementById('blnConvertgaji').value;
    var thn = document.getElementById('thnConvertgaji').value;
    // max bulan validasi
    if( parseInt(bln) > maxbln ){
      document.getElementById('blnConvertgaji').value = 12;
    }else{
      document.getElementById('blnConvertgaji').value = bln;
    }
    // max tahun validasi
    if (parseInt(thn) > maxthn ){
      document.getElementById('thnConvertgaji').value = maxthn;
    }else{
      document.getElementById('thnConvertgaji').value = thn;
    }
  }
  function yakinconvert(){
    alert("Data Yang Anda Masukan Sudah Benar??");
    $('#dload').show();
    $('.convert').hide();
    $('.closeconvert').hide();
  }
</script>
<!-- #include file='layout/footer.asp' -->