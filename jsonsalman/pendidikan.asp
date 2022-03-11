<!-- #include file='../connection.asp' -->
<% 
nip = Request.QueryString("p")

set pendidikan = Server.CreateObject("ADODB.Command")
pendidikan.activeConnection = mm_cargo_String

pendidikan.commandText = "SELECT HRD_T_Didik1.*, HRD_M_Jurusan.Jrs_Nama FROM HRD_T_Didik1 LEFT OUTER JOIN HRD_M_Jurusan ON HRD_T_Didik1.Ddk1_JrsID = HRD_M_Jurusan.Jrs_ID WHERE HRD_T_Didik1.Ddk1_NIP = '"& nip &"'"
' Response.Write pendidikan.commandText & "<br>"
set pendidikan = pendidikan.execute


response.ContentType = "Application/json;charset=utf-8"

Response.Write "["
do until pendidikan.eof
    Response.Write "{"
        Response.Write """NAMA""" & ":" & """" & pendidikan("Ddk1_Nama") & """" & "," 
        Response.Write """KOTA""" & ":" & """" & pendidikan("Ddk1_Kota") & """" & "," 
        Response.Write """BLN1""" &":" &  """" & pendidikan("Ddk1_Bulan1") & """" & "," 
        Response.Write """BLN2""" & ":" & """" & pendidikan("Ddk1_Bulan2") & """" & "," 
        Response.Write """TAHUN""" & ":" & """" & pendidikan("Ddk1_Tahun1") & """" & ","
        Response.Write """TAHUN""" & ":" & """" & pendidikan("Ddk1_Tahun1") & """" & ","
        Response.Write """TAHUN2""" & ":" & """" & pendidikan("Ddk1_Tahun2") & """" & ","
        Response.Write """JURUSAN""" & ":" & """" & pendidikan("Jrs_Nama") & """" & ","
        Response.Write """TAMAT""" & ":" & """" & pendidikan("Ddk1_TamatYN") & """"
    Response.Write "}"
pendidikan.movenext  
    if pendidikan.eof = false then
        Response.Write ","
    end if
loop
Response.Write "]"
 %>