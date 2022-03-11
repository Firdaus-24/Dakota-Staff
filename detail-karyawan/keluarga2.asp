<!-- #include file="../connection.asp"-->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 

dim nip, x
dim usaha, usahaid

nip = Request.QueryString("nip")

Set keluarga2_cmd = Server.CreateObject ("ADODB.Command")
keluarga2_cmd.ActiveConnection = MM_cargo_STRING

keluarga2_cmd.commandText = "SELECT dbo.HRD_T_Keluarga2.*, dbo.HRD_M_JenjangDidik.JDdk_ID, dbo.HRD_M_JenjangDidik.JDdk_Nama FROM HRD_T_Keluarga2 LEFT OUTER JOIN dbo.HRD_M_JenjangDidik ON HRD_T_Keluarga2.Kel2_JDdkID = HRD_M_JenjangDidik.JDdk_ID WHERE Kel2_NIP ='" & nip & "'"
set keluarga2 = keluarga2_cmd.execute

Set karyawan = Server.CreateObject ("ADODB.Command")
karyawan.ActiveConnection = MM_cargo_STRING

Set usaha = Server.CreateObject ("ADODB.Command")
usaha.ActiveConnection = MM_cargo_STRING

usaha.commandText = "SELECT Ush_ID, Ush_nama FROM HRD_M_JnsUsaha"
set usahaid = usaha.execute

usaha.commandText = "SELECT JDdk_id, JDdk_nama FROM HRD_M_JenjangDidik"
set pendidikan = usaha.execute

usaha.commandText = "SELECT Jbt_id, Jbt_nama FROM HRD_M_JabatanOuter"
set jabatan = usaha.execute

