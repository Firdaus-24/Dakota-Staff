<!-- #include file='../connection.asp' -->
<% 
if session("username") = "" then
response.Redirect("../login.asp")
end if

dim proses_cmd,proses, tanggal, tgl, tahun, tahunBaru, newYear
dim totalPinjaman, totalBayar, sisahutang

tanggal = Request.Form("tanggal")

tgl = month(tanggal)
tahun = year(tanggal)

set newYear = Server.CreateObject("ADODB.COmmand")
newYear.activeConnection = mm_cargo_string

set cek_cmd = Server.CreateObject("ADODB.COmmand")
cek_cmd.activeConnection = mm_cargo_string

set storedata_cmd = Server.CreateObject("ADODB.COmmand")
storedata_cmd.activeConnection = mm_cargo_string

set proses_cmd = Server.CreateObject("ADODB.COmmand")
proses_cmd.activeConnection = mm_cargo_string

proses_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_NIP, HRD_M_Karyawan.Kry_Nama,(SELECT ISNULL(SUM(TPK_PP), 0) AS jpinjam FROM HRD_T_PK WHERE (MONTH(TPK_Tanggal) = '"& tgl &"') AND (YEAR(TPK_Tanggal) = '"& tahun &"') AND (TPK_AktifYN = 'Y') AND (TPK_NIP = HRD_M_Karyawan.Kry_NIP)) AS jpinjam, (SELECT ISNULL(SUM(TPK_PP), 0) AS jbayar FROM HRD_T_BK WHERE (MONTH(TPK_Tanggal) = '"& tgl &"') AND (YEAR(TPK_Tanggal) = '"& tahun &"') AND (TPK_AktifYN = 'Y') AND(TPK_NIP = HRD_M_Karyawan.Kry_NIP)) AS jbayar FROM HRD_M_Karyawan WHERE ((SELECT ISNULL(SUM(TPK_PP), 0) AS jpinjam FROM HRD_T_PK AS HRD_T_PK_1 WHERE (MONTH(TPK_Tanggal) = '"& tgl &"') AND (YEAR(TPK_Tanggal) = '"& tahun &"') AND (TPK_NIP = HRD_M_Karyawan.Kry_NIP)) <> 0) OR ((SELECT ISNULL(SUM(TPK_PP), 0) AS jbayar FROM HRD_T_BK AS HRD_T_BK_1 WHERE (MONTH(TPK_Tanggal) = '"& tgl &"') AND (YEAR(TPK_Tanggal) = '"& tahun &"') AND (TPK_NIP = HRD_M_Karyawan.Kry_NIP)) <> 0) ORDER BY HRD_M_Karyawan.Kry_NIP"
' Response.Write proses_cmd.commandText & "<br>"
set proses = proses_cmd.execute

