<!-- #include file='../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("HM7") = false then
    response.Redirect("../dashboard.asp")
end if

dim memo
dim nip

nip = Request.QueryString("nip")

set memo = Server.CreateObject("ADODB.Command")
memo.activeConnection = MM_Cargo_String

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.activeConnection = MM_Cargo_String

memo.commandText = "SELECT HRD_T_MEMO.*, HRD_M_Karyawan.Kry_Nama FROM HRD_T_MEMO LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Memo.Memo_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_MEMO.Memo_NIp = '"& nip &"'"
'response.write memo.commandText & "<BR>"
set memo = memo.execute

karyawan.commandText = "select Kry_Nama from HRD_M_Karyawan where kry_nip = '"& nip &"'"
set karyawan = karyawan.execute

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CATATAN</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="../css/detail-all.css">
    <script>
        const ubahMemo = (id) => {
            let tgl = $('#tgl')
            tgl.attr('type', 'text');

            $.ajax({
            url: 'memo/update.asp',
            data: { id:id },
            method: 'post',
            success: function (data) {
                // console.log(data);
                function splitString(strToSplit, separator) {
                    var arry = strToSplit.split(separator);
                    
                    $('#notrans').val(arry[0]);
                    $("#status option[value='"+arry[1]+"']").attr("selected", true);
                    tgl.val(arry[2]);
                    $('#subject').val(arry[3]);
                    $('#memo').val(arry[4]);
                }
                const koma = ",";
                splitString(data, koma);
            }
            });
            tgl.on('focus', function(){
                tgl.attr('type', 'date');
            });

            $('#labelModalMemo').html('UPDATE MEMO');
            $('#submit_memo').html('Update');
            $('.modal-body form').attr('action', 'memo/update_add.asp');
        }
    </script>
</head>

<body>
<!-- #include file='../landing.asp' -->
<!--#include file="template-detail.asp"-->
<div class='container '>
    <div class="row mt-2 mb-2 contentDetail">
        <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class="col-sm-2">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
            </div>
        <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
            <div class="col-sm-7">
                <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%= karyawan("Kry_Nama") %> " disabled>
            </div>
        <div class='row mt-3'>
            <div class='col'>
                <%if session("HM7A") = true then%>
                    <button type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#modalMemo">Tambah</button>
                <%end if%>
            </div>
        </div>
    </div>
    <div class='row contentDetail'>
        <div class='col content-table'>
            <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">No.Transaksi</th>
                        <th scope="col">Status</th>
                        <th scope="col">Tanggal</th>
                        <th scope="col">Subject</th>
                        <th scope="col">Catatan</th>
                        <th scope="col">Aktif</th>
                        <%if session("HM7B") = true OR session("HM7C") = true then%>
                            <th scope="col" class="text-center">Aksi</th>
                        <%end if%>
                    </tr>
                </thead>
                <tbody>
                <% do until memo.eof %>
                    <tr>
                        <th><%=memo("Memo_ID")%></th>
                        <td>
                            <% if memo("Memo_Status") = "0" then %>
                            Prestasi
                            <% elseIf memo("Memo_status") = "1" then %>
                            Kesalahan
                            <% else %>
                            Catatan
                            <% end if %>
                        </td>
                        <td><%=memo("Memo_tanggal")%></td>
                        <td><%=memo("Memo_subject")%></td>
                        <td><%=memo("Memo_isi")%></td>
                        <td>
                            <% if memo("Memo_AktifYN") = "Y" then%>
                            Ya
                            <% else %>
                            Tidak
                            <% end if %>
                        </td>
                        <%if session("HM7B") = true OR session("HM7C") = true then%>
                            <td>
                                <div class="btn-group">
                                    <%if session("HM7B") = true then%>
                                        <button type="button" class="btn btn-primary btn-sm py-0 px-2" data-bs-toggle="modal" data-bs-target="#modalMemo" onclick="return ubahMemo('<%=memo("Memo_ID")%>')">
                                            Edit
                                        </button>
                                    <%end if%>
                                    <%if session("HM7C") = true then%>
                                        <% if memo("Memo_AktifYN") = "Y" then %>
                                            <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="if(confirm('Yakin Untuk Diubah?')) window.location.href = 'memo/aktif.asp?id=<%=memo("Memo_ID")%>&p=<%=memo("Memo_AktifYN")%>&q=<%= memo("Memo_Nip") %>'">
                                                NoAktif
                                            </button>
                                        <% else %>
                                            <button type="button" class="btn btn-warning btn-sm py-0 px-2"onclick="if(confirm('Yakin Untuk Diubah?')) window.location.href = 'memo/aktif.asp?id=<%=memo("Memo_ID")%>&p=<%=memo("Memo_AktifYN")%>&q=<%= memo("Memo_Nip") %>'">
                                                Aktif
                                            </button>
                                        <% end if %>
                                    <% end if %>
                                </div>
                            </td>
                        <%end if%>
                    </tr>
                <% 
                memo.movenext
                loop
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="modalMemo" tabindex="-1" aria-labelledby="labelModalMemo" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="labelModalMemo">TAMBAH CATATAN</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="memo/tambah.asp" method="post">
            <input type='hidden' name='nip' id='nip' value="<%=nip%>">
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
                    <label for="status" class="col-form-label">Status</label>
                </div>
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="status" id="status" required>
                        <option value="">Pilih</option>
                        <option value="0">Prestasi</option>
                        <option value="1">Kesalahan</option>
                        <option value="2">Catatan </option>
                    </select>
                </div>
            </div>
            <div class="mb-3 mt-2">
                <label for="subject" class="form-label">Subject</label>
                <input type="text" class="form-control" id="subject" name="subject" autocomplete='off' required>
            </div>
            <div class="mb-3">
                <label for="memo" class="form-label">Memo</label>
                <textarea class="form-control" id="memo" name="memo" rows="3" required></textarea>
            </div>
    

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" name="submit_memo" id="submit_memo">Save</button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- #include file='../layout/footer.asp' -->