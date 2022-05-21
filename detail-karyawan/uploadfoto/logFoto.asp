<!-- #include file='../../connection.asp' -->
<%
    nip = Request.QueryString("nip")

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "UPDATE"
    key = nip
    url = ""    

    keterangan = "UPDATE FOTO KARYAWAN KARYAWAN UNTUK NIP ("& nip &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

    Response.Redirect("../index.asp?nip="&nip)
%>