' query hitung satu tahun 
do until proses.eof
    cek_cmd.commandText = "SELECT * FROM HRD_T_SA_PK WHERE SAPK_Nip = '"& proses("Kry_nip") &"' AND SAPK_Tahun = '"& tahun &"'"
    ' Response.Write proses_cmd.commandText & "<br>"
    set update = cek_cmd.execute

    if not update.eof then
        if tgl = "1" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam01 = "& proses("jpinjam") &", SAPK_Bayar01 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            ' Response.Write storedata_cmd.commandText & "<br>"
            storedata_cmd.execute
        elseIf tgl = "2" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam02 = "& proses("jpinjam") &", SAPK_Bayar02 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "3" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam03 = "& proses("jpinjam") &", SAPK_Bayar03 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "4" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam04 = "& proses("jpinjam") &", SAPK_Bayar04 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "5" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam05 = "& proses("jpinjam") &", SAPK_Bayar05 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "6" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam06 = "& proses("jpinjam") &", SAPK_Bayar06 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            ' Response.Write storedata_cmd.commandText & "<br>"
            storedata_cmd.execute
        elseIf tgl = "7" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam07 = "& proses("jpinjam") &", SAPK_Bayar07 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "8" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam08 = "& proses("jpinjam") &", SAPK_Bayar08 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "9" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam09 = "& proses("jpinjam") &", SAPK_Bayar09 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            ' Response.Write storedata_cmd.commandText & "<br>"
            storedata_cmd.execute
        elseIf tgl = "10" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam10 = "& proses("jpinjam") &", SAPK_Bayar10 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            ' Response.Write storedata_cmd.commandText & "<br>"
            storedata_cmd.execute
        elseIf tgl = "11" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam11 = "& proses("jpinjam") &", SAPK_Bayar11 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            storedata_cmd.execute
        elseIf tgl = "12" then
            storedata_cmd.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam12 = "& proses("jpinjam") &", SAPK_Bayar12 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            
            storedata_cmd.execute
        end if
    else
        storedata_cmd.commandText = "INSERT INTO HRD_T_SA_PK (SAPK_Tahun,SAPK_Nip,SAPK_Awal,SAPK_Pinjam01,SAPK_Bayar01,SAPK_Pinjam02,SAPK_Bayar02,SAPK_Pinjam03,SAPK_Bayar03,SAPK_Pinjam04,SAPK_Bayar04,SAPK_Pinjam05,SAPK_Bayar05,SAPK_Pinjam06,SAPK_Bayar06,SAPK_Pinjam07,SAPK_Bayar07,SAPK_Pinjam08,SAPK_Bayar08,SAPK_Pinjam09,SAPK_Bayar09,SAPK_Pinjam10,SAPK_Bayar10,SAPK_Pinjam11,SAPK_Bayar11,SAPK_Pinjam12,SAPK_Bayar12) VALUES ('"& tahun &"','"& proses("Kry_Nip") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
        ' Response.Write storedata.commandText & "<br>"
        storedata_cmd.execute  

        if tgl = "1" then
            ' update data yang sudah masuk
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam01 = "& proses("jpinjam") &", SAPK_Bayar01 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            
            newYear.execute
        elseIf tgl = "2" then
            ' update data yang sudah masuk
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam02 = "& proses("jpinjam") &", SAPK_Bayar02 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "3" then
            ' update data yang sudah masuk
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam03 = "& proses("jpinjam") &", SAPK_Bayar03 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "4" then
            ' update data yang sudah masuk
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam04 = "& proses("jpinjam") &", SAPK_Bayar04 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "5" then
            ' update data yang sudah masuk
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam05 = "& proses("jpinjam") &", SAPK_Bayar05 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "6" then
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam06 = "& proses("jpinjam") &", SAPK_Bayar06 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "7" then
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam07 = "& proses("jpinjam") &", SAPK_Bayar07 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "8" then
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam08 = "& proses("jpinjam") &", SAPK_Bayar08 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "9" then
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam09 = "& proses("jpinjam") &", SAPK_Bayar09 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "10" then
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam10 = "& proses("jpinjam") &", SAPK_Bayar10 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "11" then
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam11 = "& proses("jpinjam") &", SAPK_Bayar11 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        elseIf tgl = "12" then
            ' proses_cmd.execute
            newYear.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Pinjam12 = "& proses("jpinjam") &", SAPK_Bayar12 = "& proses("jbayar") &" WHERE SAPK_Nip = '"& proses("Kry_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            newYear.execute
        end if
    end if
response.flush
proses.movenext
loop

set nthn = Server.CreateObject("ADODB.Command")
nthn.activeConnection = mm_cargo_String

