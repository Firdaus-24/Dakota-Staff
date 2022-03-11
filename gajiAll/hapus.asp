<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DONE</title>
</head>
<% 
dim bln, tahun
dim hapus

bln = Request.Form("blnConvertgaji")
tahun = Request.Form("thnConvertgaji")

set hapus = Server.CreateObject("ADODB.Command")
hapus.activeConnection = MM_Cargo_string

hapus.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE month(Sal_StartDate) = '"& bln &"' and year(Sal_StartDate) = '"& tahun &"'"
set dataHapus = hapus.execute

if not dataHapus.eof then 
    ' hapus.commandText = "DELETE FROM HRD_T_Salary_Convert WHERE month(Sal_StartDate) = '"& bln &"' and year(Sal_StartDate) = '"& tahun &"'"
    ' hapus.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Terhapus</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/dashboard.asp' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Lama Terhapus</span><img src='../logo/gagal_dakota.PNG'><a href='"& url &"/dashboard.asp' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!-- #include file='../layout/footer.asp' -->