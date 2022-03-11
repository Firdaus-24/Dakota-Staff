<!-- #include file='../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim nip
dim pekerjaan_cmd, pekerjaan

nip = Request.QueryString("nip")

 set pekerjaan_cmd = Server.CreateObject("ADODB.Command")
 pekerjaan_cmd.activeConnection = MM_Cargo_String

 pekerjaan_cmd.commandText = "SELECT HRD_T_HistKerja.*, HRD_M_JnsUsaha.Ush_Nama, HRD_M_JabatanOuter.Jbt_Nama FROM HRD_T_HistKerja LEFT OUTER JOIN HRD_M_JnsUsaha ON HRD_T_HistKerja.HK_UshID = HRD_M_JnsUsaha.Ush_ID LEFT OUTER JOIN HRD_M_JabatanOuter ON HRD_T_HistKerja.HK_JbtID = HRD_M_JabatanOuter.Jbt_ID WHERE HK_Nip = '"& nip &"'"
 set pekerjaan = pekerjaan_cmd.execute

 pekerjaan_cmd.commandText = "SELECT Kry_Nama FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
 set karyawan = pekerjaan_cmd.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pekerjaan</title>
    <!-- #include file='../layout/header.asp' -->
    <script>
    const validasiPekerjaan = () => {
      let namaPt = document.forms["form-pekerjaan"]["namaPT1"].value;
      let thna1 = document.forms["form-pekerjaan"]["thna1"].value;
      let thna2 = document.forms["form-pekerjaan"]["thna2"].value;
      let akeluar1 = document.forms["form-pekerjaan"]["akeluar1"].value;
      let referensi1 = document.forms["form-pekerjaan"]["referensi1"].value;

      if ( namaPt.length > 20 ){
        alert("Maximal Nama PT 20 karakter!!!");
        return false;
      }else if ( thna1.length > 4 ){
        alert("Maximal Tahun 4 karakter!!!!!");
        return false;
      }else if ( thna2.length > 4 ){
        alert("Maximal Tahun 4 karakter!!!!!");
        return false;
      }else if ( referensi1.length > 20 ){
        alert("Maximal referensi 20 karakter!!!!!");
        return false;
      }else if ( akeluar1.length > 30 ){
        alert("Maximal Alasan Keluar 50 karakter!!!");
        return false;
      }
      return true;
    }
    const tambahPekerjaan = () => {
       
        $('#modalLabelPekerjaan').html('TAMBAH PEKERJAAN');
        $('#submit_Pekerjaan').html('Save');
        $('.modal-body form').attr('action', 'pekerjaan/tambah.asp');

        $('#namaPT1').val("");
        $('#jusaha1').val("");
        $('#jabatan1').val("");
        $('#blna1').val("");
        $('#thna1').val("");
        $('#blna2').val("");
        $('#thna2').val("");
        $('#referensi1').val("");
        $('#akeluar1').val("");

    }

    const updatePekerjaan = (id, nama) => {
        $.ajax({
        url: 'pekerjaan/update.asp',
        data: { id : id, nama:nama },
        method: 'post',
        success: function (data) {
            function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                $('#nip').val(arry[0]);
                $('#namaPT').val(arry[1]);
                $('#namaPT1').val(arry[1]);
                $('#jusaha').val(arry[2]);
                $('#jusaha1 option[value=' + arry[2] + ']').prop("selected", true);
                $('#jabatan').val(arry[3]);
                $('#jabatan1 option[value=' + arry[3] + ']').prop("selected", true);
                $('#bln1').val(arry[4]);
                $('#blna1 option[value=' + arry[4] + ']').prop("selected", true);
                $('#thn1').val(arry[5]);
                $('#thna1').val(arry[5]);
                $('#bln2').val(arry[6]);
                $('#blna2 option[value=' + arry[6] + ']').prop("selected", true);
                $('#thn2').val(arry[7]);
                $('#thna2').val(arry[7]);
                $('#referensi').val(arry[8]);
                $('#referensi1').val(arry[8]);
                $('#akeluar').val(arry[9]);
                $('#akeluar1').val(arry[9]);
            

            }
            const koma = ",";
            splitString(data, koma);
        }
        });
        $('#modalLabelPekerjaan').html('UPDATE PEKERJAAN');
        $('#submit_Pekerjaan').html('Update');
        $('.modal-body form').attr('action', 'pekerjaan/update_add.asp');
    }
    const hapusPekerjaan = (id,nama) => {
        if (confirm("Yakin Untuk Di Ubah??") == true ){
            window.location.href = 'pekerjaan/delete.asp?id='+ id + '&nama=' + nama
        }
    }
    </script>
