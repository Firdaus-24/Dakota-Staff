<%
for each x in session.contents
response.write x & " = " & session.contents(x) & "<br>"
next
%>