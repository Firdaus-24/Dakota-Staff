<!-- #include file='../connection.asp' -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DONE</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<% 
dim karyawan, salary, blna, blne, tgl, tgla, ptgla, key
dim karyawangaji
dim karyawan_aktif

'definisi bulan yang akan di tambahkan
tglNow = month(now) &"/" & day(now) &"/"& year(now)

set gaji2bln = Server.CreateObject("ADODB.Command")
gaji2bln.activeConnection = MM_Cargo_string

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.activeConnection = MM_Cargo_string

' tampilkan smua karyawan aktif
set karyawan_aktif = Server.CreateObject("ADODB.Command")
karyawan_aktif.activeConnection = MM_Cargo_string

karyawan_aktif.commandText = "SELECT Kry_Nip FROM HRD_M_Karyawan WHERE Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE '%A%' AND Kry_AktifYN = 'Y' AND DateDiff(day,Kry_TglMasuk,getDate()) > 30 AND Kry_TglKeluar = '' ORDER BY Kry_Nip"
' Response.Write karyawan_aktif.commandText & "<br>"
set karyawanAktif = karyawan_aktif.execute

key = ""
do until karyawanAktif.eof
    karyawan.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE month(Sal_StartDate) = '"& month(now()) &"' and year(Sal_StartDate) = '"& year(now()) &"' and Sal_AktifYN = 'Y' AND Sal_Nip = '"& karyawanAktif("Kry_Nip") &"' "
    ' response.write karyawan.commandText & "<BR>"
    set salary = karyawan.execute

    if salary.eof then
        if month(now()) = 1 then
            tahunGajisblm = year(now()) - 1
            bulanGajiSblm = 12
        else
            tahunGajisblm = year(now())
            bulanGajiSblm = month(now()) - 1
        end if

        karyawan.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE year(Sal_StartDate) = '"& tahunGajisblm &"' and month(Sal_StartDate) = '"& bulanGajiSblm &"' and Sal_AktifYN = 'Y' and Sal_Nip = '"& karyawanAktif("Kry_Nip") &"' "
        ' Response.Write karyawan.commandTExt & "<br>"
        set karyawangaji = karyawan.execute

            if karyawangaji.eof then

                    karyawan.commandText = "SELECT TOP 1.* FROM HRD_T_Salary_Convert WHERE Sal_AktifYN = 'Y' and Sal_Nip = '"& karyawanAktif("Kry_Nip") &"' ORDER BY Sal_StartDate DESC"
                    ' Response.Write karyawan.commandText
                    set akaryawangaji = karyawan.execute
                    
                    if not akaryawangaji.eof then
                        key=left(akaryawangaji("sal_nip"),3) & right("00" & month(date),2) & right(year(date),2)

                        karyawan.commandText = "exec sp_AddHRD_T_Salary_Convert '"& key &"','"& akaryawangaji("Sal_Nip") &"','"& tglNow &"', '"& akaryawangaji("Sal_Gapok") &"', '0', '', '"& akaryawangaji("Sal_TunjTransport") &"', '"& akaryawangaji("Sal_TunjKesehatan") &"', '0', '"& akaryawangaji("Sal_TunjJbt") &"', '"& akaryawangaji("Sal_Jamsostek") &"', '"& akaryawangaji("Sal_PPh21") &"', '"& akaryawangaji("Sal_Pinjaman") &"', '"& akaryawangaji("Sal_Koperasi") &"', '0', '"& akaryawangaji("Sal_asuransi") &"', '', '0', '0', '"& akaryawangaji("Sal_Catatan") &"', '0','0','0'"

                        karyawan.execute
                    end if
            else
                key=left(karyawangaji("sal_nip"),3) & right("00" & month(date),2) & right(year(date),2)

                karyawan.commandText = "exec sp_AddHRD_T_Salary_Convert '"& key &"','"& karyawangaji("Sal_Nip") &"','"& tglNow &"', '"& karyawangaji("Sal_Gapok") &"', '0', '', '"& karyawangaji("Sal_TunjTransport") &"', '"& karyawangaji("Sal_TunjKesehatan") &"', '0', '"& karyawangaji("Sal_TunjJbt") &"', '"& karyawangaji("Sal_Jamsostek") &"', '"& karyawangaji("Sal_PPh21") &"', '"& karyawangaji("Sal_Pinjaman") &"', '"& karyawangaji("Sal_Koperasi") &"', '0', '"& karyawangaji("Sal_asuransi") &"', '', '0', '0', '"& karyawangaji("Sal_Catatan") &"', '0','0','0'"

                karyawan.execute

            end if
    end if

karyawanAktif.movenext
loop
    ' jika sudah selesai di jalankan
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/dashboard.asp' class='btn btn-primary'>kembali</a></div>"

 %>
 <!-- #include file='../layout/footer.asp' -->