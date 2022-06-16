<!-- #include file='../connection.asp' -->
<% 
    if session("HL5")= "" then 
        if  session("HL5B")= "" then
            response.redirect("../dashboard.asp")
        end if
    end if 
    'untuk notiv pencarian berdasarkan nama
    id = Request.QueryString("id")

    set mutasi = Server.CreateObject("ADODB.Command")
    mutasi.ActiveConnection = MM_cargo_STRING

    mutasi.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_Karyawan.Kry_Nama FROM HRD_T_Mutasi LEFT OUTER JOIN HRD_M_karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_Mutasi.Mut_ID = '"& id &"'"

    set update  = mutasi.execute
    
    ' set jablama
    mutasi.commandText = "SELECT Jab_Nama, Jab_code FROM HRD_M_Jabatan WHERE jab_code = '"& update("Mut_AsalJabCode") &"'"
    set asaljab = mutasi.execute
    ' set divlama
    mutasi.commandText = "SELECT div_Nama,div_Code FROM HRD_M_divisi WHERE div_Code = '"& update("Mut_AsalDDBID") &"'"
    set asaldiv = mutasi.execute
    ' set jenjanglama
    mutasi.commandText = "SELECT JJ_Nama,JJ_ID FROM HRD_M_Jenjang WHERE JJ_ID = '"& update("Mut_AsalJJID") &"'"
    set asalJJ = mutasi.execute
    ' set agenlama
    mutasi.commandText = "SELECT AGen_Nama,AGen_ID FROM GLB_M_Agen WHERE AGen_ID = '"& update("Mut_AsalAgenID") &"'"
    set asalAgen = mutasi.execute

    ' set jabbaru
    mutasi.commandText = "SELECT Jab_Nama,Jab_code FROM HRD_M_Jabatan WHERE jab_code = '"& update("Mut_TujJabCode") &"'"

    set njab = mutasi.execute
    ' set divbaru
    mutasi.commandText = "SELECT div_Nama,div_Code FROM HRD_M_divisi WHERE div_Code = '"& update("Mut_TujDDBID") &"'"
    set ndiv = mutasi.execute
    ' set jenjangbaru
    mutasi.commandText = "SELECT JJ_Nama,JJ_ID FROM HRD_M_Jenjang WHERE JJ_ID = '"& update("Mut_TujJJID") &"'"
    set njj = mutasi.execute
    ' set agenbaru
    mutasi.commandText = "SELECT AGen_Nama,AGen_ID FROM GLB_M_Agen WHERE AGen_ID = '"& update("Mut_TujAgenID") &"'"
    set nagen = mutasi.execute


    mutasi.commandText = "SELECT Jab_Nama,Jab_code FROM HRD_M_Jabatan WHERE (ISNULL(Jab_Code, '') <>'') AND Jab_AktifYN = 'Y' ORDER BY Jab_Nama ASC"
    set jabatan = mutasi.execute

    mutasi.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE (ISNULL(JJ_ID, '') <>'') AND JJ_AktifYN = 'Y' ORDER BY JJ_Nama ASC"
    set jenjang = mutasi.execute

    mutasi.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Divisi WHERE (ISNULL(Div_Code, '') <>'') AND Div_AktifYN = 'Y' ORDER BY Div_Nama ASC"
    set divisi = mutasi.execute

    mutasi.commandText = "SELECT Agen_ID, Agen_Nama FROM GLB_M_Agen WHERE (ISNULL(Agen_ID, '') <>'') AND Agen_AktifYN = 'Y' ORDER BY Agen_Nama ASC"
    set agen = mutasi.execute
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FORM</title>
    <!-- #include file='../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <script>
        function validateRadio (radios)
            {
                for (i = 0; i < radios.length; ++ i)
                {
                    if (radios [i].checked) return true;
                }
                return false;
            }
        function validateForm(){
            let nomor = $("#nomor").val();
            let catatan = $("#catatan").val();
            if (nomor.length > 20){
                Swal.fire(
                    'WARNING!!',
                    'Maximal Nomor 20 charakter',
                    'warning'
                );
                return false;
            }
            if (catatan.length > 50 ){
                Swal.fire(
                    'WARNING',
                    'Maximal Catatan 50 charakter',
                    'warning'
                );
                return false;
            }
            //cek tombol radio yang di pilih
        if(validateRadio (document.forms["formStatus"]["radioStatus"]))
            {
                return true;
            }else{
                Swal.fire(
                    'WARNING',
                    'Pilih Salah Satu Perubahan',
                    'warning'
                );
                return false;
            }
        }
    </script>
    <style>
        .openName{
            display:none;
            font-size:12px;
            max-height:17rem;
            overflow:scroll;
        }
        .table{
            margin:0;
            padding:0;
        }
    </style>
