<!-- #include file='../connection.asp' -->
<!-- #include file='../landing.asp' -->
<!-- #include file='../constend/constanta.asp' -->
<% 
dim area_cmd, area, pegawai_cmd, pegawai, status_cmd, status
'area kerja
set area_cmd = Server.CreateObject("ADODB.Command")
area_cmd.ActiveConnection = MM_Cargo_string

area_cmd.commandText = "SELECT agen_ID, agen_nama FROM glb_m_agen WHERE agen_AktifYN = 'Y' AND Agen_Nama NOT LIKE '%XXX%' order by agen_nama ASC"
set area = area_cmd.execute
' pegawai
set pegawai_cmd = Server.CreateObject("ADODB.Command")
pegawai_cmd.ActiveConnection = MM_Cargo_string

pegawai_cmd.commandText = "SELECT agen_ID, agen_nama FROM glb_m_agen WHERE agen_AktifYN = 'Y' AND Agen_Nama NOT LIKE '%XXX%' order by agen_nama ASC"
set pegawai = pegawai_cmd.execute
'status
set status_cmd = Server.CreateObject("ADODB.Command")
status_cmd.ActiveConnection = MM_Cargo_string

status_cmd.commandText = "SELECT Kry_SttKerja FROM HRD_M_Karyawan"
set status = status_cmd.execute

'untuk absensi
status_cmd.commandText = "SELECT Agen_ID, Agen_Nama, Agen_Propinsi, Agen_Kota FROM dbo.GLB_M_Agen WHERE (Agen_AktifYN = 'Y') AND (Agen_Nama NOT LIKE '%XX%') ORDER By Agen_Nama"

set wilayah = status_cmd.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index laporan</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    .laporan{
        background: rgb(2,0,36);
        background: linear-gradient(107deg, rgba(2,0,36,1) 0%, rgba(7,7,120,1) 64%, rgba(171,0,255,1) 94%);
        color:#fff;
    }
    .container .templateLaporan
    {
        margin-top:50px;
    }
    .contentLaporan
    {
        margin-top:3vh !important;
    }
    .optionLaporan
    {
        box-shadow: 0 0 1rem 0 rgba(0, 0, 0, .2);
        padding:10px;
        border-radius:5px;
        position: relative;
        z-index: 1;
        background: inherit;
        overflow: hidden;
    }
    .optionLaporan:before
    {
        content: "";
        position: absolute;
        background: inherit;
        z-index: -1;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        box-shadow: inset 0 0 2000px rgba(255, 255, 255, .5);
        filter: blur(10px);
        margin: -20px;
    }
    .filterLaporan
    {
        margin:0 5 0 5;
        box-shadow: 0 0 1rem 0 rgba(0, 0, 0, .2);
        padding:10px;
        border-radius:5px;
        position: relative;
        z-index: 1;
        background: inherit;
        overflow: hidden;
    }
    .filterLaporan:before
    {
        content: "";
        position: absolute;
        background: inherit;
        z-index: -1;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        box-shadow: inset 0 0 2000px rgba(255, 255, 255, .5);
        filter: blur(10px);
        margin: -20px;
    }
    .urutLaporan
    {
        box-shadow: 0 0 1rem 0 rgba(0, 0, 0, .2);
        padding:10px;
        border-radius:5px;
        position: relative;
        z-index: 1;
        background: inherit;
        overflow: hidden;
        
    }
    .urutLaporan:before
    {
        content: "";
        position: absolute;
        background: inherit;
        z-index: -1;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        box-shadow: inset 0 0 2000px rgba(255, 255, 255, .5);
        filter: blur(10px);
        margin: -20px;
    }
    @media only screen and (max-width: 600px){
        .container{
            margin-top:-10vh;
        }
        .contentLaporan{
            display:block;
            grid-template-columns: 1fr 1fr;
            margin-left:3px;
            /* margin-bottom:5px; */
            width:100%;
        }
        .contentLaporan .optionLaporan{
            margin-bottom:5px;
        }
        .contentLaporan .filterLaporan{
            margin-left:-1px;
            margin-bottom:3px;
        }
    }
    </style>
