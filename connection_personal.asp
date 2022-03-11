<!-- #include file="../Connections/cargo.asp" -->
<% 
if session("nip") = "" then
    Response.Redirect("personal/login.asp")
end if
 %>