<!-- #include file='../connection.asp' -->
<% 
    area = trim(Request.Form("area"))
    nip = trim(Request.Form("nip"))

    set update_cmd = Server.CreateObject("ADODB.COmmand")
    update_cmd.activeConnection = MM_Cargo_string

    update_cmd.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE kry_Nip = '"& nip &"' AND Kry_AktifYN = 'Y'"
    set karyawan = update_cmd.execute

    if karyawan.eof then
        Response.Redirect("activeAgen.asp?e=psSFWRRMps")
    else
        update_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_ActiveAgenID = '"& area &"', Kry_pass_login_loading_barang = 'E10ADC3949BA59ABBE56E057F20F883E' WHERE Kry_NIP = '"& nip &"'"
        update_cmd.execute
        Response.Redirect("activeAgen.asp?p=ZasdPsdie")
    end if
%>