</head>
<body class="laporan">
<div class='container'>
    <div class='row headerLaporan'>
        <div class='col-lg text-center templateLaporan'>
            <h3>CETAK LAPORAN</h3>
        </div>
    </div>
    <div class='row contentLaporan'>
        <div class='col optionLaporan'>
            <form action="laporankaryawanall.asp" method="post" id="formlaporan">
				<% 
                if session("HL") = true then
                    if session("HL1A")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapdaftar" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapdaftar">
                        Daftar Karyawan
                    </label>
                </div>
                <% 
                    end if
                end if %>
                <%
                if session("HL") = true then
                    if session("HL1B")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkontrak" onclick="return clickRadio(id)" >
                    <label class="form-check-label" for="lapkontrak">
                        Daftar Karyawan Kontrak
                    </label>
                </div>
                <% 
                    end if
                end if %>
                <%
                if session("HL") = true then
                    if session("HL1C")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapwajibpajak" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapwajibpajak">
                        Daftar Wajib Pajak
                    </label>
                </div>
                <% 
                    end if
                end if %>
                <%
                if session("HL") = true then
                    if session("HL1D")=true then %>
				<div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapcutiperiode" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapcutiperiode">
                       Laporan Cuti Per Periode
                    </label>
                </div>
                <% 
                    end if
                end if %>
				<%
                if session("HL") = true then
                    if session("HL1E")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapgajipernama" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapgajipernama">
                       Laporan Gaji Pernama
                    </label>
                </div>
				<% 
                    end if
                end if %>
                <%
                if session("HL") = true then
                    if session("HL1F")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="rekapgajiperdivisi" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="rekapgajiperdivisi">
                       Laporan Gaji Perdivisi
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                 <%
                if session("HL") = true then
                    if session("HL1G")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="gajipercabang" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="gajipercabang">
                      Laporan Gaji Percabang
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                 <%
                if session("HL") = true then
                    if session("HL1H")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawanharian" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawanharian">
                       Laporan Karyawan Harian
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                <%
                if session("HL") = true then
                    if session("HL1I")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawankeluar" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawankeluar">
                       Laporan Karyawan Keluar
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                 <%
                if session("HL") = true then
                    if session("HL1J")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawanperubahangaji" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawanperubahangaji">
                       Laporan Karyawan Perubahan Gaji
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                 <%
                if session("HL") = true then
                    if session("HL1K")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawanmutasi" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawanmutasi">
                       Laporan Karyawan Mutasi
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                 <%
                if session("HL") = true then
                    if session("HL1L")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawandemosi" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawandemosi">
                       Laporan Karyawan Demosi
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                <%
                if session("HL") = true then
                    if session("HL1M")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawanrotasi" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawanrotasi">
                       Laporan Karyawan Rotasi
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                <%
                if session("HL") = true then
                    if session("HL1N")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="lapkaryawanpromorsi" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="lapkaryawanpromorsi">
                       Laporan Karyawan Promorsi
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                <%
                if session("HL") = true then
                    if session("HL1O")=true then %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="gajikaryawan3" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="gajikaryawan3">
                       Rekap Gaji Karyawan 3
                    </label>
                </div>
                <% 
                    end if
                end if
                 %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="laporan" id="detailcuti" onclick="return clickRadio(id)">
                    <label class="form-check-label" for="detailcuti">
                       Laporan Ketidak Hadiran Karyawan
                    </label>
                </div>
        </div>
        <div class='col filterLaporan'>
            <div class='row'>
                <label>Filter Bulan Dan Tahun</label>
            </div>
            <div class="input-group input-group-sm mb-3">
                <span class="input-group-text" id="addon-wrapping">Tanggal Mulai</span>
                <input type="date" class="form-control" aria-describedby="addon-wrapping" autocomplate="off" name="tgla" id="tgla" required>
            </div>
            <div class="input-group input-group-sm mb-3">
                <span class="input-group-text" id="addon-wrapping">Tanggal Akhir</span>
                <input type="date" class="form-control" aria-describedby="addon-wrapping" autocomplate="off" name="tgle" id="tgle" required>
            </div>
            <div class='row'>
                <label>Pilih Area</label>
            </div>
            <div class="input-group input-group-sm mb-3">
                <label class="input-group-text" for="laparea">Area Aktif</label>
                    <select class="form-select" id="laparea" name="laparea">
                        <option value="">Pilih</option>
                        <% 
                        do until area.eof
                         %>
                        <option value="<%=area("agen_ID")%>"><%= area("agen_nama") %></option>
                        <% 
                        area.movenext
                        loop %>
                    </select>
                </div>
                <div class="input-group input-group-sm mb-3">
                    <label class="input-group-text" for="lappegawai">Pegawai</label>
                    <select class="form-select" id="lappegawai" name="lappegawai">
                        <option value="">Pilih</option>
                        <% 
                        do until pegawai.eof
                         %>
                        <option value="<%=pegawai("agen_ID")%>"><%= pegawai("agen_nama") %></option>
                        <% 
                        pegawai.movenext
                        loop %>
                    </select>
                </div>
                <div class="input-group input-group-sm  mb-3">
                    <label class="input-group-text" for="lapstatus">Status</label>
                    <select class="form-select" id="lapstatus" name="lapstatus">
                        <option value="">Pilih</option>
                        <option value="0">Borongan</option>
                        <option value="1">Harian</option>
                        <option value="2">Kontrak</option>
                        <option value="3">Magang</option>
                        <option value="4">Tetap</option>
                    </select>
                </div>
                <!--untuk absensi 
                <div class='row'>
                    <label>Filter Absensi</label>
                </div>
                 <div class="input-group input-group-sm mb-3">
                    <label class="input-group-text" for="wilayah">wilayah</label>
                    <select class="form-select" id="wilayah" name="wilayah">
                        <option value="">Pilih</option>
                        <% 
                        'do until wilayah.eof
                         %>
                        <option value="<%'=wilayah("agen_ID")%>"><%'= wilayah("agen_Kota") %></option>
                        <% 
                        wilayah.movenext
                        'loop %>
                    </select>
                </div>
                -->
        </div>
        <div class='col urutLaporan'>
            <div class='row'>
                <label>URUT BERDASARKAN</label>
            </div>
            <div class="form-check form-check-inline mt-2">
                <input class="form-check-input" type="radio" name="urutberdasarkan" id="lapNama" value="nama">
                <label class="form-check-label" for="lapNama">Nama</label>
            </div>
            <div class="form-check form-check-inline mb-3">
                <input class="form-check-input" type="radio" name="urutberdasarkan" id="lapNip" value="nip">
                <label class="form-check-label" for="lapNip">Nip</label>
            </div>
        </div>
        <div class='row'>
            <div class='col text-center mt-2'>
                <button type="submit" class="btn btn-primary submitLaporan" onclick="return clicklaporan()">Submit</button>
            </div>
        </div>
        </form>
