<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<% 
cabang = Cint(trim(Request.Form("agen")))
nip = trim(Request.Form("nip"))
kes = Request.Form("kes")
ket = Request.Form("ket")
tgl = Cdate(Request.Form("tgl"))
updateid = trim(Request.Form("updateid"))

if ket = "" then
    ket = "N"
end if
if kes = "" then
    kes = "N"
end if

set karyawan_cmd = Server.CreateObject("ADODB.COmmand")
karyawan_cmd.activeConnection = mm_cargo_string

set area = Server.CreateObject("ADODB.COmmand")
area.activeConnection = mm_cargo_string

area.commandText = "SELECT Kry_AgenID, Kry_Nip FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"' AND Kry_AktifYN = 'Y'"
set karyawan = area.execute

if karyawan.eof then
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Nip Tidak Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='"& url &"/bpjs/index.asp' class='btn btn-primary'>kembali</a></div>"
else
    if cabang = karyawan("Kry_AgenID") then
        area.commandText = "SELECT * FROM HRD_T_MutasiBPJS WHERE Mut_KRYNip = '"& nip &"' AND month(Mut_Tanggal) = '"& month(tgl) &"' AND year(Mut_tanggal) = '"& year(tgl) &"' AND Mut_AktifYN = 'Y'"
        ' Response.Write area.commandText & "<br>"
        set mutasibpjs = area.execute

        if mutasibpjs.eof then
            area.commandText = "exec sp_ADDHRD_T_MutasiBPJS "& cabang &",'"& nip &"','"& kes &"','"& ket &"','"& tgl &"','"& updateid &"'"
            ' Response.Write area.commandText & "<br>"
            area.execute

            karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_BPJSKesYN = '"& kes &"', Kry_BPJSYN = '"& ket &"' WHERE Kry_Nip = '"& nip &"'"
            ' Response.Write karyawan_cmd.commandText & "<br>"
            karyawan_cmd.execute
            Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/bpjs/index.asp' class='btn btn-primary'>kembali</a></div>"
        else
            if month(tgl) = month(mutasibpjs("Mut_Tanggal")) And year(tgl) = year(mutasibpjs("Mut_Tanggal")) then
                area.commandText = "UPDATE HRD_T_MutasiBPJS SET Mut_BPJSKes = '"& kes &"', Mut_BPJSKet = '"& ket &"', Mut_Tanggal = '"& tgl &"', Mut_UpdateID = '"& updateid &"' WHERE Mut_KryNip = '"& nip &"'"
                ' Response.Write area.commandText & "<br>"
                area.execute

                karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_BPJSKesYN = '"& kes &"', Kry_BPJSYN = '"& ket &"' WHERE Kry_Nip = '"& nip &"'"
                ' Response.Write karyawan_cmd.commandText & "<br>"
                karyawan_cmd.execute
                Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Berhasil Diubah</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/bpjs/index.asp' class='btn btn-primary'>kembali</a></div>"
            else
                Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='"& url &"/bpjs/index.asp' class='btn btn-primary'>kembali</a></div>"
            end if
        end if
    else
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Agen Tidak Valid</span><img src='../logo/gagal_dakota.PNG'><a href='"& url &"/bpjs/index.asp' class='btn btn-primary'>kembali</a></div>"
    end if
end if
 %>
<!-- #include file='../layout/footer.asp' -->