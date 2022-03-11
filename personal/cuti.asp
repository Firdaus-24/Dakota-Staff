<!-- #include file="../connection_personal.asp"-->
<% 
    nip = Request.QueryString("nip")
    strnip = Request.QueryString("nip")

    strnip = left(nip,3)
    tglnow = right("00" & month(date()),2)
    thnnow = right(year(date),2)
    strkey = strnip & tglnow & thnnow

    set cuti_cmd = Server.CreateObject("ADODB.Command")
    cuti_cmd.activeConnection = MM_Cargo_string

    cuti_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS jharicuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& year(date) &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& year(date) &"' AND HRD_T_IzinCutiSakit.ICS_PotongCuti <> '' AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC" 
    ' Response.Write cuti_cmd.commandText & "<br>"
    set cuti = cuti_cmd.execute

    cuti_cmd.commandText = "SELECT Kry_JmlCuti, Kry_atasanNip1, Kry_atasanNip2 FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
    set karyawan = cuti_cmd.execute

    ' cek atasan karyawan   
        if karyawan.eof then    
            atasan1 = ""
            atasan2 = ""
        else    
            atasan1 = karyawan("Kry_atasanNip1")
            atasan2 = karyawan("Kry_atasanNip2")
        end if


    jharicuti = 0
    do while not cuti.eof
        jharicuti = jharicuti + (cuti("jharicuti") + 1)
    cuti.movenext
    loop

    sisacuti = int(karyawan("Kry_JmlCuti")) - int(jharicuti)
    ' table data ajuan cuti
    cuti_cmd.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_Nip = '"& nip &"' AND year(ICS_Startdate) = '"& year(date) &"' AND year(ICS_EndDate) = '"& year(date) &"' AND ICS_AktifYN = 'Y' ORDER BY ICS_StartDate, ics_EndDate DESC"
    ' Response.Write cuti_cmd.commandText & "<br>"
    set Nsaldo = cuti_cmd.execute

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PENGAJUAN CUTI</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="style.css">    
</head>
    
<body>

<div id="myNav" class="overlay">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <form action="pcuti.asp" method="post" id="form-cuti" >
        <div class="overlay-content" style="display:inline-block;">
            <h3>FORM PENGAJUAN CUTI</h3>
            <div class='text-light info-sisa'>
                <span>SALDO CUTI</span><br>
                <h3><%= sisacuti %></h3>
            </div>
            
        </div>
            <div class="col-sm-5 input">
                <input type="hidden" class="form-control ml-1" name="jmlcuti" id="jmlcuti" value="<%= karyawan("Kry_JmlCuti") %>">
                <input type="hidden" class="form-control " name="sisacuti" id="sisacuti" value="<%= sisacuti %>">
                <input type="hidden" class="form-control " name="ajuancuti" id="ajuancuti" value="<%= ajuancuti %>">
                <input type="hidden" class="form-control" name="key" id="key" value="<%= strkey %> ">
                <input type="hidden" class="form-control" name="nip" id="nip" value="<%= nip %> ">
                <input type="hidden" class="form-control ml-1" name="nomor" id="nomor" >
            </div>
            <div class="mb-3 row overlay-content">
                <label for="tgla" class="col-sm-3 col-form-label">Tgl Dari</label>
                <div class="col-sm-5 input">
                    <input type="date" class="form-control" name="tgla" id="tgla" onfocus="return changeinput('1')" required>
                </div>
            </div>        
            <div class="mb-3 row overlay-content">
                <label for="tgle" class="col-sm-3 col-form-label">Tgl Sampai</label>
                <div class="col-sm-5">
                    <input type="date" class="form-control" name="tgle" id="tgle" onfocus="return changeinput('2')"required>
                </div>
            </div> 
            <div class="mb-3 row overlay-content">
                    <label for="Status" class="col-sm-3 col-form-label">Status</label>
                    <div class="col-sm-3">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="cuti" value="C" <% if karyawan("Kry_Jmlcuti") = 0 then %> disabled <% end if %> required>
                            <label class="form-check-label" for="cuti" >Cuti</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="izin" value="I">
                            <label class="form-check-label" for="izin">Izin</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="sakit" value="S">
                            <label class="form-check-label" for="sakit">Sakit</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="alfa" value="A">
                            <label class="form-check-label" for="alfa">Alfa</label>
                        </div>
                    </div>
                </div>       
            <div class="mb-3 row overlay-content">
                <label for="ket" class="col-sm-3 col-form-label">Keterangan</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" name="ket" id="ket" autocomplete="off" placeholder="keterangan" maxlength="50" required>
                </div>
            </div>        
            <div class="mb-3 row overlay-content">
                <label for="atasan" class="col-sm-3 col-form-label">NIP Atasan Pertama</label>
                <% if karyawan("Kry_atasanNip1") <> "" then %>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="atasan" id="atasan" value="<%= karyawan("Kry_atasanNip1") %>" readonly >
                    </div>
                <% else %>
                    <div class="col-sm-8">
                        <select class="form-select form-control" aria-label="Default select example" name="atasan" id="atasan" required> 
                            <option value="">Pilih</option>
                            <option value="Bp.Matri">Bpk. Mantri</option>
                            <option value="Ibu.Lis">Ibu. Lis</option>
                            <option value="Bp.Deni">Bpk. Deni</option>
                            <option value="Bp.Wawan">Bpk. Wawan</option>
                            <option value="Bp.Purwanto">Bpk. Purwanto</option>
                            <option value="Ibu.Ketut">Ibu Ketut</option>
                        </select>
                    </div>
                <% end if %>
            </div>        
            <div class="mb-3 row overlay-content">
                <label for="atasanUpper" class="col-sm-3 col-form-label">NIP Atasan Kedua</label>
                <% if atasan2 <> "" then %>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="atasanUpper" id="atasanUpper"  value="<%= atasan2 %>" autocomplete="off" readonly>
                    </div>
                <% else %>
                    <div class="col-sm-8">
                        <select class="form-select form-control" aria-label="Default select example" name="atasanUpper" id="atasanUpper" required> 
                            <option value="">Pilih</option>
                            <option value="Bp.Matri">Bpk. Mantri</option>
                            <option value="Ibu.Lis">Ibu. Lis</option>
                            <option value="Bp.Deni">Bpk. Deni</option>
                            <option value="Bp.Wawan">Bpk. Wawan</option>
                            <option value="Bp.Purwanto">Bpk. Purwanto</option>
                            <option value="Ibu.Ketut">Ibu Ketut</option>
                        </select>
                    </div>
                <% end if %>
            </div>        
            <div class="modal-footer">
                <button type="submit" name="submit"  id="submit" class="btn btn-primary btnModal" onclick="return validasicuti()">Save</button>
            </div>
    </form>    
