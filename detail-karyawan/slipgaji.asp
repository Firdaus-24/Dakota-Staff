<!-- #include file='../connection.asp' -->
<!-- #include file='../constend/constanta.asp' -->
<% 
dim nip, id
dim slipgaji

nip = Request.QueryString("nip")
id = Request.QueryString("id")
thnlalu = cdate("10/31/2021")

function Ceil(Number)

    Ceil = Int(Number)

    if Ceil <> Number then

        Ceil = Ceil + 1

    end if

end function

set slipgaji = Server.CreateObject("ADODB.Command")
slipgaji.activeConnection = MM_Cargo_String

slipgaji.commandText = "SELECT HRD_T_Salary_Convert.*, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama, HRD_M_Jabatan.Jab_Nama, GLB_M_Agen.Agen_nama, HRD_T_MutasiBPJS.Mut_BPJSKes, HRD_M_Karyawan.Kry_BPJSKesYN FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_M_Karyawan.Kry_Nip = HRD_T_Salary_Convert.Sal_NIp INNER JOIN HRD_M_Jabatan ON HRD_M_Jabatan.Jab_Code = HRD_M_Karyawan.Kry_JabCode INNER JOIN HRD_M_Divisi ON HRD_M_Divisi.Div_Code = HRD_M_Karyawan.Kry_DDBID INNER JOIN GLB_M_Agen ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_agenID LEFT OUTER JOIN HRD_T_MutasiBPJS ON HRD_T_salary_convert.Sal_Nip = HRD_T_MutasiBPJS.Mut_KryNIp WHERE Sal_NIP = '"& nip &"' and Sal_ID = '"& id &"' AND HRD_M_KAryawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y'"
' Response.Write slipgaji.commandText
set slipgaji = slipgaji.execute

if not slipgaji.eof then

    if not slipgaji.eof then
        gapok = slipgaji("Sal_Gapok")
        insentif = slipgaji("Sal_Insentif")
        thr = slipgaji("Sal_THR")
        transport = slipgaji("Sal_TunjTransport")
        kesehatan = slipgaji("Sal_TunjKesehatan") 
        keluarga = slipgaji("Sal_TunjKeluarga")
        jabatan = slipgaji("Sal_TunjJbt")
        asuransi = ceil(slipgaji("Sal_Asuransi"))
        jamsostek = ceil(slipgaji("Sal_Jamsostek"))
        koperasi = slipgaji("Sal_koperasi")
        klaim = slipgaji("Sal_Klaim")
        pph21 = slipgaji("Sal_Pph21")
        absensi = slipgaji("Sal_Absen")
        lain = slipgaji("Sal_Lain")
        insentifPPh21DTP  = slipgaji("Sal_InsentifPPh21DTP")
        pengembalianPot = slipgaji("Sal_PengembalianPot")
    else
        gapok = 0
        insentif = 0
        thr = 0
        transport = 0
        kesehatan = 0
        keluarga = 0
        jabatan = 0
        asuransi = 0 
        jamsostek = 0
        koperasi = 0
        klaim = 0
        pph21 = 0
        absensi = 0
        lain = 0
        insentifPPh21DTP = 0
        pengembalianPot = 0
    end if

    if thnlalu >= slipgaji("Sal_StartDate") then
        if slipgaji("Kry_BPJSKesYN") = "Y" then
        bpjsp = Ceil(4 / 100 * slipgaji("Sal_Gapok"))
        bpjsk = Ceil(1 / 100 * slipgaji("Sal_Gapok"))
        else
            bpjsp = 0 
            bpjsk = 0
        end if
    else
        if slipgaji("Mut_BpjsKes") = "Y" then
            bpjsp = Ceil(4 / 100 * slipgaji("Sal_Gapok"))
            bpjsk = Ceil(1 / 100 * slipgaji("Sal_Gapok"))
        else
            bpjsp = 0 
            bpjsk = 0
        end if
    end if

    totaltnj = gapok + insentif + thr + transport + bpjsp + kesehatan + keluarga + jabatan + asuransi + insentifPPh21DTP + pengembalianPot

    totalpot = jamsostek + bpjsp+ koperasi + klaim + pph21 + asuransi + absensi + lain + bpjsk

    total1 = ceil(totaltnj - totalpot)
    
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SLIPGAJI</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    #download
    {
        display:relative;
    }
    #img-slipgaji
    {
        width:40rem;
        position:absolute;
        margin-top:20px;
        z-index:-1;
        opacity: 0.4;
        filter: alpha(opacity=40); /* For IE8 and earlier */
    }
    .header-slipgaji
    {
        border:1px solid black;
        padding:10px;
        border-radius:5px;
    }
    </style>
    <script src="../js/html2pdf.bundle.js"></script>
    <script>
    
    function generatePDF(){
        let element = document.getElementById('content');
        let logo = document.getElementById('img-slipgaji');
        download.style.display = "none";
        element.style.width = '94%';
        logo.style.width = '60%';
        logo.style.marginLeft = "190px";
        logo.style.marginTop = "80px";
		     
        html2pdf()
        .from(element)
        .save();
    }
    </script>

