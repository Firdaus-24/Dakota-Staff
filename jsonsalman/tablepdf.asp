<!-- #include file='../connection.asp' -->
<%
 
dim nip, id
dim slipgaji

nip = Request.QueryString("nip")
id = Request.QueryString("id")

set slipgaji = Server.CreateObject("ADODB.Command")
slipgaji.activeConnection = MM_Cargo_String

slipgaji.commandText = "SELECT HRD_T_Salary_Convert.*, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama, HRD_M_Jabatan.Jab_Nama, GLB_M_Agen.Agen_nama FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_M_Karyawan.Kry_Nip = HRD_T_Salary_Convert.Sal_NIp INNER JOIN HRD_M_Jabatan ON HRD_M_Jabatan.Jab_Code = HRD_M_Karyawan.Kry_JabCode INNER JOIN HRD_M_Divisi ON HRD_M_Divisi.Div_Code = HRD_M_Karyawan.Kry_DDBID INNER JOIN GLB_M_Agen ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_activeAgenID WHERE Sal_NIP = '"& nip &"' and Sal_ID = '"& id &"'"
Response.Write slipgaji.commandText
set slipgaji = slipgaji.execute

gapok1 = FormatCurrency(round(slipgaji("Sal_Gapok")))
insentif1 = FormatCurrency(round(slipgaji("Sal_Insentif")))
thr1 = FormatCurrency(round(slipgaji("Sal_THR")))
transport1 = FormatCurrency(round(slipgaji("Sal_TunjTransport")))
kesehatan1 = FormatCurrency(round(slipgaji("Sal_TunjKesehatan"))) 
keluarga1 = FormatCurrency(round(slipgaji("Sal_TunjKeluarga")))
jabatan1 = FormatCurrency(round(slipgaji("Sal_TunjJbt")))
asuransi1 = FormatCurrency(round(slipgaji("Sal_Asuransi")))
jamsostek1 = FormatCurrency(round(slipgaji("Sal_Jamsostek")))
koperasi1 = FormatCurrency(round(slipgaji("Sal_koperasi")))
klaim1 = FormatCurrency(round(slipgaji("Sal_Klaim")))
pph211 = FormatCurrency(round(slipgaji("Sal_Pph21")))
absensi1 = FormatCurrency(round(slipgaji("Sal_Absen")))
lain1 = FormatCurrency(round(slipgaji("Sal_Lain")))

gapok = (Replace(gapok1,"$","Rp."))
insentif = (Replace(insentif1,"$","Rp."))
thr = (Replace(thr1,"$","Rp."))
transport = (Replace(transport1,"$","Rp."))
kesehatan =  (Replace(kesehatan1,"$","Rp."))
keluarga =  (Replace(keluarga1,"$","Rp."))
jabatan =  (Replace(jabatan1,"$","Rp."))
asuransi =  (Replace(asuransi1,"$","Rp."))
jamsostek = (Replace(jamsostek1,"$","Rp."))
koperasi = (Replace(koperasi1,"$","Rp."))
klaim = (Replace(klaim1,"$","Rp."))
Pph21 = (Replace(pph211,"$","Rp."))
absensi = (Replace(absensi1,"$","Rp."))
lain = (Replace(lain1,"$","Rp."))

bpjsp1 = slipgaji("Sal_Gapok")

bpjsp2 = 4 / 100 * bpjsp1
bpjsk2 = 1 / 100 * bpjsp1

totaltnj = Cdbl(slipgaji("Sal_Gapok")) + Cdbl(slipgaji("Sal_Insentif")) + Cdbl(slipgaji("Sal_THR")) + Cdbl(slipgaji("Sal_TunjTransport")) + bpjsp2 + Cdbl(slipgaji("Sal_TunjKesehatan")) + Cdbl(slipgaji("Sal_TunjKeluarga")) + Cdbl(slipgaji("Sal_TunjJbt")) + Cdbl(slipgaji("Sal_Asuransi"))

totalpot = Cdbl(slipgaji("Sal_Jamsostek")) + bpjsp2 + Cdbl(slipgaji("Sal_koperasi")) + Cdbl(slipgaji("Sal_Klaim")) + Cdbl(slipgaji("Sal_Pph21")) + Cdbl(slipgaji("Sal_Asuransi")) + Cdbl(slipgaji("Sal_Absen")) + Cdbl(slipgaji("Sal_Lain")) + bpjsk2

total1 = totaltnj - totalpot
total = FormatCurrency(round(total1))
totalgapok = (Replace(total,"$","Rp."))

bpjsp3 = FormatCurrency(round(bpjsp2))
bpjsk3 = FormatCurrency(round(bpjsk2))

bpjsp = (Replace(bpjsp3,"$","Rp."))
bpjsk = (Replace(bpjsk3,"$","Rp."))

 %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>slipgaji</title>
    <!-- #include file='../layout/header.asp' -->
    
</head>

<body>

</body>

