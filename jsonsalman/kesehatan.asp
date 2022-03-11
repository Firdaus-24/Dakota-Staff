<!-- #include file='../connection.asp' -->
<% 
nip = Request.QueryString("p")

set kesehatan = Server.CreateObject("ADODB.Command")
kesehatan.activeConnection = mm_cargo_String

kesehatan.commandText = "SELECT HRD_T_Kesehatan.*, HRD_M_Penyakit.Peny_Nama FROM HRD_T_Kesehatan LEFT OUTER JOIN HRD_M_Penyakit ON HRD_T_Kesehatan.Kes_PenyID = HRD_M_Penyakit.Peny_ID WHERE HRD_T_Kesehatan.Kes_Nip = '"& nip &"'"

set kesehatan = kesehatan.execute


response.ContentType = "Application/json;charset=utf-8"

Response.Write "["
do until kesehatan.eof
    Response.Write "{"
        Response.Write """ID""" & ":" & """" & kesehatan("Kes_Id") & """" & "," 
        Response.Write """BULAN""" & ":" & """" & kesehatan("Kes_Bulan") & """" & "," 
        Response.Write """TAHUN""" &":" &  """" & kesehatan("Kes_Tahun") & """" & "," 
        Response.Write """NAMA""" & ":" & """" & kesehatan("Peny_Nama") & """" & "," 
        Response.Write """Lama""" & ":" & """" & kesehatan("Kes_Lama") & """"
    Response.Write "}"
kesehatan.movenext  
    if kesehatan.eof = false then
        Response.Write ","
    end if
loop
Response.Write "]"
 %>