</div>

<div class='container mt-3'>
    <% if Nsaldo.eof then%>
    <a href="index.asp">
        <div class='row text-center one'>
            <div class='col-lg two'>
                <h5>HISTORY CUTI BELUM TERDAFTAR</h5>
            </div>
        </div>
    </a>
    <% else %>
    <div class='row text-center mt-2'>
        <div class='col'>
            <h4>DAFTAR CUTI YANG DI AJUKAN</h4>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Mulai</th>
                        <th scope="col">Berakhir</th>
                        <th scope="col">Status</th>
                        <th scope="col">Keterangan</th>
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
                        do until Nsaldo.eof
                        'status
                        if Nsaldo("ICS_status") = "A" then
                            status = "Alfa"
                        elseIf Nsaldo("ICS_status") = "B" then
                            status = "Cuti Bersama"
                        elseIf Nsaldo("ICS_status") = "C" then
                            status = "Cuti"
                        elseIf Nsaldo("ICS_status") = "G" then
                            status = "Dispensasi"
                        elseIf Nsaldo("ICS_status") = "I" then
                            status = "Izin"
                        elseIf Nsaldo("ICS_status") = "K" then
                            status = "Klaim Obat"
                        elseIf Nsaldo("ICS_status") = "S" then
                            status = "Sakit"
                        else
                            status = ""
                        end if

                        'aktif
                        if Nsaldo("ICS_AktifYN") = "Y" then
                            aktif = "Aktif"
                        else 
                            aktif = "Tidak"
                        end if
                        'form
                        if Nsaldo("ICS_FormYN") = "Y" then
                            surat = "Ya"
                        else
                            surat = "Tidak"
                        end if
                    %>
                    <tr>
                        <td><%= Nsaldo("ICS_ID")%></td> 
                        <td><%= Nsaldo("ICS_StartDate")%></td> 
                        <td><%= Nsaldo("ICS_EndDate")%></td> 
                        <td><%= status %></td> 
                        <td><%= Nsaldo("ICS_Keterangan")%></td> 
                        <td><%=Nsaldo("ICS_Obat")%></td>
                        <td class="text-center"><%=aktif%></td>
                        <td class="text-center"><%=surat%></td>
                        <% 
                        if Nsaldo("ICS_AtasanApproveYN") = "Y" then
                        %>
                            <td class="text-center">ACC</td>
                        <% else %>
                            <td class="text-center" style="color:red;">Belum ACC</td>
                        <% end if %>
                        <% 
                        if Nsaldo("ICS_AtasanUpperApproveYN") = "Y" then
                        %>
                            <td class="text-center">ACC</td>
                        <% else %>
                            <td class="text-center" style="color:red;">Belum ACC</td>
                        <% end if %>
                        <td class="text-center">
                        <%if isNull(Nsaldo("ICS_SuratDokterYN")) = true or len(Nsaldo("ICS_SuratDokterYN")) < 1 then %>
                            Tidak Ada
                        <%else%>
                            <a href="../suratdokter/<%=Nsaldo("ICS_SuratDokterYN")%>.jpg">Ya (Klik Detail)</a> 
                        <%	end if%>
                        
			            </td>
                        <td>
                            <% if Nsaldo("ICS_AtasanUpperApproveYN") = "Y" OR Nsaldo("ICS_AtasanApproveYN") = "Y" then %>
                            <% else %>
                            <div class="btn-group btnNavCuti">
                                <button type="button" class="btn btn-outline-primary btn-sm py-0 px-2" onclick="return openNav('<%=Nsaldo("ICS_ID")%>','<%= Nsaldo("ICS_Nip") %>','<%= Nsaldo("ICS_StartDate") %>','<%= Nsaldo("ICS_EndDate") %>','<%= Nsaldo("ICS_Keterangan") %>','<%= Nsaldo("ICS_Atasan") %>','<%= Nsaldo("ICS_AtasanUpper") %>','<%= Nsaldo("ICS_Obat") %>','<%= Nsaldo("ICS_Status") %>')">
                                    Edit
                                </button>
                            </div>
                            <% end if %>
                        </td>
                    </tr> 
                    <% 
                
                    Nsaldo.movenext
                    loop
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <% end if %>
    <div class='row'>
        <div class='col'>
            <div class="btn-group" role="group" aria-label="Basic example">
                <button type="button" class="btn btn-outline-primary btn-sm" onclick="window.location.href='index.asp'">kembali</button>
                <button type="button" class="btn btn-outline-primary btn-sm" onclick="openNav()">Ajukan Cuti</button>
            </div>
        </div>
    </div>
    <% if karyawan("Kry_JmlCuti") <> 0 then%>
    <div class='row mt-3'>
        <div class='col' >
            <ul style="list-style:none;padding:0;font-size:14px;">
                <li>
                    SALDO CUTI : <%= sisacuti %>
                </li>
                <li>
                    ANTRIAN YANG DI AJUKAN : <%= ajuancuti %>
                </li>
            </ul>
        </div>
    </div>
    <% end if %>
