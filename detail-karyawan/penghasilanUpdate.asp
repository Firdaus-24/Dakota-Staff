<!-- #include file='../connection.asp' -->
<!--#include file="../../func_shakeNumber.asp"-->
<!--#include file="../../func_RestoreNumber.asp"-->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim id, penghasilan_cmd, penghasilan

id = Request.querystring("id")
'Response.Write id

set penghasilan_cmd = Server.CreateObject("ADODB.Command")
penghasilan_cmd.activeConnection = MM_Cargo_String

penghasilan_cmd.commandText = "SELECT * FROM HRD_T_Salary WHERE Sal_ID ='"& id &"'"
set penghasilan = penghasilan_cmd.execute

'Response.Write penghasilan("Sal_StartDate")
dim data(17)

data(0)=penghasilan("Sal_ID")       
data(1)= penghasilan("Sal_StartDate")
data(2)= RestoreNumber(penghasilan("Sal_GaPok"))
data(3)= RestoreNumber(penghasilan("Sal_Insentif"))
data(4)= RestoreNumber(penghasilan("Sal_THR"))
data(5)= RestoreNumber(penghasilan("Sal_TunjKesehatan")) 
data(6)= RestoreNumber(penghasilan("Sal_TunjTransport"))
data(7)= RestoreNumber(penghasilan("Sal_TunjKeluarga"))
data(8)= RestoreNumber(penghasilan("Sal_TunjJbt"))
data(9)= RestoreNumber(penghasilan("Sal_Asuransi"))
data(10)= RestoreNumber(penghasilan("Sal_Jamsostek"))
data(11)= RestoreNumber(penghasilan("Sal_PPh21"))
data(12)= RestoreNumber(penghasilan("Sal_Koperasi"))
data(13)= RestoreNumber(penghasilan("Sal_Klaim"))
data(14)= RestoreNumber(penghasilan("Sal_Absen"))
data(15)= RestoreNumber(penghasilan("Sal_Lain"))
data(16)= penghasilan("Sal_Catatan")
data(17)= RestoreNumber(penghasilan("Sal_AktifYN"))


for each x in data
    Response.Write (x) &","
Next

 %>