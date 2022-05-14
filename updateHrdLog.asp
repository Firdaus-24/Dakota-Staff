


<%

Function updateLog(eventt,access,key,user,cabang,datetime,ip,browser,keterangan)


Dim protocol
Dim domainName
Dim fileName
Dim queryString
Dim url
protocol = "http" 
If lcase(request.ServerVariables("HTTPS"))<> "off" Then 
   protocol = "https" 
End If

domainName= Request.ServerVariables("SERVER_NAME") 
fileName= Request.ServerVariables("SCRIPT_NAME") 
queryString= Request.ServerVariables("QUERY_STRING")'

url = protocol & "://" & domainName & fileName
If Len(queryString)<>0 Then
   url = url & "?" & queryString
End If

access = url


dim updateLog_cmd
dim updateLogg

set updateLog_cmd = server.createObject("ADODB.Command")
updateLog_cmd.activeConnection = MM_Cargo_string

updateLog_cmd.commandText =  "exec sp_AddHRD_T_Log '"& eventt &"','"& access &"','"& key &"','"& session("username") &"', "& session("server-id") &",'"& now() &"','"& ip &"','"& browser &"','"& keterangan &"'"
' Response.Write updateLog_cmd.commandText & "<br>"
set updateLogg = updateLog_cmd.execute


end function

%>

