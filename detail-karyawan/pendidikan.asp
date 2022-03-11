<!-- #include file='../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim pendidikan, nip

nip = Request.QueryString("nip")
' Response.Write nip
set jurusan = Server.CreateObject("ADODB.COmmand")
jurusan.activeConnection = MM_Cargo_String

set pendidikan = Server.CreateObject("ADODB.COmmand")
pendidikan.activeConnection = MM_Cargo_String

pendidikan.commandText = "SELECT * FROM HRD_T_Didik1 WHERE Ddk1_NIP = '"& nip &"'"
set pendidikan = pendidikan.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PENDIDIKAN</title>
    <!-- #include file='../layout/header.asp' -->
    <script>
    const validPendidikan = () => {
        let bln1 = $('#blnS').val();
        let bln2 = $('#blnE').val();
        let thn1 = $('#thnS').val();
        let thn2 = $('#thnE').val();
        let maxBulan = 12;
        let d = new Date();
        let maxTahun = d.getFullYear();
        
        if ( bln1 > maxBulan ) {
            $('#blnS').val(maxBulan);
        }else{
            $('#blnS').val(bln1) ;
        }

        if ( thn1 > maxTahun ) {
            $('#thnS').val(maxTahun);
        }else{
            $('#thnS').val(thn1);
        }

        if ( bln2 > maxBulan ){
            $('#blnE').val(maxBulan);
        }else{
            $('#blnE').val(bln2)
        }
        
        if ( thn2 > maxTahun ){
            $('#thnE').val(maxTahun);
        }else{
            $('#thnE').val(thn2);
        }
    }

    const tambahPendidikan = () => {
        $('#jenjang select').val("");
        $('#nama').val("");
        $('#jurusan select').val("");
        $('#kota').val("");
        $('#blnS').val("");
        $('#blnE').val("");
        $('#thnS').val("");
        $('#thnE').val("");
        $('#tamat select').val("");

        // old data
        $('#namae').val("");
        $('#jurusane').val("");
        $('#kotae').val("");
        $('#blnSe').val("");
        $('#thnSe').val("");
        $('#blnEe').val("");
        $('#thnEe').val("");
        $('#tamate').val("");

        $('#labelModalPendidikan').html('TAMBAH PENDIDIKAN');
        $('#submit').html('Save');
        $('.modal-body form').attr('action', 'pendidikan/tambah.asp');
    }

    const editPendidikan = (nip, nama, tahun) => {
        $.ajax({
        url: 'pendidikan/update.asp',
        data: { nip: nip, nama : nama, tahun : tahun },
        method: 'post',
        success: function (data) {
            // console.log(data);
            function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                $('#nip').val(arry[0]);

                $('#jenjange').val(arry[1]);
                $('#namae').val(arry[2]);
                $('#jurusane').val(arry[3]);
                $('#kotae').val(arry[4]);
                $('#blnSe').val(arry[5]);
                $('#thnSe').val(arry[6]);
                $('#blnEe').val(arry[7]);
                $('#thnEe').val(arry[8]);
                $('#tamate').val(arry[9]);

                $('#jenjang option[value='+ arry[1] +']').attr('selected','selected');
                $('#nama').val(arry[2]);
                $('#jurusan option[value='+ arry[3] +']').attr('selected','selected');
                $('#kota').val(arry[4]);
                $('#blnS').val(arry[5]);
                $('#thnS').val(arry[6]);
                $('#blnE').val(arry[7]);
                $('#thnE').val(arry[8]);
                $('#tamat option[value='+ arry[9] +']').attr('selected','selected');
            }
            const koma = ",";
            splitString(data, koma);
        }
        });
        $('#labelModalPendidikan').html('UPDATE PENDIDIKAN');
        $('#submit').html('Update');
        $('.modal-body form').attr('action', 'pendidikan/update_add.asp');

    }
    </script>
</head>
<!-- #include file='../landing.asp' -->
<!-- #include file='template-detail.asp' -->
<div class='container'>
    <div class='row mt-2 contentDetail'>
        <div class='col content-table'>
            <table class="table table-striped tableDetail">
                <thead>
                    <th>Jenjang</th>
                    <th>Nama</th>
                    <th>Jurusan</th>
                    <th>Kota</th>
                    <th>Bulan Awal</th>
                    <th>Tahun Awal</th>
                    <th>Bulan Akhir</th>
                    <th>Tahun Akhir</th>
                    <th>Tamat</th>
                    <th class="text-center">Aksi</th>
                </thead>
                <tbody>
                <% 
                pddk = ""
                tamat = ""
                jj = ""
                
                do until pendidikan.eof 
                ' jurusan
                jurusan.commandText = "SELECT Jrs_nama FROM HRD_M_Jurusan WHERE Jrs_ID = '"& pendidikan("Ddk1_JrsID") &"'"
                ' Response.Write jurusan.commadText
                set jrs = jurusan.execute

                if jrs.eof then
                    pddk = ""
                else 
                    pddk = jrs("Jrs_Nama")
                end if

                ' jenjang
                jurusan.commandText = "SELECT JDdk_Nama FROM HRD_M_JenjangDidik WHERE JDdk_ID = '"& pendidikan("Ddk1_JDdkID") &"'"
                set jenjang = jurusan.execute
                
                if jenjang.eof then
                    jj = ""
                else    
                    jj = jenjang("JDdk_Nama")
                end if

                ' lulus
                if pendidikan("Ddk1_TamatYN") = "Y" then
                    tamat = "Lulus"
                else 
                    tamat = "Tidak"
                end if
                    
                %>
                    <tr>
                        <td>
                            <%=jj%>
                        </td>
                        <td>
                            <%=pendidikan("Ddk1_Nama")%>
                        </td>
                        <td>
                            <%=pddk%>
                        </td>
                        <td>
                            <%=pendidikan("Ddk1_Kota")%>
                        </td>
                        <td>
                            <%=pendidikan("Ddk1_Bulan1")%>
                        </td>
                        <td>
                            <%=pendidikan("Ddk1_Bulan2")%>
                        </td>
                        <td>
                            <%=pendidikan("Ddk1_Tahun1")%>
                        </td>
                        <td>
                            <%=pendidikan("Ddk1_Tahun2")%>
                        </td>
                        <td>
                            <%=tamat%>
                        </td>
                        <td>
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-primary btn-sm py-0 px-2"  data-bs-toggle="modal" data-bs-target="#modalPendidikan" onclick="return editPendidikan('<%=nip%>','<%=pendidikan("Ddk1_Nama")%>', '<%=pendidikan("Ddk1_Tahun1")%>')">
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return hapusPendidikan('<%=nip%>','<%=pendidikan("Ddk1_Nama")%>', '<%=pendidikan("Ddk1_Tahun1")%>')">
                                    Hapus
                                </button>
                            </div>
                        </td>
                    </tr>
                <% 
                pendidikan.movenext
                loop
                 %>
                </tbody>
            </table>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalPendidikan" onclick="return tambahPendidikan()">
                Tambah
            </button>
        </div>
    </div>
