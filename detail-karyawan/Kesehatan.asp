<!-- #include file='../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim kesehatan, nip

nip = Request.QueryString("nip")

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.ActiveConnection = MM_cargo_STRING

set kesehatan = Server.CreateObject("ADODB.Command")
kesehatan.ActiveConnection = MM_cargo_STRING

kesehatan.commandText = "SELECT * FROM HRD_T_Kesehatan WHERE Kes_Nip = '"& nip &"'"
set kesehatan = kesehatan.execute

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KESEHATAN</title>
    <!-- #include file='../layout/header.asp' -->
    <script>
    const valid = (str) =>{
        let maxbln = 12;
        let d = new Date();
        let maxthn = d.getFullYear();

        let bulan = $('#bulan').val();
        if ( bulan > maxbln){
            $('#bulan').val("12");
        }else{
            bulan = bulan;
        }

        let thn = $('#tahun').val();
        if ( thn > maxthn ){
            $('#tahun').val(maxthn);
        }else{
            thn = thn;
        }
    }
    const tambahKesehatan = () => {
        $('#nomor').val("");
        $('#nsakit select').val("Pilih");
        $('#bulan').val("");
        $('#tahun').val("");
        $('#lama').val("");

        $('#LabelKesehatan').html('TAMBAH KESEHATAN');
        $('#submit').html('Save');
        $('.modal-body form').attr('action', 'kesehatan/tambah.asp');

    }
    const ubahKesehatan = (nip, id) => {
        $.ajax({
        url: 'kesehatan/update.asp',
        data: { nip: nip, id : id },
        method: 'post',
        success: function (data) {
            function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                $('#nomor').val(arry[0]);
                $('#nsakit option[value='+ arry[2] +']').attr('selected','selected');
                $('#bulan').val(arry[3]);
                $('#tahun').val(arry[4]);
                $('#lama').val(arry[5]);
            }
            const koma = ",";
            splitString(data, koma);
        }
        });
        $('#LabelKesehatan').html('UPDATE KESEHATAN');
        $('#submit').html('Update');
        $('.modal-body form').attr('action', 'kesehatan/update_add.asp');

    }
    </script>
</head>

<body>
<!-- #include file='../landing.asp' -->
<div class="container">
 <!--#include file="template-detail.asp"-->
       <!-- header start -->
    <div class="row mt-2 mb-2 contentDetail">
        <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class="col-sm-2">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
            </div>
            <% 
            karyawan.commandText = "SELECT Kry_nama FROM HRD_M_Karyawan WHERE Kry_Nip='"& nip &"'"
            set krywn = karyawan.execute
             %>
         <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
            <div class="col-sm-7">
                <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%= krywn("Kry_Nama") %> " disabled>
            </div>
        <div class='row mt-3'>
            <div class='col'>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#tambah-kesehatan" onclick="return tambahKesehatan()">
                    Tambah
                </button>
            </div>
        </div>
    </div>
    <div class="row contentDetail">
        <div class="col content-table">
            <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Bulan</th>
                        <th scope="col">Tahun</th>
                        <th scope="col">Nama Penyakit</th>
                        <th scope="col">Lama</th>
                        <th scope="col">Satuan</th>
                        <th scope="col" class="text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    nomor = 0
                    do until kesehatan.eof 
                    if kesehatan("Kes_ID") = "" then
                        nomor = 0
                    else 
                        nomor = kesehatan("Kes_ID")
                    end if


                    karyawan.commandText = "SELECT Peny_nama FROM HRD_M_Penyakit WHERE Peny_ID = '"& kesehatan("Kes_PenyID") &"'"
                    set penyakit = karyawan.execute
                    %>
                    <tr>
                        <td><%=nomor%></td>
                        <td><%=kesehatan("Kes_Bulan")%></td>
                        <td><%=kesehatan("Kes_Tahun")%></td>
                        <td><%=penyakit("Peny_nama")%></td>
                        <td><%=kesehatan("Kes_Lama")%></td>
                        <td><%=kesehatan("Kes_Satuan")%></td>
                        <td class="text-center">
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary btn-sm py-0 px-2" data-bs-toggle="modal" data-bs-target="#tambah-kesehatan" onclick="return ubahKesehatan('<%=kesehatan("Kes_Nip")%>','<%=nomor%>')">
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return hapus()">
                                   Hapus
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% 
                    kesehatan.movenext
                    loop
                     %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="tambah-kesehatan" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="LabelKesehatan">TAMBAH KESEHATAN</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="kesehatan_add.asp" method="post">
        <input type='hidden' name='nip' id='nip' value="<%=nip%>">
            <div class="mb-3 row">
                <label for="nomor" class="col-sm-4 col-form-label">Nomor</label>
                <div class="col-sm-8">
                <input type="text" class="form-control" id="nomor" name="nomor" readonly>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="namap" class="col-sm-4 col-form-label">Nama Penyakit</label>
                <div class="col-sm-8">
                    <select class="form-select form-select-md" aria-label=".form-select-md example" name="nsakit" id="nsakit" required>
                        <option value="">Pilih</option>
                        <% 
                        karyawan.commandText = "SELECT Peny_nama, Peny_ID FROM HRD_M_Penyakit"
                        set sakit = karyawan.execute

                        do until sakit.eof
                         %>
                        <option value="<%=sakit("Peny_ID")%>"><%=sakit("Peny_nama")%></option>
                        <% 
                        sakit.movenext
                        loop
                         %>
                    </select>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="bulan" class="col-sm-4 col-form-label">Bulan</label>
                <div class="col-sm-2">
                <input type="text" class="form-control" id="bulan" name="bulan" onkeyup="return valid(this.value)" required>
                </div>
                <label for="tahun" class="col-sm-2 col-form-label">Tahun</label>
                <div class="col-sm-4">
                <input type="text" class="form-control" id="tahun" name="tahun" onkeyup="return valid(this.value)" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="lama" class="col-sm-4 col-form-label">Lama</label>
                <div class="col-sm-2">
                <input type="number" class="form-control" id="lama" name="lama" onkeyup="return valid(this.value)" required>
                </div>
                <div class="col-sm-4">
                <label class="col-sm-4 col-form-label">Hari</label> 
                </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="submit" name="submit" id="submit" class="btn btn-primary">Save</button>
        </form>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
    const hapus = () =>{
        if (confirm("Yakin Untuk Di hapus") == true){
            return window.location='kesehatan/delete.asp?nip=<%=nip%>&id=<%=nomor%>'
        }else{
            return false;
        }
    }
</script>
<!-- #include file='../layout/footer.asp' -->