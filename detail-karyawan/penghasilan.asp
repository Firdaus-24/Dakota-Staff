<!--#include file="../connection.asp"-->
<!-- #include file='../landing.asp' -->
<% 
    ' cek hakakses 
    if session("HA7")="" then 
	    response.redirect("index.asp?nip=" & trim(request.querystring("nip")))
    end if 
    ' end hakakses

    ' jika terjadi timeout waktu load data
    response.Buffer=true
    server.ScriptTimeout=1000000000

    ' pengecekan status karyawan untuk potongan
    set connection = Server.CreateObject("ADODB.Connection")
    connection.open MM_Cargo_String

    dim JJK, JKM, JHT, BPJS, TBPJS, BJ1, Max_TotalBJ
    dim sqlbaru

    set rs = Server.CreateObject("ADODB.Recordset")
    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'JKK'"

    rs.Open sqlawal, connection

    if rs.eof = false then
        JKK = rs("Set_VarValue")
    Else
        JKK = 0
    End If
        
    rs.Close

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'JKM'"

    rs.Open sqlawal, connection

    if rs.eof = false then
        JKM = rs("Set_VarValue")
    else 
        JKM = 0
    end if

    rs.close

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'JHT'"

    rs.open sqlawal, connection

    if rs.eof = false then
        JHT = rs("Set_VarValue")
    else 
        JHT = 0
    end if

    rs.close

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'BPJS'"


    rs.open sqlawal, connection

    if rs.eof = false then  
        BPJS = rs("Set_VarValue")
    else 
        BPJS = 0
    end If 

    rs.Close

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'TBPJS'"


    rs.open sqlawal, connection

    if rs.eof = false then  
        TBPJS = rs("Set_VarValue")
    else 
        TBPJS = 0
    end If 

    rs.Close

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'BJ1'"


    rs.open sqlawal, connection

    if rs.eof = false then  
        BJ1 = rs("Set_VarValue")
    else 
        BJ1 = 0
    end If 

    rs.Close

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "Select * from GLB_M_Setting WHERE Set_VarName = 'Max_TotalBJ'"


    rs.open sqlawal, connection

    if rs.eof = false then  
        Max_TotalBJ = rs("Set_VarValue")
    else 
        Max_TotalBJ = 0
    end If 

    rs.Close



    'hitung clickme pph21
    Dim PTKP , sql, NettoSetahun 
    Dim potongangaji, tanggungan
    dim kryn, nip, status

    nip = Request.QueryString("nip")

    'ambil nilai tanggungan di database
    set kryn = Server.CreateObject("ADODB.Command")
    kryn.activeConnection = MM_Cargo_String

    kryn.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_NIP ='"& nip &"'"

    set kry = kryn.execute

    jkelamin = kry("Kry_Sex")
    if jkelamin = "W" then
        tanggungan = 0
    else    
        tanggungan = kry("Kry_JmlTanggungan") + kry("Kry_JmlAnak")
    end if
    ' -------- Proses PTKP --------
    set potongangaji = Server.CreateObject("ADODB.Command")
    potongangaji.activeConnection = MM_Cargo_String

    ' cari nilai status karyawan
    if jkelamin = "W" then
        status = 0
    else
        status = kry("Kry_SttSosial")
    end if

    'cek umur karyawan
    umur = dateDiff("yyyy",kry("Kry_tglLahir"),(date))

    ' cek karyawan sudah menikah atau belm
    if status = 0 then
        if tanggungan = 0 then 
                potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'TK'"
                set potgaji = potongangaji.execute

                if potgaji.eof = false then
                    PTKP = potgaji("PTKP_Max")
                else 
                    PTKP = 0
                end if
            elseif tanggungan = 1 then
                potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'TK1'"
                set potgaji = potongangaji.execute

                if potgaji.eof = false then
                    PTKP = potgaji("PTKP_Max")
                else 
                    PTKP = 0
                end if
            elseif tanggungan = 2 then
                potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'TK2'"
                set potgaji = potongangaji.execute

                if potgaji.eof = false then
                    PTKP = potgaji("PTKP_Max")
                else 
                    PTKP = 0
                end if
            else
                potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'TK3'"
                set potgaji = potongangaji.execute

                if potgaji.eof = false then
                    PTKP = potgaji("PTKP_Max")
                else 
                    PTKP = 0
                end if
            end if

    elseIf status = 1 then
    'case 1
        if tanggungan = 0 then 
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'K'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if


        elseif tanggungan = 1 then
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'K1'"
            set potgaji = potongangaji.execute
            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if


        elseif tanggungan = 2 then
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'K2'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if

        ' 'Response.Write potgaji("PTKP_Max")
        else
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'K3'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if

        end if
    else 
    'case 2
        if tanggungan = 0 then 
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'HB'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if


        elseif tanggungan = 1 then
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'HB1'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if


        elseif tanggungan = 2 then
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'HB2'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
                ''Response.Write PTKP
            else 
                PTKP = 0
            end if


        else
            potongangaji.commandText = "SELECT * FROM HRD_M_PTKP where PTKP_ID = 'HB3'"
            set potgaji = potongangaji.execute

            if potgaji.eof = false then
                PTKP = potgaji("PTKP_Max")
            else 
                PTKP = 0
            end if
        end if
    end if 
    '-------- Proses PKP ---------
    dim pkp, pph21, bulan, selisih

    set pkp = Server.CreateObject("ADODB.Command")
    pkp.activeConnection = MM_Cargo_String

    pkp.commandText = "SELECT * FROM HRD_M_PKP ORDER by PKP_ID"
    set pkp = pkp.execute


    dim  gaji_cmd, gaji

    set gaji_cmd = server.createObject("ADODB.Command")
    gaji_cmd.activeConnection = MM_Cargo_String

    gaji_cmd.commandText = "SELECT * FROM HRD_T_Salary_COnvert WHERE Sal_NIP = '"& nip &"' and year(sal_startDate) = YEAR(getdate()) ORDER BY Sal_StartDate DESC "
    ' Response.Write kryn.commandTExt & "<br>"
    set gaji = gaji_cmd.execute

    ' cek aktifasi bpjs 
    kryn.commandText = "SELECT TOP 1 Mut_BPJSKes, Mut_BPJSKet,Mut_tanggal FROM HRD_T_MutasiBPJS WHERE Mut_KryNip = '"& nip &"' ORDER BY Mut_tanggal DESC"
    ' Response.Write kryn.commandTExt & "<br>"
    set mutbpjs = kryn.execute 