</div>

<% 
jurusan.commandText = "SELECT JDdk_ID, JDdk_nama FROM HRD_M_JenjangDidik"
set pjenjang = jurusan.execute

jurusan.commandText = "SELECT Jrs_nama, Jrs_ID FROM HRD_M_Jurusan"
set pjurusan = jurusan.execute
 %>

<!-- Modal -->
<div class="modal fade" id="modalPendidikan" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="labelModalPendidikan">TAMBAH PENDIDIKAN</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="pendidikan/tambah.asp" method="post">
        <input type='hidden' name='nip' id='nip' value="<%=nip%>">
        <!--for to update file -->
        <input type='hidden' name='jenjange' id='jenjange'>
        <input type='hidden' name='namae' id='namae'>
        <input type='hidden' name='jurusane' id='jurusane'>
        <input type='hidden' name='kotae' id='kotae'>
        <input type='hidden' name='blnSe' id='blnSe'>
        <input type='hidden' name='blnEs' id='blnEs'>
        <input type='hidden' name='thnSe' id='thnSe'>
        <input type='hidden' name='thnEs' id='thnEs'>
        <input type='hidden' name='tamate' id='tamate'>
        <!--end -->
        <div class="mb-3 row">
            <label for="jenjang" class="col-sm-2 col-form-label">Jenjang</label>
            <div class="col-sm-10">
                <select class="form-select" aria-label="Default select example" name="jenjang" id="jenjang" required>
                    <option value="">Pilih</option>
                <% do until pjenjang.eof %>
                    <option value="<%=pjenjang("Jddk_ID")%>"><%=pjenjang("JDdk_nama")%></option>
                <% 
                pjenjang.movenext
                loop
                 %>
                </select>
            </div>
        </div>
        <div class="mb-3 row">
            <label for="nama" class="col-sm-2 col-form-label">Nama</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="nama" maxlength="100" name="nama" required>
            </div>
        </div>
        <div class="mb-3 row">
            <label for="jurusan" class="col-sm-2 col-form-label">Jurusan</label>
            <div class="col-sm-10">
                <select class="form-select" aria-label="Default select example" name="jurusan" id="jurusan" required>
                    <option value="">Pilih</option>
                    <% 
                    do until pjurusan.eof
                     %>
                    <option value="<%=pjurusan("Jrs_ID")%>"><%=pjurusan("Jrs_nama")%></option>
                    <% 
                    pjurusan.movenext
                    loop
                     %>
                </select>
            </div>
        </div>

        <div class="mb-3 row">
            <label for="kota" class="col-sm-2 col-form-label">Kota</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" maxlength="100" id="kota" name="kota" required>
            </div>
        </div>

        <div class="mb-3 row">
            <label for="masa" class="col-sm-2 col-form-label">Masa</label>
            <div class="col-sm-2">
                <input type="text" class="form-control" id="blnS" name="blnS" onkeyup="return validPendidikan()" required>
            </div>
            <div class="col-sm-2 p-0">
                <input type="text" class="form-control" id="thnS" name="thnS" onkeyup="return validPendidikan()" required>
            </div>
            <div class="col-sm-1 text-center">
            -
            </div>
            <div class="col-sm-2">
                <input type="text" class="form-control" id="blnE" name="blnE" onkeyup="return validPendidikan()" required>
            </div>
            <div class="col-sm-3">
                <input type="text" class="form-control" id="thnE" name="thnE" onkeyup="return validPendidikan()" required>
            </div>
        </div>

        <div class="mb-3 row">
            <label for="tamat" class="col-sm-2 col-form-label">Tamat</label>
            <div class="col-sm-3">
                <select class="form-select" aria-label="Default select example" name="tamat" id="tamat" required>
                    <option value="">Pilih</option>
                    <option value="Y">Lulus</option>
                    <option value="N">Tidak</option>
                </select>
            </div>
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" id="submit" name="submit">Save</button>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
    const hapusPendidikan = (nip, nama, tahun) => {
        if ( confirm("Yakin Untuk Di Hapus") == true ){
            return window.location = 'pendidikan/hapus.asp?nip='+ nip +'&nama='+ nama +'&tahun='+tahun;
        }else{
            return false;
        }
    }
</script>
<!-- #include file='../layout/footer.asp' -->