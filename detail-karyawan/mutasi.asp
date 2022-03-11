<!-- #include file='../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim mutasi_cmd, mutasi
dim nip 

nip = Request.QueryString("nip")

set mutasi_cmd = Server.CreateObject("ADODB.Command")
mutasi_cmd.activeConnection = MM_Cargo_String

mutasi_cmd.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_Jabatan.Jab_Nama, GLB_M_Agen.Agen_Nama, HRD_M_Jenjang.JJ_Nama, HRD_M_Divisi.Div_Nama, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama FROM HRD_T_Mutasi LEFT OUTER JOIN GLB_M_Agen ON HRD_T_Mutasi.Mut_TujAgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_T_Mutasi.Mut_TujJabCode = HRD_M_Jabatan.Jab_Code LEFT OUTER JOIN HRD_M_Jenjang ON HRD_T_Mutasi.Mut_TujJJID = HRD_M_Jenjang.JJ_ID LEFT OUTER JOIN HRD_M_DIvisi ON HRD_T_Mutasi.Mut_TujDDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_Mutasi.Mut_NIP = '"& nip &"' AND HRD_T_Mutasi.Mut_status = '0' AND HRD_T_Mutasi.Mut_AktifYN = 'Y' ORDER BY Mut_Tanggal DESC"
' Response.Write mutasi_cmd.commandText & "<br>"
set mutasi = mutasi_cmd.execute

'cabang
mutasi_cmd.commandText = "SELECT Agen_id, Agen_nama FROM GLB_M_agen ORDER BY Agen_Nama ASC"
set cabang = mutasi_cmd.execute

'jabatan
mutasi_cmd.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan ORDER BY Jab_Nama ASC"
set jabatan = mutasi_cmd.execute

'jenjang
mutasi_cmd.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang ORDER BY JJ_Nama ASC"
set jenjang = mutasi_cmd.execute

'divisi
mutasi_cmd.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Divisi ORDER BY DIv_Nama ASC"
set divisi = mutasi_cmd.execute
nip = ""
nama = ""
if not mutasi.eof then
    nip = mutasi("Kry_Nip")
    nama = mutasi("Kry_nama")
end if
 %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MUTASI</title>
    <!-- #include file='../layout/header.asp' -->
    <script>
    const tambahMutasi = () => {
        input1 = $('#tgl');

        $('#id').val("");
        $('#notrans').val("");
        input1.val("");
        $('#nosurat').val("");
        $('#memo').val("");
        $('#cabang').val("");
        $('#jabatan').val("");
        $('#jenjang').val("");
        $('#divisi').val("");
        $('#cabang1').val("");
        $('#jabatan1').val("");
        $('#jenjang1').val("");
        $('#divisi1').val("");

        input1.attr('type', 'date');
        $('#modalLabelMutasi').html('TAMBAH MUTASI');
        $('#submit_mutasi').html('Save');
        $('.modal-body form').attr('action', 'mutasi/tambah.asp');
    }
    const updateMutasi = (id) => {
        input1 = $('#tgl');
        $.ajax({
        url: 'mutasi/update.asp',
        data: { id : id },
        method: 'post',
        success: function (data) {
            function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                $('#id').val(arry[0]);
                $('#notrans').val(arry[0]);
                input1.val(arry[2]);
                $('#nosurat').val(arry[4]);
                $('#memo').val(arry[5]);
                $('#cabang option[value=' + arry[6] + ']').prop("selected", true);
                $('#jabatan option[value=' + arry[7] + ']').prop("selected", true);
                $('#jenjang option[value=' + arry[8] + ']').prop("selected", true);
                $('#divisi option[value=' + arry[9] + ']').prop("selected", true);
                $('#cabang1 option[value=' + arry[10] + ']').prop("selected", true);
                $('#jabatan1 option[value=' + arry[11] + ']').prop("selected", true);
                $('#jenjang1 option[value=' + arry[12] + ']').prop("selected", true);
                $('#divisi1 option[value=' + arry[13] + ']').prop("selected", true);
        
                if(input1.attr('type') == 'date') {
                    input1.attr('type', 'text');
                    input1.val(arry[2]);
                } else {
                    input1.on('click',function(){
                        input1.attr('type', 'date');
                    });
                }
            

            }
            const koma = ",";
            splitString(data, koma);
        }
        });
        $('#modalLabelMutasi').html('UPDATE MUTASI');
        $('#submit_mutasi').html('Update');
        $('.modal-body form').attr('action', 'mutasi/update_add.asp');
    }
    const aktifMutasi = (id,p, nip) => {
        if(confirm("Yakin Untuk DI Ubah??") == true ){
            window.location.href = 'mutasi/aktif.asp?id=' + id + '&p=' + p + '&nip=' + nip
        }
    }
    </script>
