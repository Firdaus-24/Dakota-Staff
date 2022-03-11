<!--#include file="../connection.asp"-->
<% 
    dim nip, i, strnip, strkey
    dim tglnow, thnnow

    nip = Request.Querystring("nip")
    'Response.Write nip
    strnip = left(nip,3)
    tglnow = right("00" & month(date()),2)
    thnnow = right(year(date),2)
    strkey = strnip & tglnow & thnnow

    'connection cuti
    set cuti_cmd = server.CreateObject("ADODB.Command")
    cuti_cmd.ActiveConnection = MM_Cargo_string

    ' tampil data taun ini
    cuti_cmd.commandText = "SELECT * FROM dbo.HRD_T_IzinCutiSakit WHERE dbo.HRD_T_IzinCutiSakit.ICS_NIP = '"& nip &"' AND Year(ICS_StartDate) = '"& year(date) &"' AND year(ICS_EndDate) = '"& year(date) &"' ORDER BY ICS_StartDate DESC"
    ' Response.Write cuti_cmd.commandText & "<br>"
    set cuti = cuti_cmd.execute

        cuti_cmd.commandText = "SELECT Kry_Nama, Kry_JmlCuti, Kry_atasanNip1, Kry_atasanNip2 FROM HRD_M_Karyawan WHERE Kry_nip = '"& nip &"'"
        set karyawan = cuti_cmd.execute

        ' sisa cuti tahun ini yang tampil di profil atas
        cuti_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS jharicuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& year(date) &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& year(date) &"' AND HRD_T_IzinCutiSakit.ICS_PotongCuti <> '' AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
        ' Response.Write cuti_cmd.commandText & "<br>"
        set saldo = cuti_cmd.execute

        jharicuti = 0
        do while not saldo.eof
            jharicuti = jharicuti + (saldo("jharicuti") + 1)
        saldo.movenext
        loop

        sisacuti = int(karyawan("Kry_JmlCuti")) - int(jharicuti)

        ' potongan gaji tahun ini
        cuti_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS pgaji FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& year(date) &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& year(date) &"' AND HRD_T_IzinCutiSakit.ICS_PotongGaji <> '' AND HRD_T_IzinCutiSakit.ICS_Potonggaji = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
        ' Response.Write cuti_cmd.commandText & "<br>"
        set saldogaji = cuti_cmd.execute

        ' total potongan gaji
        tgaji = 0
        do while not saldogaji.eof
            tgaji = tgaji + (saldogaji("pgaji") + 1)
        saldogaji.movenext
        loop


        ' saldo yang sudah diajuan tapi belm di approve
        cuti_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS notcuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& year(date) &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& year(date) &"' AND HRD_T_IzinCutiSakit.ICS_PotongCuti <> '' AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'N' AND ICS_AtasanUpperApproveYN = 'N' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC" 
        ' Response.Write cuti_cmd.commandText & "<br>"
        set najuan = cuti_cmd.execute


        ajuancuti = 0
        do while not najuan.eof
            ajuancuti = ajuancuti + (najuan("notcuti")+ 1)
        najuan.movenext
        loop
 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=`, initial-scale=1.0">
    <title>CUTI SAKIT</title>
    <!--#include file="../layout/header.asp"-->  
    <script>
    // function myfunction(sel){
    //     if (sel.options[sel.selectedIndex].text === "Cuti Bersama") {
    //         document.getElementById("pgaji").disabled = true;
    //         document.getElementById("pcuti").disabled = true;
    //     }else if (sel.options[sel.selectedIndex].text === "Dispensasi") {
    //         document.getElementById("pgaji").disabled = true;
    //         document.getElementById("pcuti").disabled = true;
    //     }else if (sel.options[sel.selectedIndex].text === "Sakit") {
    //         document.getElementById("pgaji").disabled = true;
    //         document.getElementById("pcuti").disabled = true;
    //     }else{
    //         document.getElementById("pgaji").disabled = false;
    //         document.getElementById("pcuti").disabled = false;
    //     }
    // }
    function changeinput(e){
        if (e == 1){
            $('#tgla').attr('type','date');
        }
        if (e == 2){
            $('#tgle').attr('type','date');
        }
    }
    
    function ubahStatusCuti(aktif,nip,nomor){
        Swal.fire({
            title: 'Apakah Anda Yakin?',
            text: "Data akan berubah / di nonaktifkan",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
                    window.location.href = "<%=url%>/detail-karyawan/cuti-sakit/cutiSakitIzin_updateAktif.asp?id="+aktif+"&nip="+nip+"&nomor="+nomor;
                }
            })
    }
    </script>      
    <style>
    tr:first-child{
        width: 1%;
        white-space: nowrap;
    }
    </style>
</head>
<body>
<!--#include file="../landing.asp"-->
<!--#include file="template-detail.asp"-->
<div class="container">
    <div class="row mt-2 mb-2 contentDetail">
        <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
            <div class="col-sm-2">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
            </div>
        <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
            <div class="col-sm-7">
                <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= karyawan("Kry_Nama") %> " disabled>
            </div>
        <label for="Tahun" class="col-sm-1 col-form-label col-form-label-sm mt-2">Tahun</label>
            <div class="col-sm-2 mt-2">
                <input type="text" class="form-control form-control-sm thn-cuti" name="thn-cutiSakit" id="thn-cutiSakit" autocomplete="off">
            </div>
        <label for="scuti" class="col-sm-2 col-form-label col-form-label-sm mt-2">Sisa Cuti</label>
            <div class="col-sm-2 mt-2">
                <input type="text" class="form-control form-control-sm" name="scuti3" id="scuti3" <% if sisacuti <= 0 then %> value = "0" <% else %> value="<%= sisacuti %>" <% end if %>  disabled>
            </div>
            <div class="col-sm-1 mt-2">
                <label>/Hari</label>
            </div>
        <label for="jpgaji" class="col-sm-1 col-form-label col-form-label-sm mt-2">Pot.Gaji</label>
            <div class="col-sm-2 mt-2">
                <input type="text" class="form-control form-control-sm" name="jpgaji" id="jpgaji" value="<%= tgaji %>" disabled>
            </div>
            <div class="col-sm-1 mt-2">
                <label>/Hari</label>
            </div>
        <!--button triger -->
        <div class='row'>
            <div class='col'>
                <button type="button" class="btn btn-primary mt-3 mb-2 modalTambah" data-bs-toggle="modal" data-bs-target="#formModal" id="tambahCuti" onclick="return tambahCuti()">
                    Tambah
                </button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row contentDetail">
        <div class="col content-table">
            <table class="table table-striped table-hover cari-izin" style="font-size:14px;">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Mulai</th>
                        <th scope="col">Berakhir</th>
                        <th scope="col">Status</th>
                        <th scope="col">Keterangan</th>
                        <th scope="col">Potong</th>
                        <th scope="col">Biaya Pengobatan</th>
                        <th scope="col">Aktif</th>
                        <th scope="col">Tanpa Form</th>
                        <th scope="col">Atasan 1</th>
                        <th scope="col">Atasan 2</th>
                        <th scope="col">Surat Dokter</th>
                        <th scope="col" class="text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    jumlahcuti = 0 
                    status = ""
                    aktif = ""
                    surat = ""
                    dokter = ""
                    ' sisacuti = 0
                    potgaji = 0
                    sisaklaim = 0
                    sisaklaimpotgaji = 0
                    sisaalfa = 0
                    sisaalfapotgaji = 0
                    sisaizin = 0
                    sisaizinpotgaji = 0
                    do until cuti.eof
                    'status
                    if cuti("ICS_status") = "A" then
                        status = "Alfa"
                    elseIf cuti("ICS_status") = "B" then
                        status = "Cuti Bersama"
                    elseIf cuti("ICS_status") = "C" then
                        status = "Cuti"
                    elseIf cuti("ICS_status") = "G" then
                        status = "Dispensasi"
                    elseIf cuti("ICS_status") = "I" then
                        status = "Izin"
                    elseIf cuti("ICS_status") = "K" then
                        status = "Klaim Obat"
                    elseIf cuti("ICS_status") = "S" then
                        status = "Sakit"
                    else
                        status = ""
                    end if

                    'aktif
                    if cuti("ICS_AktifYN") = "Y" then
                        aktif = "Aktif"
                    else 
                        aktif = "Tidak"
                    end if
                    'form
                    if cuti("ICS_FormYN") = "Y" then
                        surat = "Ya"
                    else
                        surat = "Tidak"
                    end if
           
                    %>
                    <tr>
                        <td><%= cuti("ICS_ID")%></td> 
                        <td><%= cuti("ICS_StartDate")%></td> 
                        <td><%= cuti("ICS_EndDate")%></td> 
                        <td><%= status %></td> 
                        <td><%= cuti("ICS_Keterangan")%></td> 
                        <td>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox3" disabled <% if cuti("ICS_potongGaji") = "Y" then %>checked <% end if %>>
                                <label class="form-check-label" for="inlineCheckbox3">Gaji</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox3" disabled <% if cuti("ICS_potongCuti") = "Y" then %>checked <% end if %>>
                                <label class="form-check-label" for="inlineCheckbox3">Cuti</label>
                            </div>
                        </td>
                        <td><%=cuti("ICS_Obat")%></td>
                        <td class="text-center"><%=aktif%></td>
                        <td class="text-center"><%=surat%></td>
                        <% 
                        if cuti("ICS_AtasanApproveYN") = "Y" then
                        %>
                            <td class="text-center">ACC</td>
                        <% else %>
                            <td class="text-center" style="color:red;">Belum ACC</td>
                        <% end if %>
                        <% 
                        if cuti("ICS_AtasanUpperApproveYN") = "Y" then
                        %>
                            <td class="text-center">ACC</td>
                        <% else %>
                            <td class="text-center" style="color:red;">Belum ACC</td>
                        <% end if %>

                        <td class="text-center">
                        <%if isNull(cuti("ICS_SuratDokterYN")) = true or len(cuti("ICS_SuratDokterYN")) < 1 then %>
                            Tidak Ada
                        <%else%>
                            <a href="../suratdokter/<%=cuti("ICS_SuratDokterYN")%>.jpg">Ya (Klik Detail)</a> 
                        <%	end if%>
			            </td>
                        <td>
                            <div class="btn-group btnNavCuti">
                                <button type="button" class="btn btn-primary btn-sm py-0 px-2 modalUbah" data-bs-toggle="modal" data-bs-target="#formModal" onclick="return modalubahcuti('<%=cuti("ICS_ID")%>','<%= cuti("ICS_Nip") %>')">
                                    Edit
                                </button>
                                <% 
                                dim aktif
                                aktif = cuti("ICS_AktifYN")
                                nomor = cuti("ICS_ID")
                                if aktif = "Y" then
                                %>
                                    <button type="button" class="btn btn-warning btn-sm py-0 px-2" onclick="return ubahStatusCuti('<%=aktif%>','<%=nip%>','<%=nomor%>')">
                                        aktif
                                    </button>
                                <% 
                                else 
                                %>
                                    <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return ubahStatusCuti('<%=aktif%>','<%=nip%>','<%=nomor%>')">
                                        NoAktif
                                    </button>
                                <% end if %>
                                <button type="button" class="btn btn-info btn-sm" onclick="window.location.href='cuti-sakit/suratdokter.asp?nip=<%= nip %>&id=<%= cuti("ICS_ID")%>'"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                            </div>
                        
                        </td>
                    </tr> 
                    <% 
                
                    cuti.movenext
                    loop
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="formModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="formModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="formModalLabel">Tambah Data Izin Cuti dan Alfa</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="#" method="post" id="form-cuti" onsubmit="return validasicuti()">
            <div class="mb-3 row">
                <input type="hidden" class="form-control " name="ajuancuti" id="ajuancuti" value="<%= ajuancuti %>">
                <input type="hidden" class="form-control " name="sisacuti" id="sisacuti" value="<%= sisacuti %>">
                <input type="hidden" class="form-control " name="cutimaster" id="cutimaster" value="<%= karyawan("Kry_JmlCuti") %>">
                <label for="nomor" class="col-sm-4 col-form-label">Nomor</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" name="nomor" id="nomor" disabled>
                    <input type="hidden" class="form-control" name="nomorID" id="nomorID">
                    <input type="hidden" class="form-control" name="key" id="key" value="<%=strkey%> ">
                    <input type="hidden" class="form-control" name="nip" id="nip" value="<%= nip %> ">
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="tgla" class="col-sm-4 col-form-label">Tgl Dari</label>
                <div class="col-sm-5">
                    <input type="date" class="form-control" name="tgla" id="tgla" onfocus="return changeinput('1')" required>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="tgle" class="col-sm-4 col-form-label">Tgl Sampai</label>
                <div class="col-sm-5">
                    <input type="date" class="form-control" name="tgle" id="tgle" onfocus="return changeinput('2')" required>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="status" class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-5">
                    <select class="form-select form-select-sm" aria-label=".form-select-lg example" name="status" id="status" required>
                        <option value="">Pilih</option>
                        <option value="A">Alpa</option>
                        <option value="B">Cuti Bersama</option>
                        <option value="C">Cuti</option>
                        <option value="G">Dispensasi</option>
                        <option value="I">Izin</option>
                        <option value="K">Klaim Obat</option>
                        <option value="S">Sakit</option>
                    </select>   
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="pcuti" class="col-sm-4 col-form-label">Potongan Cuti</label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline cuti">     
                        <% if Cint(karyawan("Kry_JmlCuti")) = 0 then %>
                            <input class="form-check-input" type="checkbox" name="pcuti" id="pcuti" value="Y" disabled>
                        <% else %> 
                            <input class="form-check-input" type="checkbox" name="pcuti" id="pcuti" value="Y"> 
                        <% end if %>
                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="pgaji" class="col-sm-4 col-form-label">Potongan Gaji</label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline gaji">
                        <input class="form-check-input" type="checkbox" name="pgaji" id="pgaji">
                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="sform" class="col-sm-4 col-form-label">Form</label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline gaji">
                        <input class="form-check-input" type="checkbox" name="sform" id="sform">
                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="ket" class="col-sm-4 col-form-label">Keterangan</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" name="ket" id="ket" autocomplete="off" placeholder="keterangan" required>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="atasan" class="col-sm-4 col-form-label">Atasan Pertama</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" name="atasan" id="atasan" <% if not karyawan.eof then %> value="<%= karyawan("Kry_atasanNip1") %>" <% else %> value="" <% end if %> autocomplete="off" onkeyup="return cariAtasan1(this.value)">

                    <!--set tampil atasan 1-->
                    <img src="../loader/newloader.gif" id="loader" style="width:70px;margin-left:10px;display:none;">
                    <div class='tampilAtasan1'  style="overflow-x:scroll;">

                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label">Approve Pertama</label>
                <div class='col'>
                    <div class="form-check form-check-inline approvePertama">
                        <input class="form-check-input" type="radio" name="atasanApproveYN" id="yes" value="Y">
                        <label class="form-check-label" for="yes">Yes</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="atasanApproveYN" id="no" value="N">
                        <label class="form-check-label" for="no">No</label>
                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="atasanUpper" class="col-sm-4 col-form-label">Atasan Kedua</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" name="atasanUpper" id="atasanUpper" placeholder="nip atasan kedua" autocomplete="off"  <% if not karyawan.eof then %> value="<%= karyawan("Kry_atasanNip2") %>" <% else %> value="" <% end if %> onkeyup="return cariAtasan2(this.value)">
                     <!--set tampil atasan 2-->
                    <img src="../loader/newloader.gif" id="loader1" style="width:70px;margin-left:10px;display:none;">
                    <div class='tampilAtasan2'  style="overflow-x:scroll;">

                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label">Approve Kedua</label>
                <div class='col'>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="atasanUpperApproveYN" id="yes2" value="Y">
                        <label class="form-check-label" for="yes2">Yes</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="atasanUpperApproveYN" id="no2" value="N">
                        <label class="form-check-label" for="no2">No</label>
                    </div>
                </div>
            </div>        
            <div class="mb-3 row">
                <label for="bpengobatan" class="col-sm-4 col-form-label">Biaya Pengobatan</label>
                <div class="col-sm-8">
                    <input type="number" class="form-control" name="bpengobatan" id="bpengobatan" required>
                </div>
            </div>               
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" name="submit"  id="submit" class="btn btn-primary btnModal">Save</button>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
    let tgllama;
    let tglbaru;
    let atasan;
    let atasan2;
    function tambahCuti() {
            // ubah tampilan
            $('.modal-body form').attr('action', '<%=url%>/detail-karyawan/cuti-sakit/cutiSakitIzin_add.asp');
            $('#formModalLabel').html('Tambah Data Izin Cuti dan Alfa');
            $('.btnModal').html('Save');
            $('#nomor').val('');
            $('#tgla').val('');
            $('#tgla').attr('type','date');
            $('#tgle').val('');
            $('#tgle').attr('type','date');
            $('#status').val("");
            $('#ket').val('');
            $('#yes').prop("checked", false);
            $('#no').prop("checked", false);
            $('#yes2').prop("checked", false);
            $('#no2').prop("checked", false);
            $('#bpengobatan').val('');
            $('#pcuti').prop("checked", false);
            $('#pgaji').prop("checked", false);
            $('#sform').prop("checked", false);
            this.tgllama = 0;
            this.tglbaru = 0;
            this.atasan = $("#atasan").val();
            this.atasan2 = $("#atasanUpper").val();
    }
    function modalubahcuti(id, nip){
        $('#tgla').attr('type', 'text');
        $('#tgle').attr('type', 'text');
        $.ajax({
            url: '<%=url%>/detail-karyawan/cuti-sakit/cutiSakitIzin_update.asp',
            data: { id: id, nip : nip },
            method: 'post',
            success: function (data) {
                function splitString(strToSplit, separator) {
                var arry = strToSplit.split(separator);
                $('#nomor').val(arry[0]);
                $('#nomorID').val(arry[0]);
                // make function onchange
                $('#status option[value=' + arry[3] + ']').prop("selected", true);
                $('#ket').val(arry[4]);
                $('#bpengobatan').val(arry[6]);
                    
                    if (arry[7] == "Y") {
                        $('#pcuti').prop('checked', true);
                    } else {
                        $('#pcuti').prop('checked', false);
                    }
                    if (arry[8] == "Y") {
                        $('#pgaji').prop('checked', true);
                    } else {
                        $('#pgaji').prop('checked', false);
                    }
                    $('#tgla').val(arry[1]);
                    $('#tgle').val(arry[2]);
                    
                    // if ($("#atasan").val() == ""){
                    //     $('#atasan').val(arry[5]);
                    // }
                    // if ($("#atasanUpper").val() == ""){
                    //     $('#atasanUpper').val(arry[12]);
                    // }
                        this.tgllama = arry[1];
                        this.tglbaru = arry[2];
                        this.atasan = $("#atasan").val();
                        this.atasan2 = $("#atasanUpper").val();

                    if (arry[10] == "Y") {
                        $('#sform').prop('checked', true);
                    } else {
                        $('#sform').prop('checked', false);
                    }

                    // set value approve atasan
                    if (arry[11] == "Y"){
                        $("#yes").prop("checked", true);
                        $("#no").prop("checked", false);
                    }else{
                        $("#yes").prop("checked", false);
                        $("#no").prop("checked", true);
                    }
                    if (arry[13] == "Y"){
                        $("#yes2").prop("checked", true);
                        $("#no2").prop("checked", false);
                    }else{
                        $("#yes2").prop("checked", false);
                        $("#no2").prop("checked", true);
                    }
                }

                const koma = ",";
                splitString(data, koma);
            }
        });
        $('#formModalLabel').html('Ubah Data Izin Cuti dan Alfa');
        $('.btnModal').html('Update');
        $('.modal-body form').attr('action', '<%=url%>/detail-karyawan/cuti-sakit/cutiSakitIzin_update_add.asp');
    }
    function validasicuti() {
         // cek data tgl hari ini
        let today = new Date();
        // setting variable untuk cuti
        const ajuancuti = Number($("#ajuancuti").val());
        const saldocuti = Number($("#sisacuti").val());
        const ket = $("#ket").val().length;
        const atasan = $("#atasan").val().length;
        const atasanUpper = $("#atasanUpper").val().length;

        const date1 = new Date($("#tgla").val());
        const date2 = new Date($("#tgle").val());
        const diffTime = Math.abs(date2 - date1);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; 
        let totalajuan

        // cek tanggal lama jika di update 
        if (this.tgllama == 0 || this.tglbaru == 0 ){
            totalajuan = ajuancuti + diffDays;
        }else{
            let tgla = new Date(this.tgllama)
            let tgle = new Date(this.tglbaru)
            let diffTime1 = Math.abs(tgla - tgle);  
            let diffDaysLast = Math.ceil(diffTime1 / (1000 * 60 * 60 * 24)) + 1;
            let mindiffDays = diffDays - 1;
            totalajuan = (ajuancuti - diffDaysLast) + mindiffDays;
        }  
       
        if ( $("#cutimaster").val() != 0 ){

            if ( date1.getTime() > date2.getTime() ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'BULAN KEDUA ANDA SALAH PILIH',
                });
                return false;
            }else if (saldocuti == 0 ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'SALDO CUTI ANDA HABIS!!',
                });
                return false;
            }else if ( totalajuan > saldocuti ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Pengajuan Cuti Melebihi Batas!',
                });
                return false;
            }else if ( diffDays > saldocuti ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'SALDO CUTI ANDA TIDAK CUKUP!!',
                });
                return false;
            }else if ( ket > 50 ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'MAXIMAL KETERANGAN 50 CHARAKTER',
                });
                return false;
            }else{
                if (confirm("DATA YANG ANDA ISI SUDAH BENAR ???") == true ){
                    return true;
                }else{
                    return false;
                }
            }
        }else{
            let formInput = $("#form-cuti").serialize();
            let url = $("#form-cuti").attr('action');

            const value = formInput;
            const newValue = value.split("&");
            let postData = {};

            for(let x = 0; x < newValue.length; x++){
                const key = newValue[x].split("=")[0];
                const value = newValue[x].split("=")[1];
                const newData = `${key}: ${value}`;
                postData = {...postData, [key]: value}
            }

            let nomor = postData.nomorID;
            let nip = postData.nip.replace("%20","");
            let key = postData.key.replace("%20","");
            let tgla = postData.tgla.replaceAll("%2F","/");
            let tgle = postData.tgle.replaceAll("%2F","/");
            let status = postData.status;
            let atasan = postData.atasan;
            let atasanApproveYN = postData.atasanApproveYN;
            let atasanUpper = postData.atasanUpper;
            let atasanUpperApproveYN = postData.atasanUpperApproveYN;
            let pgaji = postData.pgaji;
            let sform = postData.sform;
            let ket = postData.ket.replace(/%20/g, " ");
            let bpengobatan = postData.bpengobatan;

            if ( date1.getTime() > date2.getTime() ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'BULAN KEDUA ANDA SALAH PILIH',
                });
                return false;
            }else if ( ket > 50 ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'MAXIMAL KETERANGAN 50 CHARAKTER',
                });
                return false;
            }else{
                Swal.fire({
                title: 'Anda Yakin?',
                text: "Pastikan Semua data sudah benar!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Submit'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.post(url,
                        {
                            nomorID:nomor,
                            key:key, 
                            nip:nip, 
                            tgla:tgla, 
                            tgle:tgle, 
                            status:status, 
                            pgaji:pgaji, 
                            sform:sform, 
                            ket:ket, 
                            atasan:atasan, 
                            atasanApproveYN:atasanApproveYN,
                            atasanUpper:atasanUpper, 
                            atasanUpperApproveYN:atasanUpperApproveYN, 
                            bpengobatan:bpengobatan 
                        },
                        function(data,status){
                            location.reload();
                        });
                    }
                });
            }

        }
    return false;
        
    }
    function cariAtasan1(e){
        $("#loader").show();
        if(this.atasan == ""){
            let minlength = 3;
            // regex cak angka apa huruf
            let value = e;
            let regexHrf = /^[a-zA-Z]+$/.test(value);
            let regexNum = /^[0-9]*$/.test(value);
            // var that = this;
            const nip = (regexNum == true) ? value : "";
            const nama = (regexHrf == true) ? value : "";

            if (nama != ""){
                if (nama.length >= minlength ) {
                    $.ajax({
                        type: "post",
                    url: "cuti-sakit/cari-atasan.asp",
                    data: { nip : nip, nama: nama},
                    dataType: "text",
                        success: function(msg){
                            $(".tampilAtasan1").html(msg);
                            $("#loader").hide();
                        }
                    });
                }
            }else{
                if (nip.length >= 10 ) {
                    $.ajax({
                    type: "post",
                    url: "cuti-sakit/cari-atasan.asp",
                    data: { nip : nip, nama: nama},
                    dataType: "text",
                        success: function(msg){
                            $(".tampilAtasan1").html(msg);
                            $("#loader").hide();
                        }
                    });
                }
            }
        }else{
            $("#loader").hide();
            Swal.fire('Pastikan Tidak Merubah Approve Atasan');
        }
        
     
    }
    function cariAtasan2(e){
        $("#loader1").show();
        let minlength = 3;
            // regex cak angka apa huruf
            let value = e;
            let regexHrf = /^[a-zA-Z]+$/.test(value);
            let regexNum = /^[0-9]*$/.test(value);
            // var that = this;
            const nip = (regexNum == true) ? value : "";
            const nama = (regexHrf == true) ? value : "";

            if (nama != ""){
                if (nama.length >= minlength ) {
                    $.ajax({
                        type: "post",
                    url: "cuti-sakit/cari-atasan.asp",
                    data: { nip1 : nip, nama1: nama},
                    dataType: "text",
                        success: function(msg){
                            $(".tampilAtasan2").html(msg);
                            $("#loader1").hide();
                        }
                    });
                }
            }else{
                if (nip.length >= 10 ) {
                    $.ajax({
                    type: "post",
                    url: "cuti-sakit/cari-atasan.asp",
                    data: { nip1 : nip, nama1: nama},
                    dataType: "text",
                        success: function(msg){
                            $(".tampilAtasan2").html(msg);
                            $("#loader1").hide();
                        }
                    });
                }
            }
    }
</script>
<!--#include file="../layout/footer.asp"-->
   