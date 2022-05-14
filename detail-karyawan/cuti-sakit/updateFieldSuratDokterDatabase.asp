<!-- #include file='../../connection.asp' -->
<%

set updatecutih_cmd = Server.CreateObject("ADODB.Command")
updatecutih_cmd.activeconnection = MM_Cargo_String 
			
			
updatecutih_cmd.commandText = "Update HRD_T_IzinCutiSakit set ICS_SuratDokterYN = '"& request.querystring("id") &"' where ICS_NIP = '"& request.querystring("nip") &"' and ICS_ID = '"& request.querystring("id") &"'"
'Response.Write updatecutih_cmd.commandText
updatecutih_cmd.execute

response.redirect "../cutiSakitIzin.asp?nip=" & request.querystring("nip")
			
%>