</head>

<body>
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
                    <th class="text-end"><%=replace(formatCurrency(gapok),"$","")%></th>
                </tr>
                <tr>
                    <th>INSENTIF</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(insentif),"$","")%></th>
                </tr>
                <tr>
                    <th>THR / BONUS</th>
                    <th>:</th>
                    <th style="text-align: right"><%=replace(formatCurrency(thr),"$","")%></th>
                </tr>
                <tr>
                    <th>POT.PENGEMBALIAN</th>
                    <th>:</th>
                    <th style="text-align: right"><%=replace(formatCurrency(pengembalianPot),"$","")%></th>
                </tr>
                <tr>
                    <th>InsentifPPh21</th>
                    <th>:</th>
                    <th style="text-align: right"><%=replace(formatCurrency(insentifPPh21DTP),"$","")%></th>
                </tr>
                <tr>
                    <th>TUNJANGAN</th>
                    <tr>
                        <th>BPJS.P</th>
                        <th>:</th>
                        <th style="text-align: right"><%=replace(formatCurrency(bpjsp),"$","")%></th>
                    </tr>
                    <tr>
                        <th>TRANSPORT</th>
                        <th>:</th>
                        <th style="text-align: right"><%=replace(formatCurrency(transport),"$","")%></th>
                    </tr>
                    <tr>
                        <th>KESEHATAN</th>
                        <th>:</th>
                        <th style="text-align: right"><%=replace(formatCurrency(kesehatan),"$","")%></th>
                    </tr>
                    <tr>
                        <th>KELUARGA</th>
                        <th>:</th>
                        <th style="text-align: right"><%=replace(formatCurrency(keluarga),"$","")%></th>
                    </tr>
                    <tr>
                        <th>JABATAN</th>
                        <th>:</th>
                        <th style="text-align: right"><%=replace(formatCurrency(jabatan),"$","")%></th>
                    </tr>
                    <tr>
                        <th>ASURANSI</th>
                        <th>:</th>
                        <th class="text-end"><%=replace(formatCurrency(asuransi),"$","")%></th>
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
                    <th class="text-end"><%=replace(formatCurrency(jamsostek),"$","")%></th>
                </tr>
                <tr>
                    <th>BPJS.P</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(bpjsp),"$","")%></th>
                </tr>
                <tr>
                    <th>KOPERASI</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(koperasi),"$","")%></th>
                </tr>
                <tr>
                    <th>KLAIM</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(klaim),"$","")%></th>
                </tr>
                <tr>
                    <th>BPJS.K</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(bpjsk),"$","")%></th>
                </tr>
                <tr>
                    <th>PPh21</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(pph21),"$","")%></th>
                </tr>
                <tr>
                    <th>ASURANSI</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(asuransi),"$","")%></th>
                </tr>
                <tr>
                    <th>ABSENSI</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(absensi),"$","")%></th>
                </tr>
                <tr>
                    <th>Lain-Lain</th>
                    <th>:</th>
                    <th class="text-end"><%=replace(formatCurrency(Lain),"$","")%></th>
                </tr>
                <tr class=" bg-secondary text-white">
                <th>TOTAL GAJI</th>
                <th>:</th>
                <th class="text-end"><%=replace(formatCurrency(total1),"$","")%></th>
                </tr>
            </table>
        <!--end body -->
        </div>
    </div>
    <div class='row mt-3'>
        <div class='col'>           
            <button type="button" class="btn btn-primary" id="download" onclick="generatePDF()">Download</button>
        </div>
    </div>
</div>
<% end if %>
<!-- #include file='../layout/footer.asp' -->