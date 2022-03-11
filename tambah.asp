<!-- #include file="connection.asp"-->
<!--#include file="landing.asp"-->
<% 
' koneksi ke divisi
set divisi_cmd = Server.CreateObject("ADODB.Command")
divisi_cmd.ActiveConnection = MM_cargo_STRING


' koneksi area
set area_cmd = Server.CreateObject("ADODB.Command")
area_cmd.ActiveConnection = MM_cargo_STRING

' koneksi ke db jabatan
set jabatan_cmd = Server.CreateObject("ADODB.Command")
jabatan_cmd.ActiveConnection = MM_cargo_STRING

' koneksi grup shift
set gs_cmd = Server.CreateObject("ADODB.Command")
gs_cmd.ActiveConnection = MM_cargo_STRING

'jenjang
set jenjang_cmd = Server.CreateObject("ADODB.Command")
jenjang_cmd.ActiveConnection = MM_cargo_STRING

'agama
set agama_cmd = Server.CreateObject("ADODB.Command")
agama_cmd.ActiveConnection = MM_cargo_STRING

'pendidikan
Set pendidikan_cmd = Server.CreateObject ("ADODB.Command")
pendidikan_cmd.ActiveConnection = MM_cargo_STRING

'class intisiasi

 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Karyawan</title>
    <!--#include file="layout/header.asp"-->
    <style> 
    .container .display-1
    {
        font-size: 50px;
        font-weight: 500;
        display: block;
       
    }
    .container .row .box-panel
    {
        width:100%;
        height:auto;
        background-color:linear-gradient(to right, #000046, #1cb5e0);
        position:relative;
    }
    </style>
    <script>
    function validasitambahkaryawan() {
        // validasi
        // cari data
        var nama = document.forms["formKaryawan"]["nama"].value;
        var alamat = document.forms["formKaryawan"]["alamat"].value;
        var kelurahan = document.forms["formKaryawan"]["kelurahan"].value;
        var email = document.forms["formKaryawan"]["email"].value;
        var tlp1 = document.forms["formKaryawan"]["tlp1"].value;
        var tlp2 = document.forms["formKaryawan"]["tlp2"].value;
        var kota = document.forms["formKaryawan"]["kota"].value;
        var Pos = document.forms["formKaryawan"]["pos"].value;
        var tmpt = document.forms["formKaryawan"]["tempat"].value;
        var norek = document.forms["formKaryawan"]["norek"].value;
        var tenagakerja = document.forms["formKaryawan"]["tenagakerja"].value;
        var ktp = document.forms["formKaryawan"]["ktp"].value;
        var npwp = document.forms["formKaryawan"]["npwp"].value;
        var nsim = document.forms["formKaryawan"]["nsim"].value;
        var kesehatan = document.forms["formKaryawan"]["kesehatan"].value;
    // kodisikan
    if (nama.length > 30) {
        alert("Nama MAXIMAL karakter 30");
        return false;
    } else if (alamat.length > 50) {
        alert("Alamat MAXIMAL alamat 50 karakter");
        return false;
    } else if (kelurahan.length > 50) {
        alert("Kelurahan MAXIMAL 50 karakter");
        return false;
    } else if (email.length > 30) {
        alert("Email MAXIMAL 30 karakter");
        return false;
    } else if (tlp1.length > 15) {
        alert("Telphone MAXIMAL 15 karakter");
        return false;
    } else if (tlp2.length > 15) {
        alert("Telphone MAXIMAL 15 karakter");
        return false;
    } else if (kota.length > 30) {
        alert("Kota MAXIMAL kota 30 karakter");
        return false;
    } else if (Pos.length > 5) {
        alert("Pos MAXIMAL kode Pos 5 karakter");
        return false;
    } else if (tmpt.length > 30) {
        alert("Tempat lahir MAXIMAL pos 30 karakter");
        return false;
    } else if (norek.length > 20) {
        alert("No.Rekening MAXIMAL pos 20 karakter");
        return false;
    } else if (tenagakerja.length > 20) {
        alert("Data BPJS tenaga kerja harus angka kk dan maximal datapun cuma 20 karakter");
        return false;
    } else if (ktp.length > 30) {
        alert("Data nomor KTP harus angka kk dan maximal datapun cuma 30 karakter");
        return false;
    } else if (npwp.length > 30) {
        alert("Data harus angka kk dan maximal datapun cuma 30 karakter");
        return false;
    } else if (nsim.length > 30) {
        alert("maximal nomor sim 30 karakter");
        return false;
    } else if (kesehatan.length > 20) {
        alert("MAXIMAL 20 karakter ya!!");
        return false;
    }

}
    </script>
</head>
<body>
<br/>

<!--judul-->
<section class="content-detail" name="content-detail" id="content-detail">
		<h3 class="text-center">TAMBAH DATA KARYAWAN</h3>
    <div class="container mt-2 mb-3 px-4 bg-light data-detail" style="border-radius:5px;">
        <div class="row gx-5">
		 <!-- start form -->
		<form action="tambah_kar.asp" method="post" name="formKaryawan" id="formKaryawan" onsubmit="return validasitambahkaryawan()">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-sm-6 mt-2">
                         <!-- nip hidden -->
                        <label>Nip</label>
                            <input type="text" name="nip" class="form-control" id="nip" readonly>
                        <label>Nama</label>
                            <input type="text" name="nama" class="form-control" id="nama" autocomplete="off" required>
                        <label>Alamat</label>
                            <input type="text" name="alamat"  class="form-control" id="alamat" autocomplete="off" required>
                        <label>Kelurahan</label>
                            <input type="text" name="kelurahan"  class="form-control" id="kelurahan" autocomplete="off" required>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-check form-check-inline">
                        <label class="mt-2 mb-1 d-flex flex-row">BPJS KES</label>
                            <div class="form-check form-check-inline">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="bpjsY" name="bpjskes" value="Y">
                                    <label class="form-check-label" for="bpjsY">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="bpjsN" name="bpjskes" value="N">
                                    <label class="form-check-label" for="bpjsN">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-check form-check-inline">
                        <label class="mt-2 mb-1 d-flex flex-row">BPJS KET</label>
                            <div class="form-check form-check-inline">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="bpjsKetY" name="bpjs" value="Y">
                                    <label class="form-check-label" for="bpjsKetY">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="bpjsKetN" name="bpjs" value="N">
                                    <label class="form-check-label" for="bpjsKetN">No</label>
                                </div>
                            </div>
                        </div>
                        <br/>
                        <label>Telphone 1</label>
                            <input type="number" class="form-control" name="tlp1" id="tlp1" required>
                        <label>Telphone 2</label>
                            <input type="number" class="form-control" name="tlp2" id="tlp2">
                        <div class="row">
                            <div class="col-6">
                                <label>Kota</label>
                                    <input type="text" name="kota" class="form-control" id="kota" required>
                            </div>
                            <div class="col-6">
                                <label>Pos</label>
                                    <input type="text" class="form-control" name="pos" id="pos" required>
                            </div>
                        </div>
                    </div>
                </div>
            </div>        
        </div> 
        <div class="row">
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-8">
                        <label>Tempat Lahir</label>
                            <input type="text" name="tempat" class="form-control" id="tempat" required>
                    </div>
                    <div class="col-md-4">
                        <label>Tanggal Lahir</label>
                            <input type="date" name="tglL" class="form-control" id="tglL" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <label>Email</label>
                            <input type="text" name="email" class="form-control" id="email" required>
                    </div>
                    <div class="col-md-4">
                        <label>Agama</label>
                            <% 
                            agama_cmd.commandText = "SELECT Agama_ID, Agama_Nama FROM GLB_M_Agama WHERE Agama_aktifYN = 'Y'"
                            set agama = agama_cmd.execute

                            %> 
                            <select class="form-select" aria-label="Default select example" name="agama" id="agama" required>
                                <option value="">pilih</option>
                                <% do until agama.eof %> 
                                <option value="<%= agama("Agama_Id") %> "><%= agama("Agama_Nama") %> </option>
                                <% agama.movenext 
                                loop%> 
                            </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <label>Jenis Kelamin</label>
                           <select class="form-select" aria-label="Default select example" name="jkelamin" id="jkelammin" required>
                                <option value="">pilih</option>
                                <option value="P">Laki-Laki</option>
                                <option value="W">Wanita</option>
                            </select>
                    </div>
                    <div class="col-md-4">
                        <label>Status Sosial</label>
                            <select class="form-select" aria-label="Default select example" name="ssosial" id="ssosial" required>
                                <option value="">pilih</option>
                                <option value="0">Belum Menikah</option>
                                <option value="1">Menikah</option>
                                <option value="2">Janda / Duda</option>
                            </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>Jumlah Anak</label>
                        <input type="number" name="janak" class="form-control" id="janak" value="0" required>
                    </div>
                    <div class="col-md-6">
                        <label>Tanggungan</label>
                        <input type="number" name="tanggungan" class="form-control" id="tanggungan" value="0" required>
                    </div>
                </div>  
                 <div class="row">
                    <div class="col-md-6">
                        <% 
                        pendidikan_cmd.commandText = "SELECT JDdk_Nama, JDdk_ID FROM HRD_M_JenjangDidik"
                        set pendidikan = pendidikan_cmd.execute
                        %> 
                        <label>Pendidikan</label>
                        <select class="form-select" aria-label="Default select example" name="pendidikan" id="pendidikan" required>
                            <option value="">pilih</option>
                            <% do until pendidikan.eof %> 
                            <option value="<%= pendidikan("JDdk_ID") %>"><%= pendidikan("JDdk_Nama") %> </option>
                            <% pendidikan.movenext
                            loop %> 
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label>Status Pegawai</label>
                            <select class="form-select" aria-label="Default select example" name="spegawai" id="spegawai" required>
                                <option value="">pilih</option>
                                <option value="0">Borongan</option>
                                <option value="1">Harian</option>
                                <option value="2">Kontrak</option>
                                <option value="3">Magang</option>
                                <option value="4">Tetap</option>
                            </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>Saudara</label>
                            <input type="number" name="saudara" class="form-control" id="saudara" value="0" required>
                    </div>
                    <div class="col-md-6">
                        <label>Anak Ke-</label>
                            <input type="number" name="anakke" class="form-control" id="anakke" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                    <% 
                    pendidikan_cmd.commandText = "SELECT Bank_ID, Bank_Name FROM GL_M_Bank WHERE Bank_AktifYN = 'Y' ORDER BY Bank_Name ASC"
                    set bank = pendidikan_cmd.execute
                     %>
                        <label>Bank Id</label>
                            <select class="form-select" aria-label="Default select example" name="bankID" id="bankID" required>
                                <option value="">pilih</option>
                                <% do until bank.eof %>
                                    <option value="<%= bank("Bank_ID") %>"><%= bank("Bank_Name") %></option>
                                <% 
                                bank.movenext
                                loop
                                 %>
                            </select>
                    </div>
                    <div class="col">
                        <label>No Rekening</label>
                            <input type="number" name="norek" class="form-control" id="norek" required>
                    </div>
                </div>            
                <div class="row">
                    <div class="col">
                        <label>BPJS Kesehatan</label>
                            <input type="number" name="kesehatan" class="form-control" id="kesehatan">
                    </div>
                    <div class="col">
                        <label>Ketenagakerjaan</label>
                            <input type="number" name="tenagakerja" class="form-control" id="tenagakerja">
                    </div>
                </div>            
            </div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-6">
                        <label>Atasan 1</label>
                            <input type="number" name="atasan1" class="form-control" id="atasan1" max placeholder="nip atasan" maxlength="10" autocomplete="off">
                    </div>
                    <div class="col-6">
                        <label>Atasan 2</label>
                            <input type="number" class="form-control" name="atasan2" id="atasan2" placeholder="nip atasan" maxlength="10" autocomplete="off">
                    </div>
                </div>
                    <%
                    area_cmd.commandText = "select agen_ID, agen_nama from glb_m_agen WHERE Agen_AktifYN = 'Y' AND Agen_Nama NOT LIKE '%XXX%' ORDER BY Agen_Nama ASC"
                    set area = area_cmd.execute
                    %>
                    <label>Pegawai</label>
                    <select class="form-select" aria-label="Default select example" name="pegawai"  id="pegawai" required>
                        <option value="">Pilih</option>
                        <% do until area.EOF %> 
                            <option value="<%= area("agen_ID") %> "><%= area("agen_nama") %> </option>
                        <% 
                        area.movenext 
                        loop
                        area.movefirst
                        %> 
                    </select>
                    <label>Sub Cabang</label>
                
                    <select class="form-select" aria-label="Default select example" name="areaAktif"  id="areaAktif" required>
                        <option value="">Pilih</option>
                        <% do until area.EOF %> 
                            <option value="<%= area("agen_ID") %> "><%= area("agen_nama") %> </option>
                        <% area.movenext 
                        loop%> 
                    </select>
                   
                    <% 
                    jabatan_cmd.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan WHERE Jab_AktifYN = 'Y' ORDER BY Jab_Nama ASC"
                    set jabatan = jabatan_cmd.execute
                    
                    %>  
                    <label>Jabatan</label>
                        <select class="form-select" aria-label="Default select example" name="jabatan" id="jabatan" required>
                            <option value="">Pilih</option>
                            <% do until jabatan.eof %> 
                            <option value="<%= jabatan("Jab_Code") %> "><%= jabatan("Jab_Nama") %></option>
                            <% jabatan.movenext 
                            loop%> 
                        </select>
                    <label>Jenjang</label>
                        <% 
                            jenjang_cmd.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE JJ_AktifYN = 'Y' ORDER BY JJ_Nama ASC"
                            set jenjang = jenjang_cmd.execute
                        %> 
                        <select class="form-select" aria-label="Default select example" name="jenjang" id="jenjang" required>
                            <option value="">Pilih</option>
                            <% do until jenjang.EOF %> 
                            <option value="<%= jenjang("JJ_ID") %> "><%= jenjang("JJ_Nama") %> </option>
                            <% jenjang.movenext 
                            loop%> 
                        </select>
                    <label>Divisi</label>
                    <% 
                            divisi_cmd.commandText = "select Div_Code, Div_Nama from HRD_M_Divisi WHERE Div_AktifYN = 'Y' ORDER BY Div_Nama ASC"
                            set divisi = divisi_cmd.execute
                        %> 
                        <select class="form-select" aria-label="Default select example" name="divisi" id="divisi" required> 
                            <option value="">Pilih</option>
                            <% do until divisi.EOF %> 
                            <option value="<%= divisi("Div_Code") %> "><%= divisi("Div_Nama") %> </option>
                            <% divisi.movenext 
                            loop%> 
                        </select>
                    
                <div class="row">
                    <div class="col">
                        <label>Jumlah Cuti</label>
                            <input type="number" name="jcuti" class="form-control" id="jcuti" value="0">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>No KTP</label>
                            <input type="number" name="ktp" class="form-control" id="ktp" required>
                    </div>
                    <div class="col">
                        <label>NPWP</label>
                            <input type="text" name="npwp" class="form-control" id="npwp">
                    </div>
                </div>
            </div>
        </div>    
        <div class="row">
            <div class="col-lg-4">
                <div class="row">
                    <div class="col-6">
                        <label>Tanggal Masuk</label>
                            <input type="date" name="tglmasuk" class="form-control" id="tglmasuk" required>
                    </div>
                    <div class="col-6">
                        <label>Tanggal Keluar</label>
                            <input type="date" name="tglkeluar" class="form-control" id="tglkeluar">
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <label>Tanggal StartGaji</label>
                            <input type="date" name="tglagaji" class="form-control" id="tglagaji">
                    </div>
                    <div class="col-6">
                        <label>Tanggal EndGaji</label>
                            <input type="date" name="tglegaji" class="form-control" id="tglegaji">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="row">
                    <div class="col">
                        <label>Jenis SIM</label>
                        <select class="form-select" aria-label="Default select example" name="jsim" id="jsim">
                            <option value="">pilih</option>
                            <option value="0">A</option>
                            <option value="1">B1</option>
							<option value="2">B1 UMUM</option>
                            <option value="3">A UMUM</option>
							<option value="4">B2 UMUM</option>
							<option value="5">C</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <label>Berlaku SIM</label>
                            <input type="date" name="berlakuSIM" class="form-control" id="berlakuSIM">
                    </div>
                    <div class="col">
                        <label>No SIM</label>
                            <input type="number" name="nsim" class="form-control" id="nsim">
                    </div>
                </div>
            </div>
            
        </div>  
        <div class="row mt-3 p-2 ">  
            <div class="col-lg-3 mt-3 " >
                <button type="submit" name="submit" id="submit" value="Submit" class="btn btn-primary submit" onclick="retrun confirm('Data yang anda masukan sudah benar??')" >Tambah</button>
		</form>
		 <!-- end form -->
                <button type="button" onclick="window.location.href='index.asp'" class="btn btn-danger kembali">Kembali</button>
            </div>
        </div>
    <div>
</section>
    <!--content-->
</body>
<script src="js/jquery-3.5.1.min.js"></script> 
<script src="js/bootstrap.min.js"></script>
<script src="js/sweetalert2.all.min.js"></script>
<script src="js/script.js"></script>
</html>