<div class='container position-relative' id='content'>
    <div class='row'>
    <img src="../logo/landing.png" id="img-slipgaji" class="position-absolute top-50 start-50 translate-middle" >
        <div class='col header-slipgaji mt-5'>
        <!--header -->
            <table align="left" cellpadding="2" cellspacing="0">
                <tr>
                    <th>NIP</th>
                    <th>:</th>
                    <th><%=slipgaji("Kry_NIp")%></th>
                </tr>
                <tr>
                    <th>NAMA</th>
                    <th>:</th>
                    <th><%=slipgaji("Kry_Nama")%></th>
                </tr>
                <tr>
                    <th>JABATAN</th>
                    <th>:</th>
                    <th><%=slipgaji("Jab_Nama")%></th>
                </tr>
            </table>
            <table align="right" cellpadding="2" cellspacing="0">
                <tr>
                    <th>PRIODE GAJI</th>
                    <th>:</th>
                    <th><%=slipgaji("Sal_StartDate")%></th>
                </tr>
                <tr>
                    <th>DIVISI</th>
                    <th>:</th>
                    <th><%=slipgaji("Div_Nama")%></th>
                </tr>
                <tr>
                    <th>AREA KERJA</th>
                    <th>:</th>
                    <th><%=slipgaji("agen_Nama")%></th>
                </tr>
            </table>
        <!--end header -->
        </div>
    </div>
    <div class='row mt-5'>
        <div class='col'>
            <!--body -->
            <table align="left" cellpadding="2" cellspacing="0" width="30%">
                <tr>
                    <th>GAJI POKOK</th>
                    <th>:</th>
                    <th class="text-end"><%=gapok%></th>
                </tr>
                <tr>
                    <th>INSENTIF</th>
                    <th>:</th>
                    <th class="text-end"><%=insentif%></th>
                </tr>
                <tr>
                    <th>THR / BONUS</th>
                    <th>:</th>
                    <th style="text-align: right"><%=thr%></th>
                </tr>
                <tr>
                    <th>TUNJANGAN</th>
                    <tr>
                        <th>BPJS.P</th>
                        <th>:</th>
                        <th style="text-align: right"><%=bpjsp%></th>
                    </tr>
                    <tr>
                        <th>TRANSPORT</th>
                        <th>:</th>
                        <th style="text-align: right"><%=transport%></th>
                    </tr>
                    <tr>
                        <th>KESEHATAN</th>
                        <th>:</th>
                        <th style="text-align: right"><%=kesehatan%></th>
                    </tr>
                    <tr>
                        <th>KELUARGA</th>
                        <th>:</th>
                        <th style="text-align: right"><%=keluarga%></th>
                    </tr>
                    <tr>
                        <th>JABATAN</th>
                        <th>:</th>
                        <th style="text-align: right"><%=jabatan%></th>
                    </tr>
                    <tr>
                        <th>ASURANSI</th>
                        <th>:</th>
                        <th class="text-end"><%=asuransi%></th>
                    </tr>
                    <tr class=" bg-secondary text-white">
                        <th>CETAK</th>
                        <th>:</th>
                        <th class="text-end"><%=Now()%></th>
                    </tr>
                </tr>
            </table>
            <table align="Right" cellpadding="2" cellspacing="0" width="30%">
                <tr>
                    <th>POTONGAN</th>
                </tr>
                <tr>
                    <th>JAMSOSTEK</th>
                    <th>:</th>
                    <th class="text-end"><%=jamsostek%></th>
                </tr>
                <tr>
                    <th>BPJS.P</th>
                    <th>:</th>
                    <th class="text-end"><%=bpjsp%></th>
                </tr>
                <tr>
                    <th>KOPERASI</th>
                    <th>:</th>
                    <th class="text-end"><%=koperasi%></th>
                </tr>
                <tr>
                    <th>KLAIM</th>
                    <th>:</th>
                    <th class="text-end"><%=klaim%></th>
                </tr>
                <tr>
                    <th>BPJS.K</th>
                    <th>:</th>
                    <th class="text-end"><%=bpjsk%></th>
                </tr>
                <tr>
                    <th>PPh21</th>
                    <th>:</th>
                    <th class="text-end"><%=pph21%></th>
                </tr>
                <tr>
                    <th>ASURANSI</th>
                    <th>:</th>
                    <th class="text-end"><%=asuransi%></th>
                </tr>
                <tr>
                    <th>ABSENSI</th>
                    <th>:</th>
                    <th class="text-end"><%=absensi%></th>
                </tr>
                <tr>
                    <th>Lain-Lain</th>
                    <th>:</th>
                    <th class="text-end"><%=Lain%></th>
                </tr>
                <tr class=" bg-secondary text-white">
                <th>TOTAL GAJI</th>
                <th>:</th>
                <th class="text-end"><%=totalgapok%></th>
                </tr>
            </table>
        <!--end body -->
        </div>
    </div>
<!-- #include file='../layout/footer.asp' -->