%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=100, initial-scale=1.0">
    <title>Transaksi Gaji</title>
    <!--#include file="../layout/header.asp"-->
    <style>
        tr {
            width: 1%;
            white-space: nowrap;
        }
        .loadpenghasilan{
            width:30px;
            margin-left:110%;
            margin-top:-29px;
            display:none;
        }
        .hidden{
            display:none;
        }
        .labelGapok label{
            font-size:14px;
        }
        .tunjangan label{
            font-size:14px;
        }
        .potongan label{
            font-size:14px;
        }
    </style>
    <link rel="stylesheet" href="../css/detail-all.css">
    <SCRIPT LANGUAGE="JavaScript">
    //auto count rupiah
    var newnilai = '';
    var rp = '';

    // valiable reset value
    var gapok = 0;
    var thr = 0;
    var insentif = 0;
    var bpjs = 0;
    var kesehatan = 0;
    var keluarga = 0;
    var transport = 0;
    var bpjsjkk = 0;
    var jabatan = 0;
    var ttunjangan = 0;
    var bpjstkjht = 0;
    var koperasi = 0;
    var bpjsk = 0;
    var lain = 0;
    var bpjsp = 0;
    var klaim = 0;
    var potabsen = 0;
    var potonganpph21 = 0;
    // smua total
    var totalgaji = 0;
    var totaltunjangan = 0;
    var hitungtotal = 0;
    var totalpotongan = 0;
    var labelgaji = 0;
    var tunjanganbpjsjp = 0;
    var tunjanganbpjstkjkk = 0;
    var potonganbpjs = 0;
    var potonganbpjsk = 0;
    var potonganbpjstkjht = 0;
    var potonganbpjsjkk = 0;
    var potonganbpjstkjp = 0;

    var tunjanganbpjstkjkm = 0;
    var potonganbpjstkjkm = 0;
    var potonganbpjstkjpk = 0;

    // deklarasi field baru 
    var insentifDTP = 0
    var potpengembalian = 0

    // tanggal input otomatis
    var t = new Date();
    var tgla = t.getDate();
    var x = t.getMonth();
    var bulanA = x + 1;
    var thnA = t.getYear();
    var jam = t.getHours();
    var min = t.getMinutes();
    // bulatkan tahun
    var thne = (thnA < 1000) ? thnA + 1900 : thnA;

    var formathariIni = (bulanA + '/' + tgla + '/' + thne + " " + jam +':'+ min);
    let umur
    let maxumur

    // function untuk merubah angka string ke currency
    function format(number){
        var rupiah = '';
        var angkarev = number.toString().split('').reverse().join('');

        for (var i = 0; i < angkarev.length; i++) if (i % 3 === 0) rupiah += angkarev.substr(i, 3) + '.';
            return rupiah.split('', rupiah.length - 1).reverse().join('') + ',-';
    }

    // function untuk menghitungan potongan dan tunjangan 
    function rupiah(angka, nama, type, ptype) {
        umur = parseInt(document.getElementById("umur").value);
        maxumur = parseInt(57);

        if (nama === "gapok"){
            gapok = parseInt(angka);
            document.getElementById("gapok").value = format(gapok);    
        }else if(nama === "insentif"){
            insentif = parseInt(angka);
            document.getElementById("insentif").value = format(insentif);
        }else if (nama === "thr"){
            thr = parseInt(angka);
            document.getElementById("thr").value = format(thr);
        }else if (nama === "potpengembalian"){
            potpengembalian = parseInt(angka);
            document.getElementById("potpengembalian").value = format(potpengembalian);
        }else if (nama === "insentifDTP"){
            insentifDTP = parseInt(angka);
            document.getElementById("insentifDTP").value = format(insentifDTP);
        }else if (nama === "bpjs"){
            bpjs = parseInt(angka);
            document.getElementById("bpjs").value = format(bpjs);
        }else if (nama === "transport"){
            transport = parseInt(angka);
            document.getElementById("transport").value = format(transport);
        }else if (nama === "kesehatan"){
            kesehatan = parseInt(angka);
            document.getElementById("kesehatan").value = format(kesehatan);
        }else if (nama === "bpjsjkk"){
            bpjsjkk = parseInt(angka);
            document.getElementById("bpjsjkk").value = format(bpjsjkk);
        }else if (nama === "keluarga"){
            keluarga = parseInt(angka);
            document.getElementById("keluarga").value = format(keluarga);
        }else if (nama === "jabatan"){
            jabatan = parseInt(angka);
            document.getElementById("jabatan").value = format(jabatan);
        }else if (nama === "bpjstkjkk"){
            bpjstkjkk = parseInt(angka);
            document.getElementById("bpjstkjkk").value = format(bpjstkjkk);
        }else if (nama === "bpjstkjht"){
            bpjstkjht = parseInt(angka);
            document.getElementById("bpjstkjht").value = format(bpjstkjht);
        }else if (nama === "bpjsp"){
            bpjsp = parseInt(angka);
            document.getElementById("bpjsp").value = format(bpjsp);
        }else if (nama === "koperasi"){
            koperasi = parseInt(angka);
            document.getElementById("koperasi").value = format(koperasi);
        }else if (nama === "klaim"){
            klaim = parseInt(angka);
            document.getElementById("klaim").value = format(klaim);
        }else if (nama === "bpjsk"){
            bpjsk = parseInt(angka);
            document.getElementById("bpjsk").value = format(bpjsk);
        }else if (nama === "potabsen"){
            potabsen = parseInt(angka);
            document.getElementById("potabsen").value = format(potabsen);
        }else if (nama === "lain"){
            lain = parseInt(angka);
            document.getElementById("lain").value = format(lain);
        }else if (nama === "ttunjangan"){
            ttunjangan = parseInt(angka);
            document.getElementById("ttunjangan").value = format(ttunjangan);
        }else if (nama === "bpjstkjkm"){
            bpjstkjkm = parseInt(angka);
            document.getElementById("bpjstkjkm").value = format(tunjanganbpjstkjkm);
        }


        // cek jika tombol update di pencet untuk tunjangan
        if (document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') != 0 ){
            gapok = parseInt(document.getElementById("gapok").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("insentif").value.replace(/[^\w\s]/gi, '') != 0 ){
            insentif = parseInt(document.getElementById("insentif").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("thr").value.replace(/[^\w\s]/gi, '') != 0 ){
            thr = parseInt(document.getElementById("thr").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("jabatan").value.replace(/[^\w\s]/gi, '') != 0 ){
            jabatan = parseInt(document.getElementById("jabatan").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("transport").value != 0 ){
            transport = parseInt(document.getElementById("transport").value.replace(/[^\w\s]/gi, ''));
            document.getElementById("transport").value = format(transport);
        }
        if (document.getElementById("kesehatan").value != 0 ){
            kesehatan = parseInt(document.getElementById("kesehatan").value.replace(/[^\w\s]/gi, ''));
            document.getElementById("kesehatan").value = format(kesehatan);
        }
        if (document.getElementById("keluarga").value != 0 ){
            keluarga = parseInt(document.getElementById("keluarga").value.replace(/[^\w\s]/gi, ''));
            document.getElementById("keluarga").value = format(keluarga);
        }

        // cek jika tombol update di pencet untuk potongan
        if (document.getElementById("koperasi").value.replace(/[^\w\s]/gi, '') != 0 ){
            koperasi = parseInt(document.getElementById("koperasi").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("potabsen").value.replace(/[^\w\s]/gi, '') != 0 ){
            potabsen = parseInt(document.getElementById("potabsen").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("klaim").value.replace(/[^\w\s]/gi, '') != 0 ){
            klaim = parseInt(document.getElementById("klaim").value.replace(/[^\w\s]/gi, ''))
        }
        if (document.getElementById("lain").value.replace(/[^\w\s]/gi, '') != 0 ){
            lain = parseInt(document.getElementById("lain").value.replace(/[^\w\s]/gi, ''))
        }
        
        // hitung potongan bpjs
        if (type === 'Y'){
            potonganbpjstkjht = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * 3.7;
            potonganbpjsjkk = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * parseFloat(0.89);
            potonganbpjstkjkm = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * parseFloat(0.30);
                if (umur >= maxumur){
                    potonganbpjstkjp = 0;
                    tunjanganbpjsjp = 0;
                    potonganbpjstkjpk = 0;
                }else{
                    potonganbpjstkjp = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * 2;
                    tunjanganbpjsjp = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * 2;
                    potonganbpjstkjpk = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * 1;
                }
            tunjanganbpjstkjkk = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * parseFloat(0.89);
            tunjanganbpjstkjkm = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * parseFloat(0.30);
            potonganbpjstkjhtk = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * parseFloat(2);
        }else{
            potonganbpjs = 0;
            potonganbpjsk = 0;
            potonganbpjstkjht = 0;
            potonganbpjsjkk = 0;
            potonganbpjstkjkm = 0;
            potonganbpjstkjp = 0;
            potonganbpjstkjpk = 0;
            tunjanganbpjsjp = 0;
            tunjanganbpjstkjkk = 0;
            tunjanganbpjstkjkm = 0;
            potonganbpjstkjhtk = 0;
        }

        if (ptype === "Y"){
            potonganbpjs = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * 4;
            potonganbpjsk = document.getElementById("gapok").value.replace(/[^\w\s]/gi, '') / 100 * 1;
        }else{
            potonganbpjs = 0;
            potonganbpjsk = 0;
        }
        // hitung total tunjangan
        totaltunjangan = potonganbpjs + kesehatan + jabatan + transport + keluarga + tunjanganbpjsjp + tunjanganbpjstkjkk + tunjanganbpjstkjkm + potonganbpjstkjht;
        // total potongan 
        totalpotongan = potonganbpjstkjht + potonganbpjsjkk + potonganbpjstkjp + potonganbpjstkjkm + potonganbpjs + potonganbpjstkjhtk + potonganbpjstkjpk + potonganbpjsk + koperasi + klaim + lain + potabsen;
        
        // potongan bpjs per persen
        document.getElementById('tgl').value = formathariIni;
        document.getElementById("bpjs").value = format(Math.ceil(potonganbpjs));
        document.getElementById("bpjsp").value = format(Math.ceil(potonganbpjs));
        document.getElementById("bpjsk").value = format(Math.round(potonganbpjsk));
        document.getElementById("bpjstkjht").value = format(Math.round(potonganbpjstkjht));
        document.getElementById("bpjstkjhtk").value = format(Math.round(potonganbpjstkjhtk));
        document.getElementById("bpjsjht").value = format(Math.round(potonganbpjstkjht));
        document.getElementById("bpjstkjkk").value = format(Math.round(tunjanganbpjstkjkk));
        document.getElementById("bpjsjkk").value = format(Math.round(potonganbpjsjkk));
        document.getElementById("bpjsjp").value = format(Math.ceil(tunjanganbpjsjp));
        document.getElementById("bpjstkjp").value = format(Math.round(potonganbpjstkjp));
        document.getElementById("bpjstkjkm").value = format(Math.ceil(tunjanganbpjstkjkm));
        document.getElementById("potbpjstkjkm").value = format(Math.ceil(potonganbpjstkjkm));
        document.getElementById("bpjstkjpk").value = format(Math.round(potonganbpjstkjpk));
        // total tunjangan
        document.getElementById("ttunjangan").value = format(Math.ceil(totaltunjangan));
        // total potongan
        document.getElementById("tpot").value = format(Math.ceil(totalpotongan));
     
        // gaji tanpa pph
        var labelpendapatan = gapok + insentif + Number(thr) + totaltunjangan + Number(insentifDTP) + Number(potpengembalian);

        labelgaji = labelpendapatan - totalpotongan;

        document.getElementById("labelGaji").value = format(Math.ceil(labelgaji)) ;

    }   

    // function hitung pph21/pajak
    function hitungNilai(){ 
        // deklarasi variable 
        var hasilpkpawal = 0;
        var hasilp = 0;
        var hasilpkpawal1 = 0;
        var hasilpkpawal2 = 0;
        var hasilpkpawal3 = 0;
        var perhitunganpphsetahun = 0;

        var tarifsatu = 0;
        var tarifdua = 0;
        var tariftiga = 0;
        var tarifempat = 0;
        // deklarasi field baru
        insentifDTP = document.getElementById("insentifDTP").value.replace(/[^\w\s]/gi, '');
        potpengembalian = document.getElementById("potpengembalian").value.replace(/[^\w\s]/gi, '');

        var nilai = 0;
        var hasilgaji = 0;
        // ambil data masuk karyawan
        var bulan = 12;

        var arrybulan = document.getElementById("blnmasuk").value;
        var tahun = document.getElementById("thnmasuk").value;
        var thnskrang = new Date().getFullYear();
        var curyear = parseInt(thnskrang) - parseInt(tahun) ;

        // perhitungan tahun pertama karyawan masuk kerja
        var blnmasuk = (parseInt(bulan) - parseInt(arrybulan)) + 1;

        // pkpawal
        var pkpawal1 = parseInt(document.getElementById("pkpawal1").value); 
        var pkpawal2 = parseInt(document.getElementById("pkpawal2").value); 
        var pkpawal3 = parseInt(document.getElementById("pkpawal3").value); 
        var pkpawal4 = parseInt(document.getElementById("pkpawal4").value); 
        var pkpawal5 = parseInt(document.getElementById("pkpawal5").value); 
        //pkpakhir
        var pkpakhir1 = parseInt(document.getElementById("pkpakhir1").value); 
        var pkpakhir2 = parseInt(document.getElementById("pkpakhir2").value); 
        var pkpakhir3 = parseInt(document.getElementById("pkpakhir3").value); 
        var pkpakhir4 = parseInt(document.getElementById("pkpakhir4").value);
        var pkpakhir5 = parseInt(document.getElementById("pkpakhir5").value);
        var tanggungan = parseInt(document.getElementById("tanggungan").value);

        // -------- Proses PPh Bonus --------
        var npwp = document.getElementById("npwp").value;
        
        var pendapatan = gapok - potabsen;
        
        var tunjanganlain = parseInt(jabatan);
        var honor = parseInt(insentif) + parseInt(thr) + parseInt(transport);
        // asuransi 1%
        var premiasuransi = Math.floor(potonganbpjs) +  Math.ceil(tunjanganbpjstkjkk) +  Math.ceil(tunjanganbpjstkjkm);

        var penghasilanbruto = pendapatan + tunjanganlain + honor + premiasuransi;
        var gajijabatan = penghasilanbruto;

        var potjabatan = (gajijabatan * 5) / 100;
        if ( potjabatan > 500000){
            potjabatan = 500000;
        }
        // iuran pensiun cuman 2%
        var iuranpensiun = Math.round(potonganbpjstkjhtk) + Math.round(potonganbpjstkjpk);

        var totaliuran = potjabatan + iuranpensiun;
        var penghasilannetto = gajijabatan - totaliuran;

        if (curyear > 0 || blnmasuk == 12){
            var nettostahun = Math.ceil(penghasilannetto * bulan);
        }else{
            var nettostahun = Math.ceil(penghasilannetto * blnmasuk);
        }
        // // -------- Proses PKP ---------
        var ptkp = parseInt(document.getElementById("ptkp").value);

        // bulatkan 3 angka nettosetahun jadi noll
        var snetto = nettostahun.toString();
        var laschar = snetto.slice(0,-3);
        var nol = "000";
        var newNetto = parseInt(laschar.concat(nol));
        var pkp = newNetto - ptkp;

        let p = Math.floor(pkp);

        if ( curyear > 0 || blnmasuk == 12 ){
            if (!npwp){
                if ( p > parseInt(pkpawal1) && p <= parseInt(pkpakhir1)){
                    perhitunganpphsetahun = (( p * 6 )/ 100 ) / bulan;
                }else if ( p > parseInt(pkpawal2) && p <= parseInt(pkpakhir2)){
                    hasilpkpawal = (pkpawal2 * 6 ) / 100;
                    hasilp = ((p - pkpawal2 )* 18 ) / 100;
                    perhitunganpphsetahun = (hasilpkpawal + Math.floor(hasilp)) / bulan;
                }else if ( p > parseInt(pkpawal3) && p <= parseInt(pkpakhir3) ){
                    hasilpkpawal1 = (pkpawal2 * 6 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 18 ) / 100;
                    hasilpkpawal3 = ((p - pkpawal3) * 30 ) / 100;

                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3);
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / bulan;
                }else if ( p > parseInt(pkpawal4) && p <= parseInt(pkpakhir4) ){
                    hasilpkpawal1 = (pkpawal2 * 6 ) / 100;
                    tarifsatu =  parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 18 ) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = (tarifdua * 30 ) / 100;
                    hasilpkpawal4 = ((p - pkpawal4) * 36) / 100;

                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3) + Math.floor(hasilpkpawal4);
                    
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / bulan;
                }else if ( p > parseInt(pkpawal5) && p <= parseInt(pkpakhir5) ){
                    hasilpkpawal1 = (pkpawal2 * 6 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 18) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = (tarifdua * 30) / 100;
                    tariftiga = parseInt(pkpakhir4) - parseInt(pkpawal4);
                    hasilpkpawal4 = ( tariftiga * 36 ) / 100;
                    hasilpkpawal5 = ((p - pkpawal5) * 42 ) / 100;
                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3) + Math.floor(hasilpkpawal4) + Math.floor(hasilpkpawal5);
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / bulan;
                }
                document.getElementById("potpph21").value = format(Math.floor(perhitunganpphsetahun));
            }else{
                if ( p > parseInt(pkpawal1) && p <= parseInt(pkpakhir1)){
                    perhitunganpphsetahun = (( p * 5 )/ 100 ) / bulan;
                }else if ( p > parseInt(pkpawal2) && p <= parseInt(pkpakhir2)){
                    hasilpkpawal = (pkpawal2 * 5 ) / 100;
                    hasilp = ((p - pkpawal2 ) * 15 ) / 100;

                    perhitunganpphsetahun = (hasilpkpawal + Math.floor(hasilp)) / bulan;
                }else if ( p > parseInt(pkpawal3) && p <= parseInt(pkpakhir3) ){
                    hasilpkpawal1 = (pkpawal2 * 5 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 15 ) / 100;
                    hasilpkpawal3 = ((p - pkpawal3 ) * 25) / 100;

                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3);
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / bulan;
                }else if ( p > parseInt(pkpawal4) && p <= parseInt(pkpakhir4) ){
                    hasilpkpawal1 = (pkpawal2 * 5 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = ( tarifsatu * 15 ) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = ( tarifdua * 25 ) / 100;
                    pengurangGaji = p - pkpawal4;
                    hasilpkpawal4 = ((p - pkpawal4) * 30) / 100;
                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3) + Math.floor(hasilpkpawal4);
                    
                    perhitunganpphsetahun = (Math.floor(hasilpkpawal)) / bulan;
                }else if ( p > parseInt(pkpawal5) && p <= parseInt(pkpakhir5) ){
                    hasilpkpawal1 = (pkpawal2 * 5 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = ( tarifsatu * 15 ) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = ( tarifdua * 25 ) / 100;
                    tariftiga = parseInt(pkpakhir4) - parseInt(pkpawal4);
                    hasilpkpawal4 = ( tariftiga * 30 ) / 100;
                    hasilpkpawal5 = ((p - pkpawal5) * 35 ) / 100;
                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3) + Math.floor(hasilpkpawal4) + Math.floor(hasilpkpawal5);

                    perhitunganpphsetahun = (Math.floor(hasilpkpawal)) / bulan;
                }
                document.getElementById("potpph21").value = format(Math.floor(perhitunganpphsetahun));
            }
        }else{
            if (!npwp){
                if ( p > parseInt(pkpawal1) && p <= parseInt(pkpakhir1)){
                    perhitunganpphsetahun = (( p * 6 )/ 100 ) / blnmasuk;
                }else if ( p > parseInt(pkpawal2) && p <= parseInt(pkpakhir2)){
                    hasilpkpawal = (pkpawal2 * 6 ) / 100;
                    hasilp = ((p - pkpawal2 )* 18 ) / 100;
                    perhitunganpphsetahun = (hasilpkpawal + Math.floor(hasilp)) / blnmasuk;
                }else if ( p > parseInt(pkpawal3) && p <= parseInt(pkpakhir3) ){
                    hasilpkpawal1 = (pkpawal2 * 6 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 18 ) / 100;
                    hasilpkpawal3 = ((p - pkpawal3) * 30 ) / 100;

                    hasilpkpawal = hasilpkpawal1 + hasilpkpawal2 + hasilpkpawal3;
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / blnmasuk;
                
                }else if ( p > parseInt(pkpawal4) && p <= parseInt(pkpakhir4) ){
                    hasilpkpawal1 = (pkpawal2 * 6 ) / 100;
                    tarifsatu =  parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 18 ) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = (tarifdua * 30 ) / 100;
                    hasilpkpawal4 = ((p - pkpawal4) * 36) / 100;

                    hasilpkpawal = hasilpkpawal1 + hasilpkpawal2 + hasilpkpawal3 + hasilpkpawal4;
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / blnmasuk;
                }else if ( p > parseInt(pkpawal5) && p <= parseInt(pkpakhir5) ){
                     hasilpkpawal1 = (pkpawal2 * 6 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 18) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = (tarifdua * 30) / 100;
                    tariftiga = parseInt(pkpakhir4) - parseInt(pkpawal4);
                    hasilpkpawal4 = ( tariftiga * 36 ) / 100;
                    hasilpkpawal5 = ((p - pkpawal5) * 42 ) / 100;
                    hasilpkpawal = hasilpkpawal1 + hasilpkpawal2 + hasilpkpawal3 + hasilpkpawal4 + hasilpkpawal5;
                    
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / blnmasuk;
                    
                }
                document.getElementById("potpph21").value = format(Math.floor(perhitunganpphsetahun));
            }else{
                if ( p > parseInt(pkpawal1) && p <= parseInt(pkpakhir1)){
                    perhitunganpphsetahun = (( p * 5 )/ 100 ) / blnmasuk;
                }else if ( p > parseInt(pkpawal2) && p <= parseInt(pkpakhir2)){
                    hasilpkpawal = (pkpawal2 * 5 ) / 100;
                    hasilp = ((p - pkpawal2 )* 15 ) / 100;
                    perhitunganpphsetahun = (hasilpkpawal + Math.floor(hasilp)) / blnmasuk;
                }else if ( p > parseInt(pkpawal3) && p <= parseInt(pkpakhir3) ){
                     hasilpkpawal1 = (pkpawal2 * 5 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = (tarifsatu * 15 ) / 100;
                    hasilpkpawal3 = ((p - pkpawal3 ) * 25) * 100;

                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3);
                    perhitunganpphsetahun = Math.floor(hasilpkpawal) / blnmasuk;
                }else if ( p > parseInt(pkpawal4) && p <= parseInt(pkpakhir4) ){
                    hasilpkpawal1 = (pkpawal2 * 5 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = ( tarifsatu * 15 ) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = ( tarifdua * 25 ) / 100;
                    hasilpkpawal4 = ((p - pkpawal4) * 30) / 100;

                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3) + Math.floor(hasilpkpawal4);
                    perhitunganpphsetahun = (Math.floor(hasilpkpawal)) / blnmasuk;
                }else if ( p > parseInt(pkpawal4) && p <= parseInt(pkpakhir4) ){
                    hasilpkpawal1 = (pkpawal2 * 5 ) / 100;
                    tarifsatu = parseInt(pkpakhir2) - parseInt(pkpawal2);
                    hasilpkpawal2 = ( tarifsatu * 15 ) / 100;
                    tarifdua = parseInt(pkpakhir3) - parseInt(pkpawal3);
                    hasilpkpawal3 = ( tarifdua * 25 ) / 100;
                    tariftiga = parseInt(pkpakhir4) - parseInt(pkpawal4);
                    hasilpkpawal4 = ( tariftiga * 30 ) / 100;
                    hasilpkpawal5 = ((p - pkpawal5) * 35 ) / 100;
                    hasilpkpawal = Math.floor(hasilpkpawal1) + Math.floor(hasilpkpawal2) + Math.floor(hasilpkpawal3) + Math.floor(hasilpkpawal4) + Math.floor(hasilpkpawal5);

                    perhitunganpphsetahun = (Math.floor(hasilpkpawal)) / blnmasuk;
                }
                document.getElementById("potpph21").value = format(Math.floor(perhitunganpphsetahun));
            }
        }

        nilai = totalpotongan + perhitunganpphsetahun;

        document.getElementById("tpot").value = format(Math.floor(nilai));
        
        hasilgaji = (Number(gapok) + Number(thr) + Number(totaltunjangan) + Number(insentif)) - (Number(totalpotongan) + Number(perhitunganpphsetahun)) + Number(insentifDTP) + Number(potpengembalian);
    
        document.getElementById("labelGaji").value = format(Math.ceil(hasilgaji));
    }
    // End -->

    // funtion btn tambah pengahasilan
    function tambahPenghasilan(){
        $("#nomor-penghasilan").val("");
        $("#tgl").val("");
        $("#gapok").val(format(0));
        $("#insentif").val(format(0));
        $("#thr").val(format(0)); 
        $("#potpengembalian").val(format(0)); 
        $("#insentifDTP").val(format(0)); 
        //tunjangan     
        $("#bpjs").val(format(0));            
        $("#bpjsjht").val(format(0));            
        $("#bpjstkjkk").val(format(0));            
        $("#bpjstkjkm").val(format(0));            
        $("#bpjsjp").val(format(0));            
        $("#transport").val(format(0));            
        $(".kesehatan").val(format(0));            
        $("#keluarga").val(format(0));            
        $("#jabatan").val(format(0));                          
        $("#ttunjangan").val(format(0));
        //potongan 
        $("#bpjstkjht").val(format(0));            
        $("#bpjstkjhtk").val(format(0));            
        $("#bpjsjkk").val(format(0));            
        $("#bpjstkjp").val(format(0));            
        $("#bpjstkjpk").val(format(0));            
        $("#potbpjstkjkm").val(format(0));            
        $("#bpjsk").val(format(0));            
        $("#bpjsp").val(format(0));            
        $("#koperasi").val(format(0));            
        $("#klaim").val(format(0));            
        $("#potabsen").val(format(0));            
        $("#lain").val(format(0));            
        $("#potpph21").val(format(0));            
        $("#tpot").val(format(0));            
        $("#labelGaji").val(format(0));
    }
    // function btn update penghaislan
    const updatePenghasilan = (id, p, q, r) => {
        umur = parseInt(document.getElementById("umur").value);
        maxumur = parseInt(56);
        $.ajax({
                url: '<%=url%>/detail-karyawan/penghasilan/penghasilan_update.asp',
                data: { id: id, p : p, q : q, r:r },
                method: 'post',
                success: function (data) {

                    function splitString(strToSplit, separator) {
                        var arry = strToSplit.split(separator);

                        if ( arry[20] == "0.00" ){
                            arry20 = "0"
                        }else{
                            arry20 = arry[20]
                        }
                        $("#nomor-penghasilan").val(arry[0]);
                        $("#tgl").val(formathariIni);
                        $("#gapok").val(format(arry[21]));
                        $("#insentif").val(format(arry[3]));
                        $("#thr").val(format(arry20)); 
                        $("#potpengembalian").val(format(arry[41])); 
                        $("#insentifDTP").val(format(arry[42])); 
                        //tunjangan     
                        $("#bpjs").val(format(arry[24]));            
                        $("#bpjsjht").val(format(arry[27]));            
                        $("#bpjstkjkk").val(format(arry[29]));            
                        $("#bpjstkjkm").val(format(arry[32]));            
                        $("#bpjsjp").val(format(arry[34]));            
                        $("#transport").val(format(arry[5]));            
                        $(".kesehatan").val(format(arry[6]));            
                        $("#keluarga").val(format(arry[7]));            
                        $("#jabatan").val(format(arry[8]));                          
                        $("#ttunjangan").val(format(arry[22]));
                        //potongan 
                        $("#bpjstkjht").val(format(arry[27]));            
                        $("#bpjstkjhtk").val(format(arry[40]));            
                        $("#bpjsjkk").val(format(arry[29]));            
                        $("#bpjstkjp").val(format(arry[33]));            
                        $("#bpjstkjpk").val(format(arry[35]));            
                        $("#potbpjstkjkm").val(format(arry[32]));            
                        $("#bpjsk").val(format(arry[25]));            
                        $("#bpjsp").val(format(arry[24]));            
                        $("#koperasi").val(format(arry[12]));            
                        $("#klaim").val(format(arry[13]));            
                        $("#potabsen").val(format(arry[16]));            
                        $("#lain").val(format(arry[17]));            
                        $("#potpph21").val(format(arry[10]));            
                        $("#tpot").val(format(arry[37]));            
                        $("#labelGaji").val(format(arry[38]));   
                        
                        gapok = Number(arry[21]);
                        insentif = Number(arry[3]);
                        thr = arry20;
                        bpjs = Number(arry[23]);
                        kesehatan = Number(arry[6]);
                        keluarga = Number(arry[7]);
                        transport = Number(arry[5]);
                        bpjsjkk = Number(arry[29]);
                        jabatan = Number(arry[8]);
                        bpjstkjht = Number(arry[27]);
                        koperasi = Number(arry[12]);
                        bpjsk = Number(arry[25]);
                        lain = Number(arry[17])
                        bpjsp = Number(arry[24]);
                        klaim = Number(arry[13]);
                        potabsen = Number(arry[16]);
                        potonganpph21 = Number(arry[10]);
                        // field baru 
                        potpengembalian = Number(arry[41]);
                        insentifDTP = Number(arry[42]);
                        // bpjs ketenaga kerjaan
                        if ( p === 'Y'){ 
                            potonganbpjstkjht = ( gapok / 100 ) * 3.7;
                            potonganbpjsjkk = ( gapok / 100 ) * parseFloat(0.89);
                            potonganbpjstkjkm = ( gapok / 100 ) * parseFloat(0.30);
                            tunjanganbpjstkjkk = ( gapok / 100 ) * parseFloat(0.89);
                            tunjanganbpjstkjkm = ( gapok / 100 ) * parseFloat(0.30);
                            potonganbpjstkjhtk = ( gapok / 100 ) * parseFloat(2);
                            potonganbpjstkjhtp = ( gapok / 100 ) * parseFloat(3.7);

                            if (umur >= maxumur){
                                potonganbpjstkjp = 0;
                                tunjanganbpjsjp = 0;
                                potonganbpjstkjpk = 0;
                            }else{
                                potonganbpjstkjp = ( gapok / 100 ) * 2;
                                tunjanganbpjsjp = ( gapok / 100 ) * 2;
                                potonganbpjstkjpk = ( gapok / 100 ) * 1;
                            }
                        }else{
                            potonganbpjstkjhtk = 0;
                            potonganbpjsk = 0;
                            potonganbpjstkjht = 0;
                            potonganbpjsjkk = 0;
                            potonganbpjstkjkm = 0;
                            potonganbpjstkjp = 0;
                            potonganbpjstkjpk = 0;
                            tunjanganbpjsjp = 0;
                            tunjanganbpjstkjkk = 0;
                            tunjanganbpjstkjkm = 0;
                            potonganbpjstkjhtp = 0;
                        }

                        // bpjs kesehatan
                        if (q === "Y"){
                            potonganbpjs = ( gapok / 100 ) * 4;
                            potonganbpjsk = ( gapok / 100 ) * 1;
                        }else{
                            potonganbpjs = 0;
                            potonganbpjsk = 0;
                        }

                        // hitung total tunjangan
                        totaltunjangan = potonganbpjs + kesehatan + jabatan + transport + keluarga + tunjanganbpjsjp + tunjanganbpjstkjkk + tunjanganbpjstkjkm + potonganbpjstkjht;

                        // total potongan 
                        totalpotongan = koperasi + klaim + potabsen + lain + potonganbpjstkjp + potonganbpjstkjpk + potonganbpjs + potonganbpjsk + potonganbpjstkjhtp + potonganbpjsjkk + tunjanganbpjstkjkm + potonganbpjstkjp;
                 
                    }
                    const koma = ",";
                    splitString(data, koma);
                    }
                });
                $('.modal-body form').attr('action', '<%=url%>/detail-karyawan/penghasilan/penghasilan_update_add.asp');
    }
    </script>
