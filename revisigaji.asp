<!-- #include file='connection.asp' -->
<% 
bulan = Request.Form("bulan")
tahun = Request.Form("tahun")
p = Request.QueryString("p")
e = Request.QueryString("e")

set gaji_cmd = Server.CreateObject("ADODB.Command")
gaji_cmd.activeConnection = mm_cargo_string

gaji_cmd.commandText = "SELECT HRD_T_Salary_Convert.*, HRD_M_Karyawan.Kry_BPJSKesYN, HRD_M_Karyawan.Kry_BPJSYN, HRD_M_Karyawan.Kry_Nama, HRD_M_karyawan.Kry_TglLahir FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip WHERE Month(Sal_StartDate) = '"& bulan &"' AND year(Sal_StartDate) = '"& tahun &"' AND HRD_M_Karyawan.Kry_AktifYN = 'Y'"
' Response.Write gaji_cmd.commandTExt & "<br>"
set gaji = gaji_cmd.Execute


if bulan <> "" And tahun <> "" then
    if not gaji.eof then
        do until gaji.eof
            umur = dateDiff("yyyy",gaji("Kry_tglLahir"),(date))
            maxumur = 57
            if gaji("Kry_BPJSYN") = "Y" then
                bpjstkjhtk = (gaji("Sal_Gapok") / 100) * 2
                    ' cek umur karyawan
                    if umur >= maxumur then
                        bpjstkjpk = 0
                        bpjsjp = 0
                    else
                        bpjstkjpk = (gaji("Sal_Gapok") / 100) * 1
                        bpjsjp = (gaji("Sal_Gapok") / 100) * 2
                    end if
                bpjstkjkk = gaji("Sal_gapok") / 100 * Cdbl(0.89)
                bpjstkjkm = gaji("Sal_gapok") / 100 * Cdbl(0.30)
            else
                bpjsjp = 0
                bpjstkjhtk = 0 
                bpjstkjpk = 0 
                bpjstkjkk = 0
                bpjstkjkm = 0
            end if

            jamsostek = Cdbl(bpjstkjhtk) + Cdbl(bpjstkjpk)
            asuransi = Cdbl(bpjstkjkk) + Cdbl(bpjsjp) + Cdbl(bpjstkjkm)

            gaji_cmd.commandText = "UPDATE HRD_T_Salary_Convert SET Sal_Jamsostek = "& jamsostek &", Sal_Asuransi = "& asuransi &" WHERE Sal_ID = '"& gaji("Sal_ID") &"' and Sal_Nip ='"& gaji("Sal_Nip") &"'"

            gaji_cmd.execute

        gaji.movenext
        loop 

        Response.Redirect("revisigaji.asp?p=p")
    else
        Response.Redirect("revisigaji.asp?e=e")
    end if 
end if
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BACKDOOR</title>
    <!-- #include file='layout/header.asp' -->
</head>

<body>
<div class='container'>
    <div class='row text-center mt-4'>
        <div class='col'>
            <h3>BACKDOOR</h3>
        </div>
    </div>
    <div class='row'>
        <div class='col-sm-6'>
            <% if p <> "" then %>
                <div class="mb-3">
                    <div class="alert alert-primary alert-dismissible fade show" role="alert">
                        <strong>HORE...!</strong> DATA BERHASIL DI UBAH
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            <% end if %>
            <% if e <> "" then %>
                <div class="mb-3">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>Erorr...!</strong> DATA TIDAK TERDAFTAR
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            <% end if %>
            <form action="revisigaji.asp" method="post">
                <div class="mb-3">
                    <label for="bulan" class="form-label">Bulan</label>
                    <input type="number" class="form-control" id="bulan" name="bulan">
                </div>
                <div class="mb-3">
                    <label for="tahun" class="form-label">Tahun</label>
                    <input type="number" class="form-control" id="tahun" name="tahun">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>  
</div>

<!-- #include file='layout/footer.asp' -->