</head>
<!-- #include file='../landing.asp' -->
<!--#include file="template-detail.asp"-->
<div class='container'>
    <div class="row mb-2 mt-2 contentDetail">
        <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class="col-sm-2">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
            </div>
        <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
            <div class="col-sm-7">
                <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%=nama %> " disabled>
            </div>
    <div class='row mt-3'>
        <div class='col'>
            <button type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#modalMutasi" onclick="return tambahMutasi()">Tambah</button>
        </div>
    </div>
    </div>
    <div class='row contentDetail'>
        <div class='col content-table'>
            <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">No. Transaksi</th>
                        <th scope="col">Tanggal</th>
                        <th scope="col">No Surat</th>
                        <th scope="col">Memo</th>
                        <th scope="col">Tunjuan Cabang</th>
                        <th scope="col">Jabatan</th>
                        <th scope="col">Jenjang</th>
                        <th scope="col">Divis</th>
                        <th scope="col">Aktif</th>
                        <th scope="col text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        do until mutasi.eof 
                    %>
                    <tr>
                        <td>
                            <%= mutasi("Mut_ID") %>
                        </td>
                        <td>
                            <%= mutasi("Mut_Tanggal") %>
                        </td>
                        <td>
                            <%= mutasi("Mut_Nosurat") %>
                        </td>
                        <td>
                            <%= mutasi("Mut_Memo") %>
                        </td>
                        <td>
                            <%= mutasi("agen_Nama") %>
                        </td>
                        <td>
                            <%= mutasi("Jab_Nama") %>
                        </td>
                        <td>
                            <%= mutasi("JJ_Nama") %>
                        </td>
                        <td>
                            <%= mutasi("Div_Nama") %>
                        </td>
                        <td>
                            <%if mutasi("Mut_AktifYN") = "Y" then
                            Response.Write "Ya"
                            else
                            Response.Write "Tidak"
                            end if
                            %>
                            
                        </td>
                        <td>
                            <div class='btn btn-group'>
                                <button type="button" class="btn btn-primary btn-sm btn-sm py-0 px-2 " data-bs-toggle="modal" data-bs-target="#modalMutasi" onclick="return updateMutasi('<%= mutasi("Mut_ID") %>')">
                                    Update
                                </button>
                                <% if mutasi("Mut_AktifYn") = "Y" then %>
                                    <button type="button" class="btn btn-danger btn-sm btn-sm py-0 px-2 " onclick="return aktifMutasi('<%= mutasi("Mut_ID") %>', '<%= mutasi("Mut_AktifYN") %>', '<%= mutasi("Mut_Nip") %>')">
                                        NonAktif
                                    </button>
                                <% else %>
                                    <button type="button" class="btn btn-warning btn-sm btn-sm py-0 px-2 " onclick="return aktifMutasi('<%= mutasi("Mut_ID") %>', '<%= mutasi("Mut_AktifYN") %>', '<%= mutasi("Mut_Nip") %>')">
                                        Aktif
                                    </button>
                                <% end if %>
                            </div>
                        </td>
                    </tr>
                    <% 
                        mutasi.movenext
                        loop
                     %>
                </tbody>
            </table>
        </div>
    </div>
    
