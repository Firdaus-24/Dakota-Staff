<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
 %>
<!--#include file="../connection.asp"-->
<!--#include file="../layout/header.asp"-->
    <!--link aos -->
    <style>
    .notiv-gagal{
        width:400px;
        height:200px;
        padding:20px;
        background:#718ee3;
        position: fixed;
        top: 50%;
        left: 50%;
        margin-top: -120px;
        margin-left: -220px;
        border-radius:20px;
    }
    .notiv-gagal span{
        float:right;
        margin-top:40px;
        color:white;
        font-size:20px;
        text-transform:uppercase;
    }
    .notiv-gagal img{
        display:block;
        width:100px;
        height:130px;
    }   
    .notiv-gagal a{
        display:block;
    }
    /* done */
      .notiv-berhasil{
        width:400px;
        height:200px;
        padding:20px;
        background:#718ee3;
        position: fixed;
        top: 50%;
        left: 50%;
        margin-top: -120px;
        margin-left: -220px;
        border-radius:20px;
    }
    .notiv-berhasil span{
        float:left;
        margin-top:40px;
        color:white;
        font-size:20px;
        text-transform:uppercase;
    }
    .notiv-berhasil img{
        display:inline-block;
        width:120px;
        height:130px;
        margin-left:20px;
    }   
    .notiv-berhasil a{
        display:block;
    }
    </style>
<% 
dim jabatan
dim jabatan_cmd, nama, id

nama = request.form("nama")
id = request.form("id")

set jabatan = Server.CreateObject("ADODB.Command")
jabatan.activeConnection = MM_Cargo_string

jabatan.commandText ="SELECT * FROM HRD_M_Jabatan WHERE Jab_Code = '"& id &"' and Jab_Nama = '"& nama &"'"
set jabatan = jabatan.execute

if jabatan.eof = true then
    set jabatan_cmd = Server.CreateObject("ADODB.Command")
    jabatan_cmd.ActiveConnection = MM_cargo_STRING

    jabatan_cmd.commandText ="exec sp_AddHRD_M_jabatan '"& id &"', '"& nama &"','"& session("username") &"'"
    jabatan_cmd.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a href='index.asp'></div>"
else 
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data sudah terdaftar</span><img src='../logo/stop_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a href='index.asp'></div>"
end if

 %> 

<!--#include file="../layout/footer.asp"-->
