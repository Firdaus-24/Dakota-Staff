<!-- #include file='connection.asp' -->
<%
    function done(e)
        if e > 0 then
            Response.Write "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>Well done!</h4><p>Aww yeah, DATA BPJS SUDAH TERUPDATE</p><hr><p class='mb-0'>Lakukan Kembali untuk aktifasi agen/cabang yang belum terdaftar</p></div>"
        end if
    end function

    agen = Request.Form("agen")

    set bpjs_cmd = Server.CreateObject("ADODB.COmmand")
    bpjs_cmd.ActiveConnection = MM_Cargo_string
        
    set bpjs_add = Server.CreateObject("ADODB.COmmand")
    bpjs_add.ActiveConnection = MM_Cargo_string

    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.ActiveConnection = MM_Cargo_string

    if agen <> "" then
        karyawan_cmd.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_AktifYN = 'Y' AND Kry_tglKeluar = '' AND kry_AgenID = '"& agen &"'"
        set karyawan = karyawan_cmd.execute

        no = 0
        do while not karyawan.eof 
            bpjs_cmd.commandText = "SELECT * FROM HRD_T_MutasiBPJS WHERE Mut_KryNIP = '"& karyawan("Kry_Nip") &"' "
            set bpjs = bpjs_cmd.execute

            if bpjs.eof then
                no  = no + 1
                bpjs_add.commandText = "exec sp_ADDHRD_T_MutasiBPJS "& karyawan("Kry_Pegawai") &",'"& karyawan("Kry_Nip") &"','"& karyawan("Kry_BPJSKesYN") &"','"& karyawan("Kry_bpjsYN") &"','"& date &"','"& session("username") &"'"
                bpjs_add.execute
            end if
        karyawan.movenext
        loop
    end if

    set agen_cmd = Server.CreateObject("ADODB.Command")
    agen_cmd.ActiveConnection = MM_Cargo_string

    agen_cmd.commandText = "SELECT GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_Agenid = GLB_M_Agen.Agen_ID WHERE GLB_M_agen.Agen_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_TglKeluar = '' AND GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%' GROUP BY GLB_M_Agen.AGen_ID, GLB_M_Agen.Agen_Nama ORDER BY GLB_M_Agen.Agen_Nama ASC"
    set agen = agen_cmd.execute

%>
<!-- #include file='layout/header.asp' -->
<div class="container">
<%= done(no) %>
    <form method="post" action="back_aktifasi_bpjs.asp">
        <div class="mb-3 row mt-3">
            <label class="col-sm-2 col-form-label">pilih agen</label>
            <div class="col-sm-10">
            <select class="form-select" aria-label="Default select example" name="agen" id="agen">
                <option value="">Open this select menu</option>
                <%do while not agen.eof%>
                    <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                <%
                    agen.movenext
                    loop
                %>
            </select>
            </div>
        </div>
            <button class="btn btn-primary" type="submit">submit</button>
    </form>
</div>
<!-- #include file='layout/footer.asp' -->