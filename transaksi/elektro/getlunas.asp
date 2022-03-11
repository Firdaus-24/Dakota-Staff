<!-- #include file='../../connection.asp' -->
<%
    nip = trim(Request.QueryString("nip"))
    id = trim(Request.QueryString("id"))

    set bayar_cmd = Server.CreateObject("ADODB.Command")
    bayar_cmd.activeConnection = mm_cargo_string

    set lunas_cmd = Server.CreateObject("ADODB.Command")
    lunas_cmd.activeConnection = mm_cargo_string

    lunas_cmd.commandText = "SELECT HRD_T_PK.TPK_PP, (ISNULL(HRD_T_PK.TPK_PP,0) - ISNULL(SUM(HRD_T_BK.TPK_PP),0)) AS jmlcicilan  FROM HRD_T_PK LEFT OUTER JOIN HRD_T_BK ON HRD_T_PK.TPK_ID = SUBSTRING(dbo.HRD_T_BK.TPK_Ket, 1, 18) WHERE HRD_T_PK.TPK_ID = '"& id &"' AND HRD_T_PK.TPK_Nip = '"& nip &"' AND HRD_T_PK.TPK_AktifYN = 'Y' AND HRD_T_BK.TPK_AktifYN = 'Y' AND HRD_T_BK.TPK_Nip = '"& nip &"' GROUP BY HRD_T_PK.TPK_PP"

    set lunas = lunas_cmd.execute

    if not lunas.eof then
        Response.Write lunas("jmlcicilan")
    else
        bayar_cmd.commandText = "SELECT TPK_PP FROM HRD_T_PK WHERE TPK_ID = '"& id &"' AND TPK_Nip = '"& nip &"' AND TPK_AktifYN = 'Y'"
        set bayar = bayar_cmd.execute

        Response.Write bayar("TPK_PP")
    end if

%>