</head>
<body>
<div class='container'>
    <div class='row text-center mt-3'>
        <div class='col'>
            <h3>UPDATE PENGAJUAN PERUBAHAN STATUS KARYAWAN</h3>
        </div>
    </div>  
    <div class='row mt-3'>
        <div class='col'>
            <form class="row" name="formStatus" action="update.asp" method="post" onsubmit="return validateForm()">
                <input type='hidden' class='form-control' name='key' id='key' value="<%= update("Mut_ID") %>">
                <div class="mb-3 row">
                    <label for="tgl" class="col-sm-2 col-form-label">Tanggal Pengajuan</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="tgl" name="tgl" value="<%= update("Mut_Tanggal") %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="nomor" class="col-sm-2 col-form-label">Nomor</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="nomor" name="nomor"  autocomplete="off" value="<%= update("Mut_NoSurat") %>" readonly>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="nama" class="col-sm-2 col-form-label">Nama</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="nama" name="nama" autocomplete="off" value="<%= update("Kry_Nama") %>" readonly required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="nip" class="col-sm-2 col-form-label">Nip</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="nip" name="nip" value="<%= update("Mut_nip") %>" readonly required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class='col-sm-2'>
                        <label>Pilih Perubahan</label>
                    </div>
                    <div class='col'>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="radioStatus" id="mutasi" value="" <% if update("Mut_Status") = 0 OR update("Mut_Status") = "" then %>checked <% end if %>>
                            <label class="form-check-label" for="mutasi">Mutasi</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="radioStatus" id="demosi" value="1" <% if update("Mut_Status") = 1 then %>checked <% end if %>>
                            <label class="form-check-label" for="demosi">Demosi</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="radioStatus" id="rotasi" value="2" <% if update("Mut_Status") = 2 then %>checked <% end if %>>
                            <label class="form-check-label" for="rotasi">Rotasi</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="radioStatus" id="promorsi" value="3" <% if update("Mut_Status") = 3 then %>checked <% end if %>>
                            <label class="form-check-label" for="promorsi">Promorsi</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="radioStatus" id="pensiun" value="4" <% if update("Mut_Status") = 4 then %>checked <% end if %>>
                            <label class="form-check-label" for="pensiun">Pensiun</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="radioStatus" id="keluar" value="5">
                            <label class="form-check-label" for="keluar">Keluar Tanpa Kabar</label>
                        </div>
                    </div>
                </div>
                <!--deskripsi status karyawan -->
                <div class='row mb-3 text-center'>
                    <label for="nip" class="col col-form-label">PERUBAHAN KARYAWAN</label>
                </div>
                <div class="mb-3 row">
                    <label for="jablama" class="col-sm-2 col-form-label">Jabatan Lama</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="labeljab" name="labeljab" value="<%= asaljab("Jab_Nama") %>" readonly>
                        <input type="hidden" class="form-control" id="jablama" name="jablama" value="<%= asaljab("Jab_Code") %>" readonly>
                    </div>
                    <label for="jabatan" class="col-sm-2 col-form-label">Jabatan Baru</label>
                    <div class="col-sm-4">
                        <select class="form-select" aria-label="Default select example" id="jabatan" name="jabatan" required>
                            <option value="<%= njab("Jab_Code") %>"><%= njab("Jab_nama") %></option>
                            <% do until jabatan.eof %>
                            <option value="<%= jabatan("Jab_Code") %>"><%= jabatan("Jab_Nama") %></option>
                            <% 
                            jabatan.movenext
                            loop
                            %>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="jjlama" class="col-sm-2 col-form-label">Jenjang Lama</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="labeljj" name="labeljj" value="<%= asaljj("JJ_nama") %>" readonly>
                        <input type="hidden" class="form-control" id="jjlama" name="jjlama" value="<%= asaljj("JJ_ID") %>" readonly>
                    </div>
                    <label for="jenjang" class="col-sm-2 col-form-label">Jenjang Baru</label>
                    <div class="col-sm-4">
                        <select class="form-select" aria-label="Default select example" id="jenjang" name="jenjang" required>
                            <option value="<%= njj("JJ_ID") %>"><%= njj("JJ_Nama") %></option>
                            <% do until jenjang.eof %>
                            <option value="<%= jenjang("JJ_ID") %>"><%= jenjang("JJ_Nama") %></option>
                            <% 
                            jenjang.movenext
                            loop
                            %>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="divlama" class="col-sm-2 col-form-label">Divisi Lama</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="labeldiv" name="labeldiv" value="<%= asaldiv("Div_Nama") %>" readonly>
                        <input type="hidden" class="form-control" id="divlama" name="divlama" value="<%= asaldiv("Div_Code") %>" readonly>
                    </div>
                    <label for="divisi" class="col-sm-2 col-form-label">Divisi Baru</label>
                    <div class="col-sm-4">
                        <select class="form-select" aria-label="Default select example" id="divisi" name="divisi" required>
                            <option value="<%= ndiv("Div_Code") %>"><%= ndiv("Div_Nama") %></option>
                            <% do until divisi.eof %>
                            <option value="<%= divisi("Div_Code") %>"><%= divisi("DIv_nama") %></option>
                            <% 
                            divisi.movenext
                            loop
                            %>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="agenlama" class="col-sm-2 col-form-label">Area Lama</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="labelAgen" name="labelAgen" value="<%= asalagen("Agen_Nama") %>" readonly>
                        <input type="hidden" class="form-control" id="agenlama" name="agenlama" value="<%= asalagen("agen_ID") %>" readonly>
                    </div>
                    <label for="agen" class="col-sm-2 col-form-label">Area Baru</label>
                    <div class="col-sm-4">
                        <select class="form-select" aria-label="Default select example" id="agen" name="agen" required>
                            <option value="<%= nagen("Agen_ID") %>"><%= nagen("Agen_Nama") %></option>
                            <% do until agen.eof %>
                            <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                            <% 
                            agen.movenext
                            loop
                            %>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="agenlama" class="col-sm-2 col-form-label">Penggajian Di-</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="labelAgen" name="labelAgen" value="<%= asalagen("Agen_Nama") %>" readonly>
                    </div>
                </div>
                <!--end deskripsi -->

                <div class='mb-3 row'>
                    <label for="nip" class="col-sm-2 col-form-label">Catatan/Memo</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="catatan" name="catatan" rows="3" required><%= update("Mut_Memo") %></textarea>
                    </div>
                </div> 
                <div class='row mb-3 '>
                    <div class='col text-center'>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
$( "#tgl" ).focus(function() {
    $("#tgl").attr('type','date');
});
</script>
<!-- #include file='../layout/footer.asp' -->