</head>
<body>
<!--#include file="template-detail.asp"-->
<div class="container">
    <!-- header start -->
    <div class="row mt-2 mb-2 contentDetail">
        <div class="col">
            <div class="row mb-2">
                <label for="nip" class="col-sm-1 col-form-label col-form-label-sm">NIP</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control form-control-sm" name="nip" id="nip" value="<%= nip %> " disabled>
                </div>
                <input type="hidden" class="form-control form-control-sm" name="tanggungan" id="tanggungan" value="<%= kry("Kry_JmlTanggungan") %> ">
                <input type="hidden" class="form-control form-control-sm" name="janak" id="janak" value="<%= kry("Kry_JmlAnak") %> " >
                <input type="hidden" class="form-control mb-2" id="npwp" name="npwp" value="<%= kry("Kry_NPWP") %>" >
                
                <label for="nip" class="col-sm-2 col-form-label col-form-label-sm">Nama Karyawan</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control form-control-sm" name="nama" id="nama" value="<%= kry("Kry_Nama") %> " disabled>
                </div>
            </div>
            <div class='row'>
                <label for="thn-penghasilan" class="col-sm-1 col-form-label col-form-label-sm">Tahun</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control form-control-sm" name="thn-penghasilan" id="thn-penghasilan">
                </div>
            </div>
            <% if session("HA7") = true then
                if session("HA7E") = true then
            %>
            <div class='row mt-4'>
                <div class="col">
                    <div class="d-grid gap-2 d-md-block">
                        <button type="button" class="btn btn-primary tambahPenghasilan" data-bs-toggle="modal" data-bs-target="#modalTambahGaji" onclick="return tambahPenghasilan()">
                            Tambah
                        </button>
                    </div>
                </div>
            </div>
            <% 
                end if
            end if
            %>
        </div>
    </div>
    <!-- header end -->
    <div class="row contentDetail">
        <div class="col" style="overflow-x: auto; overflow:y auto;">
            <table class="table table-striped table-penghasilan">
                <thead>
                    <tr>
                        <th scope="col" class="text-center">Aksi</th>
                        <th scope="col">No</th>
                        <th scope="col">Tanggal</th>
                        <th scope="col">Gaji Pokok</th>
                        <th scope="col">Insentif</th>
                        <th scope="col">THR/Bonus</th>
                        <th scope="col">BPJS.P</th>
                        <th scope="col">Tunj.Trasport</th>
                        <th scope="col">Tunj.Kesehatan</th>
                        <th scope="col">Tunj.Keluarga</th>
                        <th scope="col">Tunj.Jabatan</th>
                        <th scope="col">Asuransi</th>
                        <th scope="col">Jamsostek</th>
                        <th scope="col">Pot.PPh21</th>
                        <th scope="col">Pot.Koperasi</th>
                        <th scope="col">Pot.Klaim</th>
                        <th scope="col">BPJS.K</th>
                        <th scope="col">Pot.Absen</th>
                        <th scope="col">Pot.Lain</th>
                        <th scope="col">Kerterangan</th>
                        <th scope="col">Aktif</th>     
                        <th scope="col">User Upload</th>     
                    </tr>
                </thead>
                <tbody>
                    <%        
                    thnlalu = cdate("10/31/2021")
                    notivbpjs = ""
                    do while not gaji.eof
                    bpjsp = (gaji("Sal_gapok") / 100) * 4
                    bpjsk = (gaji("Sal_GaPok") / 100) * 1
                    ' cek aktifasi bpjs
                    if thnlalu <= gaji("Sal_StartDate") then
                        if not mutbpjs.eof then
                            if mutbpjs("mut_tanggal") <= gaji("Sal_StartDate") then
                                if mutbpjs("Mut_BPJSKes") = "Y" then
                                    rbpjsp = Round(bpjsp)
                                    rbpjsk = Round(bpjsk)
                                else
                                    rbpjsp = 0 
                                    rbpjsk = 0 
                                end if
                            else
                                rbpjsp = 0
                                rbpjsk = 0
                            end if
                        else
                            rbpjsp = 0
                            rbpjsk = 0
                            Response.Write "<tr><td colspan='22' style='color:red;'>MOHON UNTUK UPDATE AKTIFASI BPJS TERLEBIH DAHULU</td></tr>"
                        end if
                    else
                        if kry("Kry_BPJSKesYN") = "N" then 
                            rbpjsp = 0
                            rbpjsk = 0
                        else
                            rbpjsp = Round(bpjsp)
                            rbpjsk = Round(bpjsk)
                        end if
                    end if
                    %>
                    <tr>
                        <td class="text-center">
                            <div class="btn-group">
                            <% 
                            ' cek session
                            if session("HA7") = true then
                                if session("HA7A") = true then %>      
                                    <% if not mutbpjs.eof then %>                      
                                        <% if month(gaji("Sal_StartDate")) = month(date) And year(gaji("Sal_StartDate")) = year(date) then%>
                                            <span class="badge rounded-pill bg-primary updatePenghasilan" data-bs-toggle="modal" data-bs-target="#modalTambahGaji" onclick="return updatePenghasilan('<%=gaji("Sal_ID")%>', '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>','<%= kry("Kry_Nip") %>')">Update</span>
                                        <% else %>
                                            <span></span>
                                        <% end if %>
                                    <% else %>
                                            <span></span>
                                    <% end if %>
                                <% end if %>
                            <% end if %>
                            
                            <%' cek session
                            if session("HA7") = true then
                                if session("HA7B") = true then %>  
                                    <% if gaji("Sal_AktifYN") = "N" then %>
                                        <span class="badge rounded-pill bg-primary"><a href="<%= url %>/detail-karyawan/penghasilanAktif.asp?id=<%= gaji("Sal_ID") %>&aktif=<%= gaji("Sal_AktifYN") %>&nip=<%=nip%>" id="aktif-penghasilan" style="text-decoration:none;color:#fff;">AKTIF</a></span> 
                                    <% else %>
                                        <span class="badge rounded-pill bg-danger"><a href="<%= url %>/detail-karyawan/penghasilanAktif.asp?id=<%= gaji("Sal_ID") %>&aktif=<%= gaji("Sal_AktifYN") %>&nip=<%=nip%>" id="no-penghasilan" style="text-decoration:none;color:#fff;">NON AKTIF</a> </span> 
                                        <span class="badge rounded-pill bg-info"><a href="<%= url %>/detail-karyawan/slipgaji.asp?id=<%= gaji("Sal_ID") %>&nip=<%=nip%>" id="slipgaji" style="text-decoration:none;color:#fff;">SLIPGAJI</a></span> 
                                    <% end if %>
                                <% end if %>
                            <% end if %>
                            </div>
                        </td>
                        <td><%= gaji("Sal_ID") %></td>
                        <td><%= gaji("Sal_startDate") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_gapok")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Insentif")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_THR")),"$","") %></td>
                        <td><%= replace(formatCurrency(rbpjsp),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_TunjTransport")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_TunjKesehatan")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_TunjKeluarga")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_TunjJbt")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Asuransi")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Jamsostek")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_PPh21")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Koperasi")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Klaim")),"$","") %></td>
                        <td><%= replace(formatCurrency(rbpjsk),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Absen")),"$","") %></td>
                        <td><%= replace(formatCurrency(gaji("Sal_Lain")),"$","") %></td>
                        <td><%= gaji("Sal_Catatan") %></td>
                        <td><%= gaji("Sal_AktifYN") %></td>
                        <td><%= session("username") %></td>
                    </tr>
                <% 
                gaji.movenext
                loop
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!--modal -->
<div class="modal fade" id="modalTambahGaji" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">Gaji Editor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="penghasilan_add.asp" method="post" name="tambah-gaji" id="tambah-gaji">
                <div class="row labelGapok">
                    <label for="nomor" class="col-sm-2 col-form-label">Nomor</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control mb-2" id="nomor-penghasilan" name="nomor" readonly>
                    </div>
                    <div class="hidden">
                        <input type="text" class="form-control mb-2" id="nip" name="nip" value="<%=nip%>">
                        <p>ptkp</p>
                            <input type="text" class="form-control mb-2" id="ptkp" name="ptkp" value="<%=PTKP%>" >
                        <label>pkppct</label>
                            <input type="text" class="form-control mb-2" id="pkppct" name="pkppct" value="<%=pkp("PKP_Pct")%>" >
                        <label>tanggungan</label>
                            <input type="text" class="form-control mb-2" id="tanggungan" name="tanggungan" value="<%=tanggungan%>" >
                        <label>umur</label>
                            <input type="text" class="form-control mb-2" id="umur" name="umur" value="<%=umur%>" >
                        <% 
                        dim blnmsk, bln, thn, thnmsk
                        blnmsk = month(kry("Kry_TglMasuk"))
                        thn = year(kry("Kry_TglMasuk"))  
                        %>
                        <label>blnmasuk</label><input type="text" class="form-control mb-2" id="blnmasuk" name="blnmasuk" value="<%=blnmsk%>" >
                        <label>tahunmasuk</label><input type="text" class="form-control mb-2" id="thnmasuk" name="thnmasuk" value="<%=thn%>" >

                        <% 
                        dim i
                        i = 0
                        do until pkp.eof
                        i = i + 1
                        %>
                            <label>pkpawal <%= i %></label>
                                <input type="text" class="form-control mb-2" id="pkpawal<%=i%>" name="pkpawal" value="<%=pkp("PKP_Awal")%>" >
                            <label>pkpakhir <%= i %></label>
                                <input type="text" class="form-control mb-2" id="pkpakhir<%=i%>" name="pkpakhir" value="<%=pkp("PKP_Akhir")%>" >
                        <% 
                        pkp.movenext
                        loop
                        %> 
                    </div>


                    <label for="tgl" class="col-sm-2 col-form-label">Tanggal</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control mb-2" id="tgl" name="tgl" readonly >
                    </div>
                    <label for="gapok" class="col-sm-2 col-form-label">Gaji Pokok</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value,'gapok', '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="gapok" name="gapok" maxlength="50" value="0" >
                    </div>
                    <label for="insentif" class="col-sm-2 col-form-label">Insentif</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value,'insentif',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="insentif" name="insentif" maxlength="50" value="0">
                    </div>
                    <label for="THR" class="col-sm-2 col-form-label">THR</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'thr',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="thr" name="thr" maxlength="50" value="0">
                    </div>
                    <label for="THR" class="col-sm-2 col-form-label">Pot.Pengembalian</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'potpengembalian',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="potpengembalian" name="potpengembalian" maxlength="50" value="0">
                    </div>
                    <label for="THR" class="col-sm-2 col-form-label">insentif DPT</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'insentifDTP',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="insentifDTP" name="insentifDTP" maxlength="50" value="0">
                    </div>
                </div>
                <hr>
                <label><b>TUNJANGAN</b></label>
                <div class='row mb-2 tunjangan'>
                    <label for="bpjs" class="col-sm-2 col-form-label">BPJS KES.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjs' )" class="form-control mb-2" id="bpjs" name="bpjs" value="0" readonly>
                    </div>
                    <label for="bpjs" class="col-sm-2 col-form-label">BPJS TK-JHT.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjs' )" class="form-control mb-2" id="bpjsjht" name="bpjsjht" value="0" readonly>
                    </div>
                    <label for="bpjstkjkk" class="col-sm-2 col-form-label">BPJS TK-JKK.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjstkjkk')" class="form-control mb-2" id="bpjstkjkk" name="bpjstkjkk" readonly>
                    </div>
                    <label for="bpjstkjkm" class="col-sm-2 col-form-label">BPJS TK-JKM.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjstkjkm')" class="form-control mb-2" id="bpjstkjkm" name="bpjstkjkm" readonly>
                    </div>
                    <label for="bpjsjp" class="col-sm-2 col-form-label">BPJS TK-JP.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjsjp')" class="form-control mb-2" id="bpjsjp" name="bpjsjp" readonly>
                    </div>
                    <label for="transport" class="col-sm-2 col-form-label">Transport</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'transport',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="transport" name="transport" maxlength="50" value="0">
                    </div>
                    <label for="kesehatan" class="col-sm-2 col-form-label">Kesehatan</label>
                    <div class="col-sm-4"> 
                            <input type="text" onchange="rupiah(this.value, 'kesehatan',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2 kesehatan" id="kesehatan" name="kesehatan" value="0">
                    </div>
                    <label for="keluarga" class="col-sm-2 col-form-label">Keluarga</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'keluarga',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="keluarga" name="keluarga" maxlength="50" value="0">
                    </div>
                    <label for="jabatan" class="col-sm-2 col-form-label">Jabatan</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'jabatan',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="jabatan" name="jabatan" maxlength="50" value="0">
                    </div>
                    
                    <label for="ttunjangan" class="col-sm-2 col-form-label">Total Tunjangan</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'ttunjangan')" class="form-control mb-2" id="ttunjangan" name="ttunjangan" readonly>
                    </div>
                </div>
                <hr>
                <label><b>POTONGAN</b></label>
                <div class='row mb-2 potongan'>
                    <label for="bpjstkjht" class="col-sm-2 col-form-label">BPJS TK-JHT.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjstkjht')" class="form-control mb-2" id="bpjstkjht" name="bpjstkjht" readonly>
                    </div>
                    <label for="bpjstkjhtk" class="col-sm-2 col-form-label">BPJS TK-JHT.K</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjstkjht')" class="form-control mb-2" id="bpjstkjhtk" name="bpjstkjhtk" readonly>
                    </div>
                    <label for="bpjsjkk" class="col-sm-2 col-form-label">BPJS TK-JKK.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjsjkk')" class="form-control mb-2" id="bpjsjkk" name="bpjsjkk" readonly>
                    </div>
                    <label for="bpjstkjpk" class="col-sm-2 col-form-label">BPJS TK-JP.K</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjstkjpk')" class="form-control mb-2" id="bpjstkjpk" name="bpjstkjpk" readonly>
                    </div>
                    <label for="bpjstkjp" class="col-sm-2 col-form-label">BPJS TK-JP.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjstkjp')" class="form-control mb-2" id="bpjstkjp" name="bpjstkjp" readonly>
                    </div>
                    <label for="BPJSK" class="col-sm-2 col-form-label">BPJS KES.K</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjsk')" class="form-control mb-2" id="bpjsk" name="bpjsk" readonly>
                    </div>
                    <label for="potbpjstkjkm" class="col-sm-2 col-form-label">BPJS TK-JKM.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'potbpjstkjkm')" class="form-control mb-2" id="potbpjstkjkm" name="potbpjstkjkm" readonly>
                    </div>
                    <label for="koperasi" class="col-sm-2 col-form-label">Koperasi</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'koperasi',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="koperasi" name="koperasi" maxlength="50" value="0">
                    </div>
                    <label for="BPJSP" class="col-sm-2 col-form-label">BPJS KES.P</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'bpjsp')" class="form-control mb-2" id="bpjsp" name="bpjsp" readonly>
                    </div>
                    <label for="klaim" class="col-sm-2 col-form-label">Klaim</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'klaim',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="klaim" name="klaim" maxlength="50" value="0">
                    </div>
                    <label for="potabsen" class="col-sm-2 col-form-label">Pot. Absen</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'potabsen',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="potabsen" name="potabsen" maxlength="50" value="0">
                    </div>
                    <label for="lain" class="col-sm-2 col-form-label">Lain-lain</label>
                    <div class="col-sm-4">
                            <input type="text" onchange="rupiah(this.value, 'lain',  '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>')" class="form-control mb-2" id="lain" name="lain" maxlength="50" value="0">
                    </div>
                    <label for="potpph21" class="col-sm-2 col-form-label">PPH21</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, '0')" class="form-control mb-2" id="potpph21" name="potpph21" value="0" readonly>
                        <button type="button" name="clickme" id="clickme" class="btn btn-primary btn-sm" onclick="hitungNilai()">Click Me</button>
                    </div> 
                    <label for="tpot" class="col-sm-2 col-form-label">Total Potongan</label>
                    <div class="col-sm-4">
                        <input type="text" onchange="rupiah(this.value, 'tpot')" class="form-control mb-2" id="tpot" name="tpot" value="0" readonly>
                    </div>
                </div>
                <hr>
                <div class='row'>
                        <div class="input-group input-group-default">
                            <span class="input-group-text" id="inputGroup-sizing-default">TOTAL GAJI</span>
                            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" name="labelGaji" id="labelGaji" readonly>
                        </div>
                </div>
                <hr>
                <div class='row'>
                    <div class="input-group">
                        <span class="input-group-text">CATATAN</span>
                        <textarea class="form-control" aria-label="CATATAN" name="catatan" id="catatan" maxlength="50"></textarea>
                    </div>
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
<!-- #include file='../layout/footer.asp' -->
