<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<% 
dim setcuti
dim tgla, tgle

tgla = Cdate(Request.Form("awalcuti"))
tgle = Cdate(Request.Form("akhircuti"))

set setcuti = Server.CreateObject("ADODB.Command")
setcuti.activeConnection = MM_Cargo_String

setcuti.commandText = "SELECT * FROM HRD_T_PeriodeCuti WHERE TanggalStart = convert(datetime, '"& tgla &"') and TanggalEnd = convert(datetime, '"& tgle &"')"
' Response.Write setcuti.commandText
set cuti = setcuti.execute

if cuti.eof then
    setcuti.commandText = "exec sp_ADDHRD_T_PeriodeCuti '"& tgla &"', '"& tgle &"', '"& session("username") &"' "
    ' Response.Write setcuti.commandText
    setcuti.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/dashboard.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/dashboard.asp' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!-- #include file='../../layout/footer.asp' -->