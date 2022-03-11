<!-- #include file='../connection.asp' -->
<% 
dim pendidikan_cmd,pendidikan

nip = Request.QueryString("p")

set pendidikan_cmd = Server.CreateObject("ADODB.Command")
pendidikan_cmd.activeConnection = mm_cargo_String

pendidikan_cmd.commandText = "SELECT HRD_T_Didik1.*, HRD_M_jurusan.Jrs_Nama, HRD_M_JenjangDidik.JDdk_Nama FROM HRD_T_Didik1 LEFT OUTER JOIN HRD_M_Jurusan ON HRD_T_Didik1.Ddk1_JrsID = HRD_M_Jurusan.Jrs_ID LEFT OUTER JOIN HRD_M_JenjangDidik ON HRD_T_Didik1.Ddk1_JDdkID = HRD_M_JenjangDidik.JDdk_ID WHERE Ddk1_NIP = '"& nip &"'"

set pendidikan = pendidikan_cmd.execute

response.contentType = "application/json;charset=utf-8"
Response.Write "["
    do until pendidikan.eof
        Response.Write "{"

            Response.Write """NAMA"""  & ":" &  """" &  pendidikan("Ddk1_Nama") & """" & ","
            Response.Write """JURUSAN"""  & ":" &  """" &  pendidikan("Jrs_Nama") & """" & ","
            Response.Write """JENJANG"""  & ":" &  """" &  pendidikan("JDdk_Nama") & """" & ","
            Response.Write """KOTA""" & ":" & """" & pendidikan("Ddk1_Kota") & """"  & ","
            Response.Write """BULAN AWAL""" & ":" & """" & pendidikan("Ddk1_Bulan1") & """"  & ","
            Response.Write """TAHUN AWAL""" & ":" & """" & pendidikan("Ddk1_Tahun1") & """"  & ","
            Response.Write """BULAN AKHIR""" & ":" & """" & pendidikan("Ddk1_Bulan2") & """"  & ","
            Response.Write """TAHUN AKHIR""" & ":" & """" & pendidikan("Ddk1_Tahun2") & """"  & ","
            Response.Write """TAMAT""" & ":" & """" & pendidikan("Ddk1_TamatYN") & """" 


        Response.Write "}"
    pendidikan.movenext
        if pendidikan.eof = false then
            Response.Write ","
        end if
    loop
Response.Write "]"
 %>