</head>
<!-- #include file='../landing.asp' -->
<!-- #include file='template-detail.asp' -->
<div class='container'>
    <div class="row mb-2 mt-2 contentDetail">
      <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
        <div class="col-sm-2">
          <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
        </div>
      <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
        <div class="col-sm-7">
          <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%=karyawan("Kry_Nama") %> " disabled>
        </div>
      <div class='row mt-3'>
        <div class='col'>
          <button type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#modalPekerjaan" onclick="return tambahPekerjaan()">
            Tambah
          </button>
        </div>
      </div>
    </div>
    <div class='row contentDetail'>
        <div class='col content-table'>
             <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">Nama PT</th>
                        <th scope="col">Usaha</th>
                        <th scope="col">Jabatan</th>
                        <th scope="col">Bulan 1</th>
                        <th scope="col">Tahun 1</th>
                        <th scope="col">Bulan 2</th>
                        <th scope="col">Tahun 2</th>
                        <th scope="col">Referensi</th>
                        <th scope="col">Alasan Keluar</th>
                        <th scope="col text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                <% do until pekerjaan.eof %>
                  <tr>
                    <td>
                            <%= pekerjaan("HK_NamaPT") %>
                        </td>
                        <td>
                            <%= pekerjaan("Ush_Nama") %>
                        </td>
                        <td>
                            <%= pekerjaan("Jbt_Nama") %>
                        </td>
                        <td>
                            <%= pekerjaan("HK_Bulan1") %>
                        </td>
                        <td>
                            <%= pekerjaan("HK_tahun1") %>
                        </td>
                        <td>
                            <%= pekerjaan("HK_Bulan2") %>
                        </td>
                        <td>
                            <%= pekerjaan("HK_tahun2") %>
                        </td>
                        <td>
                            <%= pekerjaan("HK_referensi") %>
                        </td>
                        <td>
                            <%= pekerjaan("HK_alasanKeluar") %>
                        </td>
                        
                    <td>
                      <div class='btn btn-group'>
                        <button type="button" class="btn btn-primary btn-sm btn-sm py-0 px-2 " data-bs-toggle="modal" data-bs-target="#modalPekerjaan" onclick="return updatePekerjaan('<%= pekerjaan("HK_Nip") %>', '<%= pekerjaan("HK_NamaPT") %>')">
                          Update
                        </button>
                        <button type="button" class="btn btn-danger btn-sm btn-sm py-0 px-2 " onclick="return hapusPekerjaan('<%= pekerjaan("HK_Nip") %>', '<%= pekerjaan("HK_NamaPT") %>')">
                          Hapus
                        </button>
                      </div>
                    </td>
                  </tr>
                <% 
                pekerjaan.movenext
                loop
                 %>
                <tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalPekerjaan" tabindex="-1" aria-labelledby="modalPekerjaan" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabelPekerjaan">TAMBAH PEKERJAAN</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="pekerjaan/tambah.asp" method="post" id="form-pekerjaan" onsubmit="return validasiPekerjaan()">
            <input type='hidden' name='nip' id='nip' value="<%=nip%>">
            <input type='hidden' name='namaPT' id='namaPT' value="">
            <input type='hidden' name='jusaha' id='jusaha' value="">
            <input type='hidden' name='jabatan' id='jabatan' value="">
            <input type='hidden' name='bln1' id='bln1' value="">
            <input type='hidden' name='thn1' id='thn1' value="">
            <input type='hidden' name='bln2' id='bln2' value="">
            <input type='hidden' name='thn2' id='thn2' value="">
            <input type='hidden' name='referensi' id='referensi' value="">
            <input type='hidden' name='akeluar' id='akeluar' value="">
            <div class="mb-3 row">
                <label for="namaPT1" class="col-sm-3 col-form-label">Nama PT</label>
                <div class="col-sm-7 ">
                  <input type="text" class="form-control" id="namaPT1" name="namaPT1" required>
                </div>
            </div>
            <div class="row g-3 align-items-center mb-3">
                <div class="col-3">
                    <label for="jusaha1" class="col-form-label">Jenis Usaha</label>
                </div>
                <% 
                pekerjaan_cmd.commandText = "SELECT Ush_ID, Ush_Nama FROM HRD_M_JnsUsaha WHERE Ush_AktifYN = 'Y'"
                set usaha = pekerjaan_cmd.execute
                 %>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="jusaha1" id="jusaha1">
                      <option value="">Pilih</option>
                      <% do until usaha.eof %>
                      <option value="<%= usaha("Ush_ID") %>"><%= usaha("Ush_Nama") %></option>
                      <% 
                      usaha.movenext
                      loop
                       %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center">
                <div class="col-3">
                    <label for="jabatan1" class="col-form-label">Jabatan</label>
                </div>
                <% 
                pekerjaan_cmd.commandText = "SELECT Jbt_ID, Jbt_Nama FROM HRD_M_JabatanOuter WHERE Jbt_AktifYN = 'Y'"
                set jabatan = pekerjaan_cmd.execute
                 %>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="jabatan1" id="jabatan1">
                      <option value="">Pilih</option>
                      <% do until jabatan.eof %>
                      <option value="<%= jabatan("Jbt_ID") %>"><%= jabatan("Jbt_Nama") %></option>
                      <% 
                      jabatan.movenext
                      loop
                       %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="blna1" class="col-form-label">Masa Kerja</label>
                </div>
                <div class="col-5">
                    <select class="form-select" aria-label="Default select example" name="blna1" id="blna1">
                      <option value="">Pilih</option>
                      <option value="1">Januari</option>
                      <option value="2">Febuari</option>
                      <option value="3">Maret</option>
                      <option value="4">April</option>
                      <option value="5">Mei</option>
                      <option value="6">Juni</option>
                      <option value="7">Juli</option>
                      <option value="8">Agustus</option>
                      <option value="9">September</option>
                      <option value="10">Aktober</option>
                      <option value="11">November</option>
                      <option value="12">Desember</option>
                    </select>
                </div>
                <div class="col-4">
                  <input type="number" class="form-control" id="thna1" name="thna1">
                </div>
            </div>
            <div class="row g-3 align-items-center ">
                <div class="col-3">
                    <label for="blna2" class="col-form-label">Sampai Dengan</label>
                </div>
                <div class="col-5">
                    <select class="form-select" aria-label="Default select example" name="blna2" id="blna2">
                      <option value="">Pilih</option>
                      <option value="1">Januari</option>
                      <option value="2">Febuari</option>
                      <option value="3">Maret</option>
                      <option value="4">April</option>
                      <option value="5">Mei</option>
                      <option value="6">Juni</option>
                      <option value="7">Juli</option>
                      <option value="8">Agustus</option>
                      <option value="9">September</option>
                      <option value="10">Aktober</option>
                      <option value="11">November</option>
                      <option value="12">Desember</option>
                    </select>
                </div>
                <div class="col-4">
                  <input type="number" class="form-control" id="thna2" name="thna2">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="referensi1" class="col-sm-3 col-form-label">Referensi</label>
                <div class="col-sm-7 ">
                  <input type="text" class="form-control" id="referensi1" name="referensi1">
                </div>
            </div>
            <div class="mb-3">
                <label for="akeluar1" class="form-label">Alasan Keluar</label>
                <textarea class="form-control" id="akeluar1" name="akeluar1" rows="3"></textarea>
            </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" name="submit_pekerjaan" id="submit_Pekerjaan">Save</button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- #include file='../layout/footer.asp' -->

