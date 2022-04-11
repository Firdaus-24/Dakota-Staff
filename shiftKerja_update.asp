<!-- #include file="connection.asp"-->
<!-- #include file='layout/header.asp' -->
<% 
    if session("HA2AB") = false Then 
        Response.Redirect("tambahShiftkerja.asp")
    End if

    dim shiftName, str, datatgl, karyawan, nip 
    dim shift, arry, update

    update = request.queryString("update")

    shiftName = trim(request.form("shiftName"))
    str = trim(request.form("myrosterdate"))
    nip = trim(request.form("karyawan"))

    set shift = server.createobject("ADODB.Command")
    shift.activeConnection = MM_Cargo_string

    set update_cmd = server.createobject("ADODB.Command")
    update_cmd.activeConnection = MM_Cargo_string

    'cek tgl skarang dan notiv
    tglNow = date
    notiv = ""
    gagal = ""

    'Split
    datatgl = Split(str,",")
    nip = Split(nip,",")

    'loop data nip dan tanggal
    for i = 0 to ubound(datatgl)

        if session("Server-id") <> 1 then
            if tglNow > cdate(datatgl(i)) then
                notiv = "Pastikan Tanggal Yang di setting tidak mundur"
                Exit For
            end if
        end if

        for x = 0 to ubound(nip)
            jnip = nip(x)
            jtgl = datatgl(i)

                update_cmd.commandText = "SELECT * FROM HRD_T_Shift WHERE Shf_Nip = '"& trim(jnip) &"' AND Shf_tanggal = '"& jtgl &"'"

                set update = update_cmd.execute

                if not update.eof then
                    shift.commandText = "UPDATE HRD_T_Shift SET SH_ID = '"& shiftName &"', Shf_NIP ='"& trim(jnip) &"', Shf_tanggal = '"& jtgl &"', Shf_updateID = '"& session("username") &"' WHERE Shf_NIP ='"& trim(jnip) &"' and Shf_tanggal = '"& jtgl &"'"
                    ' Response.Write shift.commandText
                    shift.execute
                else
                    gagal = "gagal"
                end if
        next
    next

    if notiv <> "" then
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Tanggal Tidak Valid</span><img src='logo/gagal_dakota.PNG'><a href='updateShiftKerja.asp' class='btn btn-primary'>kembali</a></div>"
    elseIf gagal <> "" then
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data tidak terdaftar</span><img src='logo/gagal_dakota.PNG'><a href='updateShiftKerja.asp' class='btn btn-primary'>kembali</a></div>"
    else                    
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Terupdate</span><img src='logo/berhasil_dakota.PNG'><a href='updateShiftKerja.asp' class='btn btn-primary'>kembali</a></div>"
    end if
    
%> 
<!-- #include file='layout/footer.asp' -->