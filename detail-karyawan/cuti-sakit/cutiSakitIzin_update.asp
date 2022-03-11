<!--#include file="../../connection.asp"-->
<%
dim update, updatecuti, id

id = request.form("id")
nip = request.form("nip")
'Response.Write id

set update = server.createObject("ADODB.Command")
update.activeConnection = MM_Cargo_string

update.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_ID = '" & id & "' AND ICS_Nip = '"& nip &"'"
' Response.Write update.commandText & "<br>"
set updatecuti = update.execute

dim data(14)

data(0)= updatecuti("ICS_ID")
data(1)= updatecuti("ICS_StartDate")
data(2)= updatecuti("ICS_EndDate")
data(3)= updatecuti("ICS_Status") 
data(4)= updatecuti("ICS_Keterangan") 
data(5)= updatecuti("ICS_Atasan") 
data(6)= updatecuti("ICS_Obat")
data(7)= updatecuti("ICS_PotongCuti")
data(8)= updatecuti("ICS_PotongGaji")
data(9)= updatecuti("ICS_NIP")
data(10)= updatecuti("ICS_FormYN")
data(11)= updatecuti("ICS_AtasanApproveYN")
data(12)= updatecuti("ICS_AtasanUpper")
data(13)= updatecuti("ICS_AtasanUpperApproveYN")

for each x in data
    Response.Write (x) &","
Next
 %>

 

  
