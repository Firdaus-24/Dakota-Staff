<!-- #include file= "../connection.asp"-->
<!-- #include file='../layout/header.asp' -->
<% 
    username =request.Querystring("username")
    serverid =request.Querystring("serverID")

    set aktif_YN = server.createobject("ADODB.Command")
    aktif_YN.activeConnection = MM_Cargo_String

    aktif_YN.CommandText ="SELECT user_AktifYN FROM webLogin WHERE ServerID='"&serverid&"'"
    set aktifyn = aktif_YN.execute

    if not aktifyn.eof then
        if aktifyn("user_AktifYN") = "Y" then
            aktif_YN.CommandText ="UPDATE webLogin SET user_AktifYN='N' WHERE username='"&username&"' AND ServerID='"&serverid&"'"
            aktif_YN.execute
        else
            aktif_YN.CommandText ="UPDATE webLogin SET user_AktifYN='Y' WHERE username='"&username&"' AND ServerID='"&serverid&"'"
            aktif_YN.execute
        end if
    end if
        Response.redirect("index.asp")
%>
 <!--#include file="../layout/footer.asp"-->
 