</div>

</body>
<!-- #include file='../layout/footer.asp' -->
<script>
    $("#lapdaftar").click(function () {
        $('#formlaporan').attr('action', 'laporankaryawan.asp');
        $('#lapstatus').attr('disabled', false);
        $('#lappegawai').attr('disabled', false);
        $('#laparea').attr('disabled', false);
        $('#laparea').prop('required', false);
        $('#tgla').prop('required', false);
        $('#tgle').prop('required', false);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkontrak").click(function () {
        $('#formlaporan').attr('action', 'laporankaryawankontrak.asp');
        $('#lapstatus').attr('disabled', true);
        $('#lappegawai').attr('disabled', false);
        $('#laparea').attr('disabled', false);
        $('#laparea').prop('required', false);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapwajibpajak").click(function () {
        $('#formlaporan').attr('action', 'laporanwajibpajak.asp');
        $('#lapstatus').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#laparea').attr('disabled', false);
        $('#laparea').prop('required', false);
        $('#tgla').prop('required', false);
        $('#tgle').prop('required', false);
        $('#tgla').attr('disabled', true);
        $('#tgle').attr('disabled', true);
    });
	$("#lapcutiperiode").click(function () {
        $('#formlaporan').attr('action', 'laporancuti.asp');
        $('#lapstatus').attr('disabled', false);
        $('#lappegawai').attr('disabled', false);
        $('#laparea').attr('disabled', false);
        $('#laparea').prop('required', false);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapgajipernama").click(function () {
        $('#formlaporan').attr('action', 'laporangajipernama_fix.asp');
        $('#lapstatus').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#laparea').attr('disabled', false);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapgajipercabang").click(function () {
        $('#formlaporan').attr('action', 'laporangajipercabang.asp');
        $('#lapstatus').attr('disabled', false);
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkaryawanharian").click(function () {
        $('#formlaporan').attr('action', 'karyawanharian.asp');
        $('#laparea').attr('disabled', false);
        $('#lappegawai').attr('disabled', false);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkaryawankeluar").click(function () {
        $('#formlaporan').attr('action', 'karyawankeluar.asp');
        $('#laparea').attr('disabled', false);
        $('#lappegawai').attr('disabled', false);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkaryawanperubahangaji").click(function () {
        $('#formlaporan').attr('action', 'karyawanperubahangaji.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', false);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', true);
    });
    $("#lapkaryawanmutasi").click(function () {
        $('#formlaporan').attr('action', 'laporankaryawanmutasi.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkaryawandemosi").click(function () {
        $('#formlaporan').attr('action', 'laporankaryawandemosi.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkaryawanrotasi").click(function () {
        $('#formlaporan').attr('action', 'laporankaryawanrotasi.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#lapkaryawanpromorsi").click(function () {
        $('#formlaporan').attr('action', 'laporankaryawanpromorsi.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#rekapgajiperdivisi").click(function () {
        $('#formlaporan').attr('action', 'rekapgajiperdivisi.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#gajipercabang").click(function () {
        $('#formlaporan').attr('action', 'laporangajipercabang.asp');
        $('#laparea').attr('disabled', true);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    });
    $("#gajikaryawan3").click(function(){
        $('#formlaporan').attr('action', 'gajikaryawan3.asp');
        $('#laparea').attr('disabled', false);
        $('#lappegawai').attr('disabled', true);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    })

    // $("#laporanAbsensi").click(function(){
    //     $('#formlaporan').attr('action', 'absensi_test.asp');
    //     $('#laparea').attr('disabled', true);
    //     $('#lappegawai').attr('disabled', true);
    //     $('#lapstatus').attr('disabled', true);
    //     $('#tgla').prop('required', true);
    //     $('#tgle').prop('required', true);
    //     $('#tgla').attr('disabled', false);
    //     $('#tgle').attr('disabled', false);
    // })
    function clicklaporan(){
        var perubahangaji = document.getElementById("lapkaryawanperubahangaji").checked;
        var strErrors, oTemp;
        if (perubahangaji == true){
            //check 1
            oTemp = document.getElementById('laparea');
            if (oTemp.value=='Pilih') {
                alert('Mohon Isi Area aktif dahulu\n');
                return false;
            }
        }
    }
    $("#detailcuti").click(function(){
        $('#formlaporan').attr('action', 'ldkkaryawan.asp');
        $('#laparea').attr('disabled', false);
        $('#lappegawai').attr('disabled', false);
        $('#lapstatus').attr('disabled', true);
        $('#tgla').prop('required', true);
        $('#tgle').prop('required', true);
        $('#tgla').attr('disabled', false);
        $('#tgle').attr('disabled', false);
    })
    function clickRadio(id){
        // if (id == "lapkaryawanperubahangaji"){
        //     document.getElementById("lapkaryawanperubahangaji").checked = true;
        //     document.getElementById("lapdaftar").checked = false;
        //     document.getElementById("lapkontrak").checked = false;
        //     document.getElementById("lapwajibpajak").checked = false;
        //     document.getElementById("lapgajipernama").checked = false;
        //     document.getElementById("lapgajipercabang").checked = false;
        //     document.getElementById("lapkaryawanbaru").checked = false;
        //     document.getElementById("gajikaryawan3").checked = false;
        //     document.getElementById("laporanAbsensi").checked = false;
        // }
    }
</script>
</html>