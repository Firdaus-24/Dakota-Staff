<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
 %>
<!--#include file="includes/query.asp"-->
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

dim code, nama, update

code = trim(Request.form("id"))
nama = trim(Request.form("nama"))

'cek data sudah ada apa belm
set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_string

update.commandText = "SELECT * FROM HRD_M_Jabatan WHERE Jab_Nama ='"& nama &"' and Jab_Code ='"& code &"'"
set update = update.execute

if update.eof then
    jabatan_cmd.commandText = "UPDATE HRD_M_Jabatan SET Jab_Nama = '"& nama &"', Jab_Code = '"& code &"' WHERE Jab_Code = '"& code &"'"
    jabatan_cmd.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a href='index.asp'></div>"
else 
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data sudah terdaftar</span><img src='../logo/stop_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a href='index.asp'></div>"
end if
 
 %> 
<!--#include file="../layout/footer.asp"-->



