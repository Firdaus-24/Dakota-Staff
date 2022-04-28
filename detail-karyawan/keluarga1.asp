<!-- #include file="../connection.asp"-->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("HM2") = false then
    response.Redirect("../dashboard.asp")
end if

dim nip, x, usaha

nip = Request.QueryString("nip")

Set usaha_cmd = Server.CreateObject ("ADODB.Command")
usaha_cmd.ActiveConnection = MM_cargo_STRING

Set keluarga_cmd = Server.CreateObject ("ADODB.Command")
keluarga_cmd.ActiveConnection = MM_cargo_STRING

keluarga_cmd.commandText = "SELECT dbo.HRD_T_Keluarga1.*, dbo.HRD_M_JenjangDidik.JDdk_ID, dbo.HRD_M_JenjangDidik.JDdk_nama FROM HRD_T_Keluarga1 LEFT OUTER JOIN dbo.HRD_M_JenjangDidik ON HRD_T_Keluarga1.Kel1_JDdkID = HRD_M_JenjangDidik.JDdk_ID WHERE Kel1_NIP ='" & nip & "'"

set keluarga = keluarga_cmd.execute
x = 0
 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=`, initial-scale=1.0">
    <title>Keluarga 1 </title>
    <!--#include file="../layout/header.asp"-->
    <link rel="stylesheet" href="../css/detail-all.css">
    <script>
        const validasi = (form) =>{
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
        // tambahkeluarga1
        const tambahkeluarga1 = () => {
            $('#labeltambahkeluarga1').html('TAMBAH KELUARGA1');
            $('.labeltambahkeluarga1').html('Tambah');
            $('.modal-body form').attr('action', 'keluarga1/tambah.asp');
            $('#nama').val("");
            $('#hubungan').val("Pilih");
            $('#tmptl').val("");
            $('#tgll').val("");
            $('#jkelamin').val("Pilih");
            // make function onchange
            $('#pendidikan').val("Pilih");
            $('#busaha').val("Pilih");
            $('#jabatan').val("Pilih");
            $('#skeluarga').val("Pilih");

            // ambil nama yang lama
            $('#namae').val("");

            input = $('#tgll');
            if(input.attr('type') == 'text') {
                input.attr('type', 'date');
            }
        }
        // ubah keluarga1
        const ubahkeluarga = (id, nama) =>{
        $.ajax({
        url: 'keluarga1/update.asp',
        data: { id: id, nama : nama },
        method: 'post',
        success: function (data) {
            function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                // console.log(arry[6]);
                $('#nama').val(arry[1]);
                $('#namae').val(arry[1]);
                $('#hubungan').val(arry[2]);
                $('#hubungane').val(arry[2]);
                $('#tmptl').val(arry[3]);
                $('#tmptle').val(arry[3]);
                // $('#tgll').val(arry[4]);
                $('#tglle').val(arry[4]);
                $('#jkelamin').val(arry[5]);
                $('#jkelamine').val(arry[5]);
                $('#pendidikane').val(arry[6]);
                $('#busahae').val(arry[7]);
                $('#jabatane').val(arry[8]);
                $('#skeluargae').val(arry[9]);
                // make function onchange
                $('#pendidikan option[value=' + arry[6] + ']').prop("selected", true);
                $('#busaha option[value=' + arry[7] + ']').prop("selected", true);
                $('#jabatan option[value=' + arry[8] + ']').prop("selected", true);
                $('#skeluarga option[value=' + arry[9] + ']').prop("selected", true);
            
            input = $('#tgll');
            if(input.attr('type') == 'date') {
                input.attr('type', 'text');
                 $('#tgll').val(arry[4]);
            } else {
                input.on('click',function(){
                    input.attr('type', 'date');
                })
            }
            }
            const koma = ",";
            splitString(data, koma);
        }
        });
        $('#labeltambahkeluarga1').html('UPDATE KELUARGA1');
        $('.labeltambahkeluarga1').html('Update');
        $('.modal-body form').attr('action', 'keluarga1/update_add.asp');
        
        }
    </script>
    
</head>
<body>
<!--#include file="../landing.asp"-->
<!--#include file="template-detail.asp"-->
<div class="container">
    <div class='row mt-2 mb-2 contentDetail'>
        <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class="col-sm-2">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
            </div>
                    <% 
                    usaha_cmd.commandText = "SELECT Kry_nama FROM HRD_M_Karyawan WHERE Kry_Nip='"& nip &"'"
                    set krywn = usaha_cmd.execute
                    %>
        <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
            <div class="col-sm-7">
                <input type="text" class="form-control form-control-sm" name="nkaryawan" id="nkaryawan" value="<%= krywn("Kry_Nama") %> " disabled>
            </div>
    <div class='row mt-3'>
        <div class='col-sm'>
            <%if session("HM2A") = true then%>
                <button type="button" class="btn btn-primary btnTambah" data-bs-toggle="modal" data-bs-target="#tambah-keluarga1" onclick="return tambahkeluarga1()">
                    Tambah
                </button>
            <%end if%>
        </div>
    </div>
    </div>
    <div class="row contentDetail">
        <div class="col-md content-table">
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
                        <%if session("HM2B") = true or session("HM2C") = true then%>
                            <th scope="col" class="text-center">Aksi</th>
                        <%end if%>
                    </tr>
                </thead>
                <tbody>
                <% 
                x = 0
                skeluarga = ""
                jusaha = ""
                jjbt = ""
                hub = ""
                do until keluarga.EOF
                x = x + 1 
                'definisi bidang usaha
                usaha_cmd.commandText = "SELECT Ush_Nama FROM HRD_M_JnsUsaha WHERE Ush_ID = '"& keluarga("Kel1_UshID") &"'"
                set usaha = usaha_cmd.execute
                
                if usaha.eof then
                    jusaha = ""
                else    
                    jusaha = usaha("Ush_Nama")
                end if

                usaha_cmd.commandText = "SELECT Jbt_nama FROM HRD_M_JabatanOuter WHERE Jbt_ID = '"& keluarga("Kel1_JbtID") &"'"
                set jabatan = usaha_cmd.execute

                if jabatan.eof then
                    jjbt = ""
                else 
                    jjbt = jabatan("Jbt_nama")
                end if
                'definisi status keluarga
                if keluarga("Kel1_SttKelID") = 0 then
                    skeluarga = "Kaka"
                elseIf keluarga("Kel1_SttKelID") = 1 then
                    skeluarga = "Adik"
                else
                    skeluarga = "Family Lain"
                end if
                ' hubungan
                if keluarga("Kel1_Hubungan") = 0 then
                    hub = "Ayah"
                elseIf keluarga("Kel1_hubungan") = 1 then
                    hub = "Ibu"
                else 
                    hub = "Saudara"
                end if
                %> 
                    <tr>
                        <th scope="row"><%= x %> </th>
                        <td><%= keluarga("Kel1_Nama") %> </td>
                        <td><%=hub%></td>
                        <td><%= keluarga("Kel1_TempatLahir") %> </td>
                        <td><%= keluarga("Kel1_TglLahir") %> </td>
                        <% if keluarga("Kel1_Sex") = "W" then %> 
                            <td><%= "Perempuan" %> </td>
                        <% else %> 
                            <td><%= "Laki-Laki" %> </td>
                        <% end if %> 
                        <td><%= keluarga("JDdk_Nama") %> </td>
                        <td><%=jusaha%></td>
                        <td><%=jjbt%></td>
                        <td><%= skeluarga %> </td>
                        <%if session("HM2B") = true or session("HM2C") = true then%>
                            <td>
                                <div class="btn-group">
                                    <%if session("HM2B") = true then%>
                                        <button type="button" class="btn btn-primary btn-sm py-0 px-2" data-bs-toggle="modal" data-bs-target="#tambah-keluarga1" onclick="return ubahkeluarga('<%=keluarga("Kel1_Nip")%>','<%=keluarga("Kel1_nama")%>')">
                                            Edit
                                        </button>
                                    <%end if%>
                                    <%if session("HM2C") = true then%>
                                        <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return hapuskeluarga1('<%=nip%>','<%=keluarga("Kel1_Nama")%>', '<%=keluarga("Kel1_Hubungan")%>')">
                                        Hapus
                                        </button>
                                    <%end if%>
                                </div>
                            </td>
                        <%end if%>
                    </tr>
                <% 
                keluarga.movenext
                loop
                %> 
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="tambah-keluarga1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="labeltambahkeluarga1">TAMBAH KELUARGA1</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form method="post" action="keluarga1/tambah.asp" id="form-keluarga1" onsubmit="return validasi()">
        <input type="hidden" class="form-control" name="nip" id="nip" value="<%=nip%>">
        <input type='hidden' name='namae' id='namae'>
        <input type='hidden' name='hubungane' id='hubungane'>
        <input type='hidden' name='pendidikane' id='pendidikane'>
        <input type='hidden' name='tmptle' id='tmptle'>
        <input type='hidden' name='tglle' id='tglle'>
        <input type='hidden' name='jkelamine' id='jkelamine'>
        <input type='hidden' name='busahae' id='busahae'>
        <input type='hidden' name='jabatane' id='jabatane'>
        <input type='hidden' name='skeluargae' id='skeluargae'>
       <div class="mb-3 row">
        <label for="nama" class="col-sm-4 col-form-label">Nama</label>
        <div class="col-sm-8 mb-1">
            <input type="text" class="form-control" name="nama" id="nama" required>
        </div>
        <label for="inputHubungan" class="col-sm-4 col-form-label">Hubungan</label>
        <div class="col-sm-8 mb-1" >
            <select class="form-select" aria-label="Default select example" name="hubungan" id="hubungan" required >
                <option value="">Pilih</option>
                <option value="0">Ayah</option>
                <option value="1">Ibu</option>
                <option value="2">Saudara</option>
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
        <label for="inputJenis Kelamin" class="col-sm-4 col-form-label">Jenis Kelamin</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="jkelamin" id="jkelamin" required>
                <option value="">Pilih</option>
                <option value="P">Laki-Laki</option>
                <option value="W">Perempuan</option>
            </select>
        </div>
        <label for="inputPendidikan" class="col-sm-4 col-form-label">Pendidikan</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="pendidikan" id="pendidikan" required>
                <option value="">Pilih</option>
                <% 
                keluarga_cmd.commandText = "SELECT JDdk_nama, JDdk_ID FROM HRD_M_JenjangDidik"
                set pendidikan = keluarga_cmd.execute

                do until pendidikan.eof
                 %>
                <option value="<%=pendidikan("JDdk_ID")%>"><%=pendidikan("JDdk_Nama")%></option>
                <% 
                pendidikan.movenext
                loop
                 %>
            </select>
        </div>
        <label for="inputBidang Usaha" class="col-sm-4 col-form-label">Bidang Usaha</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="busaha" id="busaha" required>
                <option value="">Pilih</option>
                <% 
                usaha_cmd.commandText = "SELECT Ush_nama, Ush_ID FROM HRD_M_JnsUsaha"
                set usaha = usaha_cmd.execute

                do until usaha.eof
                 %>
                    <option value="<%=usaha("Ush_ID")%>"><%=usaha("Ush_Nama")%></option>
                <% 
                usaha.movenext
                loop
                 %>
            </select>
        </div>
        <label for="inputJabatan" class="col-sm-4 col-form-label">Jabatan</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="jabatan" id="jabatan" required>
                <option value="">Pilih</option>
                <% 
                usaha_cmd.commandText = "SELECT Jbt_nama, Jbt_ID FROM HRD_M_JabatanOuter"
                set jabatan = usaha_cmd.execute

                do until jabatan.eof
                 %>
                <option value="<%=jabatan("Jbt_ID")%>"><%=jabatan("Jbt_nama")%></option>
                <% 
                jabatan.movenext
                loop
                 %>
            </select>
        </div>
        <label for="inputStatus Keluarga" class="col-sm-4 col-form-label">Status Keluarga</label>
        <div class="col-sm-8 mb-1">
            <select class="form-select" aria-label="Default select example" name="skeluarga" id="skeluarga" required>
                <option value="">Pilih</option>
                <option value="0">Kaka</option>
                <option value="1">Adik</option>
                <option value="2">Family Lain</option>
            </select>
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
    function hapuskeluarga1 (nip, nama, hub){
        if (confirm("Yakin Untuk Di hapus") == true){
            console.log(hub);
            return window.location='keluarga1/delete.asp?nip='+ nip + '&nama=' + nama + '&hub=' + hub
        }else{
            return false;
        }
    }
</script>
<!--#include file="../layout/footer.asp"-->