</div>
<!-- Modal -->
<div class="modal fade" id="modalMutasi" tabindex="-1" aria-labelledby="modalLabelMutasi" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabelMutasi">TAMBAH MUTASI</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="mutasi/tambah.asp" method="post">
            <input type='hidden' name='nip' id='nip' value="<%=nip%>">
            <input type='hidden' name='id' id='id' value="">
            <div class="mb-3 row">
                <label for="notrans" class="col-sm-3 col-form-label">No.Transaksi</label>
                <div class="col-sm-6 ">
                    <input type="text" class="form-control" id="notrans" name="notrans" readonly>
                </div>
            </div>
            <div class="row g-3 align-items-center">
                <div class="col-3">
                    <label for="tgl" class="col-form-label">Tanggal</label>
                </div>
                <div class="col">
                    <input type="date" id="tgl" name="tgl" class="form-control" aria-describedby="dateHelpInline" required>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="nosurat" class="col-form-label">No. Surat</label>
                </div>
                <div class="col">
                    <input type="text" id="nosurat" name="nosurat" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 mt-2">
                <label for="memo" class="form-label">Memo</label>
                <input type="text" class="form-control" id="memo" name="memo" required>
            </div>
            <div class="mt-2">
                <label for="asal" class="form-label fw-bold">ASAL</label>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="cabang" class="col-form-label">Cabang</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="cabang" id="cabang" required>
                        <option value="">Pilih</option>
                        <% do until cabang.eof %>
                        <option value="<%= cabang("Agen_ID") %>"><%= cabang("Agen_Nama") %></option>
                        <% 
                        cabang.movenext
                        loop
                        cabang.MoveFirst 
                         %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="jabatan" class="col-form-label">Jabatan</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="jabatan" id="jabatan" required>
                        <option value="">Pilih</option>
                        <% do until jabatan.eof %>
                        <option value="<%= jabatan("Jab_Code") %>"><%= jabatan("Jab_Nama") %></option>
                        <% 
                        jabatan.movenext
                        loop
                        jabatan.MoveFirst 
                         %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="jenjang" class="col-form-label">Jenjang</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="jenjang" id="jenjang" required>
                        <option value="">Pilih</option>
                        <% do until jenjang.eof %>
                        <option value="<%= jenjang("JJ_ID") %>"><%= jenjang("JJ_Nama") %></option>
                        <% 
                        jenjang.movenext
                        loop
                        jenjang.MoveFirst 
                         %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="divisi" class="col-form-label">Divisi</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="divisi" id="divisi" required>
                        <option value="">Pilih</option>
                        <% do until divisi.eof %>
                        <option value="<%= divisi("Div_Code") %>"><%= divisi("Div_Nama") %></option>
                        <% 
                        divisi.movenext
                        loop
                        divisi.MoveFirst 
                         %>
                    </select>
                </div>
            </div>
            <div class="mt-2">
                <label for="tujuan" class="form-label fw-bold">TUJUAN</label>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="cabang1" class="col-form-label">Cabang</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="cabang1" id="cabang1" required>
                        <option value="">Pilih</option>
                        <% do until cabang.eof %>
                        <option value="<%= cabang("Agen_ID") %>"><%= cabang("Agen_Nama") %></option>
                        <% 
                        cabang.movenext
                        loop
                         %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="jabatan1" class="col-form-label">Jabatan</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="jabatan1" id="jabatan1" required>
                        <option value="">Pilih</option>
                        <% do until jabatan.eof %>
                        <option value="<%= jabatan("Jab_Code") %>"><%= jabatan("Jab_Nama") %></option>
                        <% 
                        jabatan.movenext
                        loop
                         %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="jenjang1" class="col-form-label">Jenjang</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="jenjang1" id="jenjang1" required>
                        <option value="">Pilih</option>
                        <% do until jenjang.eof %>
                        <option value="<%= jenjang("JJ_ID") %>"><%= jenjang("JJ_Nama") %></option>
                        <% 
                        jenjang.movenext
                        loop
                         %>
                    </select>
                </div>
            </div>
            <div class="row g-3 align-items-center mt-1">
                <div class="col-3">
                    <label for="divisi1" class="col-form-label">Divisi</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="divisi1" id="divisi1" required>
                        <option value="">Pilih</option>
                        <% do until divisi.eof %>
                        <option value="<%= divisi("Div_Code") %>"><%= divisi("Div_Nama") %></option>
                        <% 
                        divisi.movenext
                        loop
                         %>
                    </select>
                </div>
            </div>
    

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" name="submit_mutasi" id="submit_mutasi">Save</button>
        </form>
      </div>
    </div>
  </div>
</div>


<!-- #include file='../layout/footer.asp' -->