</div>

<footer class="footer">
        <div class="icons">
            <p class="company-name">
                Copyright &copy; 2022, ALL Rights Reserved MuhamadFirdaus-IT Division </br>
                V.1 Mobile Responsive 2022
            </p>
        </div>
</footer>

<script>
    let tgllama 
    let tglbaru
    function validasicuti(){
        // cek data tgl hari ini
        let today = new Date();
        
        // setting variable untuk cuti
        const jmlcuti = Number($("#jmlcuti").val());
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
        
        if (jmlcuti == 0){
             if ( date1 < today || date2 < today){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'TANGGAL MUNDUR TIDAK BERLAKU',
                });
                return false;   
            }else if ( date1.getTime() > date2.getTime() ){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'BULAN KEDUA ANDA SALAH PILIH',
                });
                return false;
            }else{
                if (confirm("DATA YANG ANDA ISI SUDAH BENAR ???") == true ){
                    return true;
                }else{
                    return false;
                }
            }
           return false; 
        }else{
            if ( date1 < today || date2 < today){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'TANGGAL MUNDUR TIDAK BERLAKU',
                });
                return false;   
            }else if ( date1.getTime() > date2.getTime() ){
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
        }
    return false;
    }
    function openNav(id = "",nip = "",tgla = "",tgle = "",ket = "",atasan = "",atasan2 = "",obat = "", status="") {
        document.getElementById("myNav").style.width = "100%";
        if ( id != "" ){
            $("#tgla").attr("type","text");
            $("#tgle").attr("type","text");
            
            this.tgllama = tgla;
            this.tglbaru = tgle;
            // mapping function 
            $("#nomor").val(id);
            $("#tgla").val(tgla);
            $("#tgle").val(tgle);
            $("input[name=status][value=" + status + "]").attr('checked', 'checked');
            $("#ket").val(ket);
            $("#atasan").val(atasan);
            $("#atasanUpper").val(atasan2);
            $("#bpengobatan").val(obat);
            
            $("#form-cuti").attr("action", "update.asp");
            // validasicuti();
        }else{
            this.tgllama = 0;
            this.tglbaru = 0;
            $("#tgla").attr("type","date");
            $("#tgle").attr("type","date");

            // mapping function 
            $("#nomor").val("");
            $("#tgla").val("");
            $("#tgle").val("");
            $("#ket").val("");
            $("input[name=status]").attr('checked', false);
            $("#bpengobatan").val("");
            $("#form-cuti").attr("action", "pcuti.asp");
        }   
    }

    function closeNav() {
        document.getElementById("myNav").style.width = "0%";
    }
    function changeinput(e){
        if (e == 1){
            $('#tgla').attr('type','date');
        }
        if (e == 2){
            $('#tgle').attr('type','date');
        }
    }    
</script>

<!-- #include file='../layout/footer.asp' -->