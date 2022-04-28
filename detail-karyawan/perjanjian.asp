<!-- #include file='../connection.asp' -->
<%
    if session("HM12") = false then
        response.Redirect("../dashboard.asp")
    end if

    dim perjanjian, nip, nama

    nip = Request.QueryString("nip")

    set perjanjian = Server.CreateObject("ADODB.Command")
    perjanjian.activeConnection = MM_Cargo_String

    perjanjian.CommandText = "SELECT * FROM HRD_T_SPK WHERE SPK_Nip = '"& nip &"'"

    set result = perjanjian.execute

    'definisi nama karyawan
    perjanjian.CommandText = "SELECT Kry_Nama FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
    set karyawan = perjanjian.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PERJANJIAN</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="../css/detail-all.css">
    <script>
        const tambahPerjanjian = () => {
            input1 = $('#tgl');
            $('#modalLabelperjanjian').html('TAMBAH PERJANJIAN');
            $('#submit_mutasi').html('Save');
            $('.modal-body form').attr('action', 'perjanjian/tambah.asp');

            $('#notrans').val("");
            $('#nosurat').val("");
            input1.val("");
            $('#perihal').val("");

            input1.attr('type', 'date');
        }

        const updatePerjanjian = (id) => {
            var input1 = $('#tgl');
            $.ajax({
            url: 'perjanjian/update.asp',
            data: { id : id },
            method: 'post',
            success: function (data) {
                function splitString(strToSplit, separator) {
                    var arry = strToSplit.split(separator);
                    $('#notrans').val(arry[0]);
                    $('#nosurat').val(arry[2]);
                    input1.val(arry[3]);
                    $('#perihal').val(arry[4]);

            
                    if(input1.attr('type') == 'date') {
                        input1.attr('type', 'text');
                        input1.val(arry[3]);
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
            $('#modalLabelperjanjian').html('UPDATE PERJANJIAN');
            $('#submit_perjanjian').html('Update');
            $('.modal-body form').attr('action', 'PERJANJIAN/update_add.asp');
        }
        const aktifPerjanjian = (id,p,nip) => {
            if (confirm("Yakin Untuk Di Ubah??") == true ){
                window.location.href = 'perjanjian/aktif.asp?id='+ id + '&p=' + p + '&nip=' + nip
            }
        }
    </script>
</head>
<!-- #include file='../landing.asp' -->
<!-- #include file='template-detail.asp' -->
<div class='container'>
    <div class="row mt-2 mb-2 contentDetail">
        <div class="col">
            <div class="row mb-2 mt-2">
                <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
                </div>
                <label for="nip" class="col-sm-2 col-form-label col-form-label-sm p-0">Nama Karyawan</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%=karyawan("Kry_Nama") %> " disabled>
                </div>
            </div>
        </div>
        <div class='row mt-3'>
            <div class='col'>
                <div class='col'>
                    <%if session("HM12A")  = true then%>
                        <button type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#modalPerjanjian" onclick="return tambahPerjanjian()">Tambah</button>
                    <%end if%>
                </div>
            </div>
        </div>
    </div>
    <div class='row contentDetail'>
        <div class='col content-table'>
            <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">No. Transaksi</th>
                        <th scope="col">No Surat</th>
                        <th scope="col">Tanggal</th>
                        <th scope="col">Perihal</th>
                        <th scope="col">Aktif</th>
                        <%if session("HM12B") = true OR session("HM12C") = true then%>
                        <th scope="col" class="text-center">Aksi</th>
                        <%end if%>
                    </tr>
                </thead>
                <tbody>
                <% do until result.eof %>
                    <tr>
                        <td>
                            <%= result("SPK_ID") %>
                        </td>
                        <td>
                            <%= result("SPK_No") %>
                        </td>
                        <td>
                            <%= result("SPK_Tanggal") %>
                        </td>
                        <td>
                            <%= result("SPK_Perihal") %>
                        </td>
                        <td>
                            <% if result("SPK_AktifYN") = "Y" then %>
                            Ya
                            <% else %>
                            Tidak
                            <% end if %>
                        </td>
                        <%if session("HM12B") = true OR session("HM12C") = true then%>
                            <td class="text-center">
                                <div class='btn btn-group'>
                                    <%if session("HM12B") = true then%>
                                        <button type="button" class="btn btn-primary btn-sm btn-sm py-0 px-2 " data-bs-toggle="modal" data-bs-target="#modalPerjanjian" onclick="return updatePerjanjian('<%= result("SPK_ID") %>')">
                                            Update
                                        </button>
                                    <%end if%>
                                    <%if session("HM12C") = true then%>
                                        <% if result("SPK_AktifYN") = "Y" then %>
                                            <button type="button" class="btn btn-danger py-0 px-2"  onclick="return aktifPerjanjian('<%= result("SPK_ID") %>', '<%= result("SPK_AktifYN") %>', '<%= result("SPK_Nip") %>')">NoAktif</button>
                                        <% else %>
                                            <button type="button" class="btn btn-warning py-0 px-2"  onclick="return aktifPerjanjian('<%= result("SPK_ID") %>', '<%= result("SPK_AktifYN") %>', '<%= result("SPK_Nip") %>')">Aktif</button>
                                        <% end if %>
                                    <% end if %>
                                </div>
                            </td>
                        <%end if%>
                    </tr>
                <% 
                result.movenext
                loop
                 %>
                <tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalPerjanjian" tabindex="-1" aria-labelledby="modalPerjanjian" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabelperjanjian">TAMBAH PERJANJIAN</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="perjanjian/tambah.asp" method="post">
            <input type='hidden' name='nip' id='nip' value="<%=nip%>">
            <input type='hidden' name='id' id='id' value="">
            <div class="mb-3 row">
                <label for="notrans" class="col-sm-3 col-form-label">No.Transaksi</label>
                <div class="col-sm-6 ">
                    <input type="text" class="form-control" id="notrans" name="notrans" readonly>
                </div>
            </div>
            <div class="row g-3 align-items-center mb-3">
                <div class="col-3">
                    <label for="tgl" class="col-form-label">Tanggal</label>
                </div>
                <div class="col">
                    <input type="date" id="tgl" name="tgl" class="form-control" aria-describedby="dateHelpInline" required>
                </div>
            </div>
            <div class="row g-3 align-items-center">
                <div class="col-3">
                    <label for="nosurat" class="col-form-label">No.Surat</label>
                </div>
                <div class="col">
                    <input type="number" id="nosurat" name="nosurat" class="form-control" aria-describedby="dateHelpInline" required>
                </div>
            </div>
            <div class="mb-3">
                <label for="perihal" class="form-label">Perihal</label>
                <textarea class="form-control" id="perihal" name="perihal" rows="3"></textarea>
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