ntahun = tahun + 1
if tgl = "12" then
    nthn.commandText = "SELECT SAPK_NIP, sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12)) as saldoakhir FROM HRD_T_SA_PK WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' and ( sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12)) <>0) order by SAPK_NIP"
    ' Response.Write nthn.commandText & "<br>"
    set sapk = nthn.execute

    do while not sapk.eof
        set lthn = Server.CreateObject("ADODB.Command")
        lthn.activeConnection = mm_cargo_String

        lthn.commandText = "SELECT * FROM HRD_T_SA_PK WHERE SAPK_Nip = '"& sapk("SAPK_Nip") &"' AND SAPK_Tahun = '"& ntahun &"'"
        
        set tahunBaru = lthn.execute
        
            if tahunBaru.eof then
                nthn.commandText = "INSERT INTO HRD_T_SA_PK (SAPK_Tahun, SAPK_NIP, SAPK_Pinjam01, SAPK_Bayar01, SAPK_Pinjam02, SAPK_Bayar02, SAPK_Pinjam03, SAPK_Bayar03, SAPK_Pinjam04, SAPK_Bayar04, SAPK_Pinjam05, SAPK_Bayar05, SAPK_Pinjam06, SAPK_Bayar06, SAPK_Pinjam07, SAPK_Bayar07, SAPK_Pinjam08, SAPK_Bayar08, SAPK_Pinjam09, SAPK_Bayar09, SAPK_Pinjam10, SAPK_Bayar10, SAPK_Pinjam11, SAPK_Bayar11, SAPK_Pinjam12, SAPK_Bayar12) VALUES ('"& ntahun &"','"& sapk("SAPK_Nip") &"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
                nthn.execute
            end if 
        nthn.commandText = "UPDATE HRD_T_SA_PK SET SAPK_Awal = "& sapk("saldoakhir") &" WHERE SAPK_Tahun = '"& ntahun &"' AND SAPK_Nip = '"& sapk("SAPK_Nip") &"'"
        
        nthn.execute

    response.flush
    sapk.movenext
    loop
end if
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PROSES PINJAMAN</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    @font-face {
        font-family: 'Source Sans Pro';
        src: url('../layout/source-font/SourceSansPro-Regular.ttf');
    }

    .container{
        text-align:center;
        height:100vh;
        padding:5px;
        position:relative;
    }
    h3{
        font-family: 'Source Sans Pro';
    }
    .content{
        position:absolute;
        width:100%;
        padding:10px;
        border-radius:10px;
        color:#fff;
        height:auto;
        top: 40%;
        left: 50%;
        margin-right: -50%;
        transform: translate(-50%, -50%);
        background:url('../logo/bgproses.jpg') no-repeat;
    }
    #tanggal{
        color:#fff;
        border:none;
        background:transparent;
    }
    hr{
        color:#fff;
        margin-top:-3px;
    }
    #submit{
        background:transparent;
        text-transform:uppercase;
        border-color:#fff;
        font-family:'Source Sans Pro';
    }
    #submit:hover{
        background:#D9A8C7;
    }
    .load{
        position:absolute;
        width:100%;
        padding:10px;
        border-radius:10px;
        height:auto;
        top: 40%;
        left: 50%;
        margin-right: -50%;
        transform: translate(-50%, -50%);
        display:none;
    }
    </style>
</head>

<body>
<div class='container'>
    <div class='content'>
        <div class='row'>
            <div class='col'>
                <h3>PROSES PINJAMAN KARYAWAN</h3>
            </div>
        </div>
        <form action="proses.asp" method="post" id="form-proses" onsubmit="setSAPK()">
        <div class="row justify-content-center mt-3">
            <div class="col-3">
                <label>Priode Bulan Dan Tahun</label>
            </div>
            <div class="col-3">
                <input type='date' class="form-control" name='tanggal' id='tanggal' autocomplete="off" required>
                <hr>
            </div>
        </div>
        <div class='row justify-content-center mt-3'>
            <div class="col-4">
                <button type="submit" class="btn btn-primary btn-sm" name="submit" id="submit">Proses</button>
                <button type="button" class="btn btn-primary btn-sm" onclick="window.location.href ='index.asp'" name="submit" id="submit">Kembali</button>
            </div>
        </div>
        </form>
    </div>
    <div class='load'>
        <img src="../loader/Gear.gif" class="rounded mx-auto d-block">
        <h3>Mohon Tunggu</h3>
    </div>
</div>

<script>
function setSAPK(){
    $('.content').hide();
    $(".load").show();
}
</script>

<!-- #include file='../layout/footer.asp' -->