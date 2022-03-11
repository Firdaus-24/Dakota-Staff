<!-- #include file='../connection.asp' -->
<% 
user = Request.QueryString("uname")
serverid = Request.QueryString("serverID")
app = Request.QueryString("appRightsID")

set rs = Server.CreateObject("ADODB.Command")
rs.activeConnection = MM_Cargo_string

rs.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& user &"') AND (ServerID = '"& serverid &"') AND appIDRights = '"& app &"' "

set chekexist = rs.execute

if chekexist.eof then
    rs.commandText = "INSERT INTO WebRights (Username, ServerID, appIDRights ) VALUES ('"& user &"', '"& serverid &"', '"& app &"')"
    ' Response.Write rs.com
    rs.execute
else
    rs.commandText = "DELETE FROM WebRights WHERE (Username = '"& user &"') AND (ServerID = '"& serverid &"') AND appIDRights = '"& app &"' "
    rs.execute

end if
Response.Write rs.commandText
 %>