x = 0
 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=`, initial-scale=1.0">
    <title>Keluarga 2 </title>
    <!--#include file="../layout/header.asp"-->
    <script>
    const validasi = () =>{
        var mincar = 30;
        var nama = document.forms["form-keluarga1"]["nama"].value;
        var tmptl = document.forms["form-keluarga1"]["tmptl"].value;
        if (nama.length > mincar){
            alert("Maximal Nama 30 Karakter!!!");
            return false;
        }
        var tmptl = document.forms["form-keluarga1"]["tmptl"].value;
        if (tmptl.length > mincar){
            alert("Maximal Tempat lahir 30 Karakter!!!");
            return false;
        }
        return true;
    }
        const tambahkeluarga2 = () => {
            $('#labeltambah').html('TAMBAH KELUARGA2');
            $('#submit').html('Tambah');
            $('.modal-body form').attr('action', 'keluarga2/tambah.asp');
            $('#alias').val("");
            $('#hubungan').val("");
            $('#tmptl').val("");
            $('#tgll').val("");
            $('#jkelamin').val("");
            // make function onchange
            $('#pendidikan').val("");
            $('#busaha').val("");
            $('#jabatan').val("");
            $('#skeluarga').val("");

            // ambil nama yang lama
            $('#namae').val("");
            $('#hubungane').val("");
            $('#tmptle').val("");
            $('#tglle').val("");
            $('#jkelamine').val("");
            $('#pendidikane').val("");
            $('#busahae').val("");
            $('#jabatane').val("");
            $('#skeluargae').val("");

            input = $('#tgll');
            if(input.attr('type') == 'text') {
                input.attr('type', 'date');
            }
        }
    const keluarga2 = (id, nama) =>{
        $.ajax({
        url: 'keluarga2/update.asp',
        data: { id: id, nama : nama },
        method: 'post',
        success: function (data) {
            // console.log(data);
            function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                $('#alias').val(arry[1]);
                $('#namae').val(arry[1]);
                $('#hubungan').val(arry[2]);
                $('#hubungane').val(arry[2]);
                $('#tmptl').val(arry[3]);
                $('#tmptle').val(arry[3]);
                $('#tgll').val(arry[4]);
                $('#tglle').val(arry[4]);
                $('#jk').val(arry[5]);
                $('#jkelamine').val(arry[5]);
                $('#pendidikane').val(arry[6]);
                $('#busahae').val(arry[7]);
                $('#jabatane').val(arry[8]);
                $('#skeluargae').val(arry[9]);
                // make function onchange
                $('#pendidikan option[value='+ arry[6] +']').attr('selected','selected');
                $('#busaha option[value=' + arry[7] + ']').prop("selected", true);
                $('#jabatan option[value=' + arry[8] + ']').prop("selected", true);
                $('#skeluarga option[value=' + arry[9] + ']').prop("selected", true);

                input = $('#tgll');
                if(input.attr('type') == 'date') {
                    input.attr('type', 'text');
                } else {
                    input.attr('type', 'text');
                }
            }
            const koma = ",";
            splitString(data, koma);
        }
        });
        $('#labelTambah').html('UPDATE KELUARGA2');
        $('#submit').html('Update');
        $('.modal-body form').attr('action', 'keluarga2/update_add.asp');
        }
    </script>
    <style>
    
    </style>
</head>
<body>
<!--#include file="../landing.asp"-->
<!--#include file="template-detail.asp"-->
<div class="container" >
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
        <div class='col-sm-12'>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#tambah-keluarga2" onclick="return tambahkeluarga2()">
                Tambah
            </button>
        </div>
    </div>  
    </div>
    <div class="row contentDetail">
        <div class="col content-table" >
            <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Hubungan</th>
                        <th scope="col">Tempat Lahir</th>
                        <th scope="col">Tanggal Lahir</th>
                        <th scope="col">Jenis Kelamin</th>
                        <th scope="col">Pendidikan</th>
                        <th scope="col">Bidang Usaha</th>
                        <th scope="col">Jabatan</th>
                        <th scope="col">Status Keluarga</th>
                        <th scope="col">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                <% 
                phub = ""
                lusaha = ""
                ljabatan = ""
                sk = ""
                do until keluarga2.EOF
                x = x + 1

                'deskripsi
                if keluarga2("Kel2_hubungan") = 0 then  
                    phub = "Suami/Istri"
                else    
                    phub = "Anak"
                end if

                if keluarga2("Kel2_SttKelID") = 0 then
                    sk = "Kaka"
                elseIf keluarga2("Kel2_SttKelID") = 1 then
                    sk = "Adik"
                else 
                    sk = "Family Lain"
                end if
                'usaha
                keluarga2_cmd.commandText = "SELECT Ush_nama FROM HRD_M_JnsUsaha WHERE Ush_ID = '"& keluarga2("Kel2_UshID") &"'"
                set pusaha = keluarga2_cmd.execute

                if pusaha.eof then
                    lusaha = ""
                else 
                    lusaha = pusaha("Ush_nama")
                end if
                'jabatan
                keluarga2_cmd.commandText = "SELECT Jbt_Nama FROM HRD_M_JabatanOuter WHERE Jbt_ID = '"& keluarga2("Kel2_JbtID") &"'"
                set pjabatan = keluarga2_cmd.execute

                if pjabatan.eof then
                    ljabatan = ""
                else 
                    ljabatan = pjabatan("Jbt_nama")
                end if
                %> 
                    <tr>
                        <th scope="row"><%= x %> </th>
                        <td><%= keluarga2("Kel2_Nama") %> </td>
                        <td><%=phub %> </td>
                        <td><%= keluarga2("Kel2_TempatLahir") %> </td>
                        <td><%= keluarga2("Kel2_TglLahir") %> </td>
                        <% if keluarga2("Kel2_Sex") = "W" then%> 
                            <td><%= "Wanita" %> </td>
                        <% else %> 
                            <td><%= "Pria" %> </td>
                        <% end if %> 
                        <td><%= keluarga2("JDdk_Nama") %> </td>
                        <td><%=lusaha %> </td>
                        <td><%= ljabatan%> </td>
                        <td><%= sk %> </td>
                        <td>
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary btn-sm py-0 px-2" data-bs-toggle="modal" data-bs-target="#tambah-keluarga2" onclick="return keluarga2('<%=nip%>', '<%=keluarga2("Kel2_nama")%>')" >
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return hapuskeluarga2('<%=keluarga2("Kel2_nama")%>')" >
                                    Hapus
                                </button>
                            </div>
                        </td>
                    </tr>
                <% 
                Keluarga2.movenext
                loop
                %> 
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="tambah-keluarga2" tabindex="-1" aria-labelledby="labelTambah" aria-hidden="true" >
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="labelTambah">TAMBAH KELUARGA 2</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="keluarga2/tambah.asp" method="post" onsubmit="return validasi()">
        <div class="mb-3 row">
        <input type='hidden' name='nip' id='nip' value="<%=nip%>">
        <input type='hidden' name='namae' id='namae'>
        <input type='hidden' name='hubungane' id='hubungane'>
        <input type='hidden' name='pendidikane' id='pendidikane'>
        <input type='hidden' name='tmptle' id='tmptle'>
        <input type='hidden' name='tglle' id='tglle'>
        <input type='hidden' name='jkelamine' id='jkelamine'>
        <input type='hidden' name='busahae' id='busahae'>
        <input type='hidden' name='jabatane' id='jabatane'>
        <input type='hidden' name='skeluargae' id='skeluargae'>
        <label for="nama" class="col-sm-4 col-form-label">Nama</label>
        <div class="col-sm-8 mb-1">
            <input type="text" class="form-control" name="nama" id="alias" required>
        </div>
        <label for="hubungan" class="col-sm-4 col-form-label">Hubungan</label>
        <div class="col-sm-8 mb-1" >
            <select class="form-select" aria-label="Default select example" name="hubungan" id="hubungan" required>
                <option value="">Pilih</option>
                <option value="0">Suami/Istri</option>
                <option value="1">Anak</option>
            </select>
        </div>
        <label for="tmptl" class="col-sm-4 col-form-label">Tempat Lahir</label>
        <div class="col-sm-8 mb-1">
            <input type="text" class="form-control" name="tmptl" id="tmptl" required>
        </div>
        <label for="tgll" class="col-sm-4 col-form-label">Tgl Lahir</label>
        <div class="col-sm-8 mb-1">
            <input type="text" class="form-control" name="tgll" id="tgll" required>
        </div>
        <label for="jk" class="col-sm-4 col-form-label">Jenis Kelamin</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="jk" id="jk" required>
                <option value="">Pilih</option>
                <option value="P">Laki-Laki</option>
                <option value="W">Perempuan</option>
            </select>
        </div>
        <label for="pendidikan" class="col-sm-4 col-form-label">Pendidikan</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="pendidikan" id="pendidikan" required>
                <option value="">Pilih</option>
               <% do until pendidikan.eof %>
                <option value="<%=pendidikan("JDdk_id")%>"><%=pendidikan("JDdk_nama")%></option>
                <% 
                pendidikan.movenext
                loop
                 %>
            </select>
        </div>
        <label for="busaha" class="col-sm-4 col-form-label">Bidang Usaha</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="busaha" id="busaha" required>
                <option value="">Pilih</option>
               <% do until usahaid.eof %>
                <option value="<%=usahaid("Ush_id")%>" ><%=usahaid("Ush_Nama")%></option>
                <% 
                usahaid.movenext
                loop
                 %>
            </select>
        </div>
        <label for="jabatan" class="col-sm-4 col-form-label">Jabatan</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="jabatan" id="jabatan" required>
                <option value="">Pilih</option>
                <% do until jabatan.eof %>
                <option value="<%=jabatan("Jbt_id")%>"><%=jabatan("Jbt_nama")%></option>
                <% 
                jabatan.movenext
                loop
                 %>
            </select>
        </div>
        <label for="skeluarga" class="col-sm-4 col-form-label">Status Keluarga</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="skeluarga" id="skeluarga" required>
                <option value="">Pilih</option>
                <option value="0">Kaka</option>
                <option value="1">Adik</option>
                <option value="2">Family Lain</option>
            </select>
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
    const hapuskeluarga2 = (nama) =>{
        if (confirm("Yakin Untuk Di hapus") == true){
            // console.log(nama);
            return window.location='keluarga2/delete.asp?nip=<%=nip%>&name='+ nama
        }else{
            return false;
        }
    }
</script>
<!--#include file="../layout/footer.asp"-->