<!-- #include file="updateLog.asp" -->

<%

'updateLog system
ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
browser = Request.ServerVariables("http_user_agent")
dateTime = now()
eventt = "CREATE"
key = aID
url = ""
call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser)

%>