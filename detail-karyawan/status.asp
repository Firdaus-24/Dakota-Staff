<!-- #include file='../connection.asp' -->
<%
    if session("HM8") = false then
        response.Redirect("../dashboard.asp")
    end if

    dim status, p, status_cmd

    p = Request.QueryString("nip")

    set status_cmd = Server.CreateObject("ADODB.Command")
    status_cmd.activeConnection = MM_Cargo_string

    status_cmd.commandText = "SELECT HRD_T_StatusKaryawan.*, HRD_M_Karyawan.Kry_Nama FROM HRD_T_StatusKaryawan LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_StatusKaryawan.SK_KryNIp = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_StatusKaryawan.SK_KryNip = '"& p &"' ORDER BY SK_TglIn DESC"
    set status = status_cmd.execute

    status_cmd.commandText = "SELECT Kry_Nama FROM HRD_M_Karyawan WHERE Kry_Nip = '"& p &"'"
    ' Response.Write status_cmd.commandText & "<br>"  
    set karyawanNama = status_cmd.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STATUS</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="../css/detail-all.css">
    <script>
        const tambahStatus = () => {
            $('#modalLabelStatus').html('TAMBAH STATUS');
            $('#submit-status').html('Save');
            $('.modal-body form').attr('action', 'status/tambah.asp');
            $("#status option[value='']").attr('selected', true);
            $('#id').val("");
            $('#tgla').val("");
            $('#tgle').val("");
            // $('#status').val("");

            $('#tgle').prop('required',false);
            $('#tgla').attr('type', 'date');
            $('#tgle').attr('type', 'date');
            
        }
        const updatestatus = (id, tgl) => {
            $('#tgle').prop('required',true);
            $.ajax({
                url: 'status/update.asp',
                data: { id : id, tgl : tgl},
                method: 'post',
                success: function (data) {
                    function splitString(strToSplit, separator) {
                        var arry = strToSplit.split(separator);
                        $('#tgla').attr('type', 'text');
                        $('#tgle').attr('type', 'text');
                        $('#id').val(arry[0]);
                        $('#tgla').val(arry[1]);
                        $('#tgle').val(arry[2]);
                        $('#status option[value=' + arry[3] + ']').prop("selected", true);;

                    }
                    const koma = ",";
                    splitString(data, koma);
                }
            });
            $('#modalLabelStatus').html('UPDATE STATUS');
            $('#submit-status').html('Update');
            $('.modal-body form').attr('action', 'status/update_add.asp');
            
        }
        const hapusStatus = (id, tgl, nip) => {
            if (confirm("Yakin Untuk Dihapus??") == true ){
                window.location.href = 'status/hapus.asp?id='+ id + '&tgl=' + tgl + '&nip=' + nip
            }
        }
        function changeInp(e){
            if ( e == 1 ){
                $('#tgla').attr('type', 'date');
            }
            if ( e == 2 ){
                $('#tgle').attr('type', 'date');
            }
        }
    </script>
</head>

<body>
<!-- #include file='../landing.asp' -->
<!-- #include file='template-detail.asp' -->
<div class="container">
    <div class="row mb-2 mt-2 contentDetail">
        <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class="col-sm-2">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= p %> " disabled>
            </div>
        <label for="nip" class="col-sm-2 col-form-label col-form-label-sm ">Nama Karyawan</label>
            <div class="col-sm-7">
                <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%= karyawanNama("Kry_Nama") %> " disabled>
            </div>
        <div class='row mt-3'>
            <div class='col'>
                <%if session("HM8A") = true then%>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalStatusKaryawan" onclick="return tambahStatus()">
                        Tambah
                    </button>
                <%end if%>
            </div>
        </div>
    </div>
    <div class='row contentDetail'>
        <div class='col content-table'>
            <table class="table table-striped tableDetail">
                <thead>
                    <tr>
                        <th scope="col">Tanggal Mulai</th>
                        <th scope="col">Tanggal Akhir</th>
                        <th scope="col">Status</th>
                        <%if session("HM8B") = true OR session("HM8C") = true then%>
                            <th scope="col" class="text-center">Aksi</th>
                        <%end if%>
                    </tr>
                </thead>
                <tbody>
                <% do until status.eof %>
                    <tr>
                        <td><%= status("SK_TglIn") %></td>
                        <td><%= status("SK_TglOut") %></td>
                        <td>
                            <%if status("SK_Status") = "B" then%>
                                Borongan
                            <% elseIf status("Sk_Status") = "H" then%>
                                Harian
                            <% elseIf status("Sk_Status") = "K" then%>
                                Kontrak
                            <% elseIf status("Sk_Status") = "M" then%>
                                Magang
                            <% else %>
                                Tetap
                            <% end if %>
                        </td>
                        <%if session("HM8B") = true OR session("HM8C") = true then%>
                            <td class="text-center">
                                <div class='btn-group'>
                                    <%if session("HM8B") = true then%>
                                        <button type="button" class="btn btn-primary btn-sm btn-sm py-0 px-2" data-bs-toggle="modal" data-bs-target="#modalStatusKaryawan" onclick="return updatestatus('<%=status("Sk_ID")%>', '<%=status("Sk_tglIn")%>')">
                                            Update
                                        </button>
                                    <%end if%>
                                    <%if session("HM8C") = true then%>
                                        <button type="button" class="btn btn-danger btn-sm btn-sm py-0 px-2" onclick="hapusStatus('<%=status("Sk_ID")%>', '<%=status("Sk_tglIn")%>', '<%=status("Sk_KryNip")%>')">
                                            Hapus
                                        </button>
                                    <%end if%>
                                </div>
                            </td>
                        <%end if%>
                    </tr>
                <% 
                status.movenext
                loop
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="modalStatusKaryawan" tabindex="-1" aria-labelledby="modalLabelStatus" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabelStatus">Tambah Status</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="status/tambah.asp" method="post">
            <input type='hidden' name='nip' id='nip' value="<%= p %>">
            <input type='hidden' name='id' id='id' value="">
            <div class="mb-3 row">
                <label for="tgla" class="col-sm-4 col-form-label">Tanggal Mulai</label>
                <div class="col-sm-8">
                    <input type="date" class="form-control" id="tgla" name="tgla" onfocus="return changeInp('1')" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="tgle" class="col-sm-4 col-form-label">Tanggal Akhir</label>
                <div class="col-sm-8">
                    <input type="date" class="form-control" id="tgle" name="tgle" onfocus="return changeInp('2')">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="tgle" class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-8">
                    <select class="form-select" aria-label="Default select example" id="status" name="status" required>
                        <option value="">Pilih</option>
                        <option value="B">Borongan</option>
                        <option value="H">Harian</option>
                        <option value="K">Kontrak</option>
                        <option value="M">Magang</option>
                        <option value="T">Tetap</option>
                    </select>
                </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" name="submit_status" id="submit_status">Save</button>
        </form>
      </div>
    </div>
  </div>
</div>




<!-- #include file='../layout/footer.asp' -->