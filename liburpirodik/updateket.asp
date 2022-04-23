<!-- #include file='../connection.asp' -->
<%
    if session("HL8A") = false then
        Response.Redirect("index.asp")
    end if

    id = trim(Request.form("id"))
    ket = trim(Request.form("ket"))

    set keterangan_cmd = Server.CreateObject("ADODB.Command")
    keterangan_cmd.activeConnection = mm_cargo_string

    keterangan_cmd.commandText = "SELECT LP_Keterangan FROM HRD_M_CalLiburPeriodik WHERE LP_ID = '"& id &"'"
    set keterangan  = keterangan_cmd.execute

    if not keterangan.eof then
        keterangan_cmd.commandText = "UPDATE HRD_M_CalLiburPeriodik SET LP_keterangan = '"& ket &"' WHERE LP_ID = '"& id &"'"
        ' Response.Write keterangan_cmd.commandText & "<br>"
        keterangan_cmd.execute
    end if
%>  