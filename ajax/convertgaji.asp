<!-- #include file='../connection.asp' -->
<!-- #include file='../constend/constanta.asp' -->
<!--#include file="../../func_shakeNumber.asp"-->
<!--#include file="../../func_RestoreNumber.asp"-->
<% 
response.Buffer=true
server.ScriptTimeout=1000000000

dim bulan, tahun, key
dim salary_cmd, salary, tsalary

bulan = Request.Form("blnConvertgaji")
tahun = Request.Form("thnConvertgaji")

'rekap
set trekap_cmd = Server.CreateObject("ADODB.COmmand")
trekap_cmd.ActiveConnection = MM_Cargo_string

'conversalary
set tsalary_cmd = Server.CreateObject("ADODB.Command")
tsalary_cmd.ActiveConnection = MM_Cargo_string

'check data ada isinya atau tidak
set salary_cmd = Server.CreateObject("ADODB.Command")
salary_cmd.ActiveConnection = MM_Cargo_string

salary_cmd.commandText = "SELECT * FROM HRD_T_Salary WHERE Month(Sal_StartDate) = '"& bulan &"' and year(Sal_StartDate) = '"& tahun &"' and Sal_AktifYN = 'Y'"
'Response.Write salary_cmd.commandText
set salary = salary_cmd.execute
  
    absen = 0
    pinjaman = 0
    nip = ""
    key = ""
    do until salary.eof
    
        if salary.eof then
            absen = RestoreNumber(salary("Sal_absen"))
            pinjaman = RestoreNumber(salary("Sal_Pinjaman"))
        else 
            absen = 0
            pinjaman = 0
        end if
        nip = salary("Sal_NIp")
        key=left(nip,3) & right("00" & month(date),2) & right(year(date),2)

        'hapus data yang sudah ada di table ini
        ' tsalary_cmd.commandText = "DELETE FROM HRD_T_Salary_Convert WHERE sal_Nip = '"& salary("Sal_Nip") &"'"

        ' tsalary_cmd.execute
    
    ' tambah data baru
        tsalary_cmd.commandText = "exec sp_AddHRD_T_Salary_Convert '"& key &"','"& salary("Sal_Nip") &"','"& salary("Sal_StartDate") &"','"& RestoreNumber(salary("Sal_gapok")) &"','"& RestoreNumber(salary("Sal_Insentif")) &"','"& RestoreNumber(salary("Sal_TunjMakan")) &"','"& RestoreNumber(salary("Sal_TunjTransport")) &"','"& RestoreNumber(salary("Sal_TunjKesehatan")) &"','"& RestoreNumber(salary("Sal_TunjKeluarga")) &"','"& RestoreNumber(salary("Sal_TunjJbt")) &"','"& RestoreNumber(salary("Sal_Jamsostek")) &"','"& RestoreNumber(salary("Sal_PPh21")) &"','"& pinjaman &"','"& RestoreNumber(salary("Sal_Koperasi")) &"','"& RestoreNumber(salary("Sal_Klaim")) &"','"& RestoreNumber(salary("Sal_Asuransi")) &"','0','"& absen &"','"& RestoreNumber(salary("Sal_Lain")) &"','"& salary("Sal_catatan") &"','"& RestoreNumber(salary("Sal_THR")) &"'"
        'Response.Write tsalary_cmd.commandText & "<br>"
        tsalary_cmd.execute

    Response.flush 
    salary.movenext
    loop

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LOAD FORM</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    .notiv{
        width:400px;
        height:250px;
        padding:20px;
        background:#fff;
        border: 1px solid;
        box-shadow:10px 5px black;
        position: fixed;
        top: 40%;
        left: 50%;
        margin-top: -120px;
        margin-left: -220px;
        border-radius:20px;
    }
    .notiv img{
        display:block;
        width:100px;
        height:130px;
        margin:auto;
    }
    </style>
</head>

<body>
    <div class='notiv'  data-aos='fade-up'>
        <img src="../loader/Settings.GIF">
        <div class='label text-center mt-3'>
            <span>CEK FORM LAPORAN<span><br>
        <button type="button" class="btn btn-primary btn-sm" onclick="window.location.href='../laporan/index.asp'">LIHAT</button>
        </div>
    </div>
<!-- #include file='../layout/footer.asp' -->