<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<%
    if session("HL8B") = false then
        Response.Redirect("index.asp")
    end if

    id = Request.QueryString("id")
    data = Request.QueryString("data")

    set update_cmd = Server.CreateObject("ADODB.COmmand")
    update_cmd.activeConnection = mm_cargo_string

    if data = "Y" then
        update_cmd.commandText = "UPDATE HRD_M_CalLiburPeriodik SET LP_LiburYN = 'N' WHERE LP_ID = '"& id &"'"
        update_cmd.execute
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
    else
        update_cmd.commandText = "UPDATE HRD_M_CalLiburPeriodik SET LP_LiburYN = 'Y' WHERE LP_ID = '"& id &"'"
        update_cmd.execute
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
    end if

%>
<!-- #include file='../layout/footer.asp' -->