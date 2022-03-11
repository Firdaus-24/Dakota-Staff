<!-- #include file="../../connection.asp"-->
<% 
dim nip, tgl
dim getsalary
dim bpjs, bpjsjkk, bpjsk, bpjstkjht, bpjstkjkm, bpjstkjp, bpjstkjpk, totaltunjangan, totalpotongan, labelgaji


nip = Request.form("id")
tgla = DateAdd("h",1,month(now) - 1 & "/"& "1/"& year(Now))
tgl = month(now) - 1 &"/" & day(31) &"/"& year(now)
id = Request.QueryString("nip")

ptgla = Cdate(tgla)

Function Ceil(p_Number)
    Ceil = 0 - INT( 0 - p_Number)
End Function


set getsalary = Server.CreateObject("ADODB.COmmand")
getsalary.activeConnection = MM_Cargo_String

getsalary.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& nip &"' and Sal_AktifYN = 'Y' and Sal_StartDate BETWEEN '"& ptgla &"' and '"& tgl &"'"
'Response.Write getsalary.commandText
set getsalary = getsalary.execute

gapok = CDbl(getsalary("Sal_gapok"))

'set atribut baru yang tidak ada di db tunjangan
bpjs = gapok / 100 * 4
bpjsk = gapok / 100 * 1
bpjstkjht = gapok / 100 * 2
bpjsjkk = gapok / 100 * Cdbl(0.89)
bpjstkjkm = gapok / 100 * Cdbl(0.30)
bpjstkjp = gapok / 100 * 2
bpjstkjpk = gapok / 100 * 1
tunjanganbpjsjp = gapok / 100 * 2

'make atribut to round or ceil number
Rbpjs = Round(bpjs)
Rbpjsk = Round(bpjsk)
Rbpjstkjht = Round(bpjstkjht)
Rbpjsjkk = Round(bpjsjkk)
Rbpjstkjkm = Round(bpjstkjkm)
Rbpjstkjp = Round(bpjstkjp)
Rbpjstkjpk = Round(bpjstkjpk)
Rtunjanganbpjsjp = Round(tunjanganbpjsjp)

Cbpjs = Ceil(bpjs)
Cbpjsk = Ceil(bpjsk)
Cbpjstkjht = Ceil(bpjstkjht)
Cbpjsjkk = Ceil(bpjsjkk)
Cbpjstkjkm = Ceil(bpjstkjkm)
Cbpjstkjp = Ceil(bpjstkjp)
Cbpjstkjpk = Ceil(bpjstkjpk)
Ctunjanganbpjsjp = Ceil(tunjanganbpjsjp)

totaltunjangan = Rbpjs + Ctunjanganbpjsjp + Rbpjsjkk + Cbpjstkjkm + Rbpjstkjht + getsalary("Sal_TunjKesehatan") + getsalary("Sal_TunjJbt") + getsalary("Sal_TunjTransport") + getsalary("Sal_TunjKeluarga")  

'set atribut untuk potongan
totalpotongan = Rbpjstkjht + getsalary("Sal_Koperasi") + Rbpjsk + getsalary("Sal_lain") + Cbpjsjkk + Cbpjs + getsalary("Sal_Klaim") + getsalary("Sal_absen") + getsalary("Sal_pph21") + Rbpjstkjp + Cbpjstkjkm + Rbpjstkjpk + Rbpjstkjht

labelgaji = gapok + getsalary("Sal_Insentif") + getsalary("Sal_THR") + totaltunjangan - totalpotongan

dim data(38)

data(0)= getsalary("Sal_ID")
data(1)= getsalary("Sal_Nip")
data(2)= getsalary("Sal_StartDate")
data(3)= getsalary("Sal_Insentif") 
data(4)= getsalary("Sal_TunjMakan") 
data(5)= getsalary("Sal_TunjTransport") 
data(6)= getsalary("Sal_TunjKesehatan")
data(7)= getsalary("Sal_TunjKeluarga")
data(8)= getsalary("Sal_TunjJbt")
data(9)= getsalary("Sal_jamsostek")
data(10)= getsalary("Sal_PPh21")
data(11)= getsalary("Sal_Pinjaman")
data(12)= getsalary("Sal_Koperasi")
data(13)= getsalary("Sal_Klaim")
data(14)= getsalary("Sal_Asuransi")
data(15)= getsalary("Sal_Persekot")
data(16)= getsalary("Sal_absen")
data(17)= getsalary("Sal_Lain")
data(18)= getsalary("Sal_catatan")
data(19)= getsalary("Sal_AktifYN")
data(20)= getsalary("Sal_THR")
data(21)= gapok
data(22)= totaltunjangan
data(23)= Rbpjs
data(24)= Cbpjs
data(25)= Rbpjsk
data(26)= Cbpjsk
data(27)= Rbpjstkjht
data(28)= Cbpjstkjht
data(29)= Rbpjsjkk
data(30)= Cbpjsjkk
data(31)= Rbpjstkjkm
data(32)= Cbpjstkjkm
data(33)= Rbpjstkjp
data(34)= Cbpjstkjp
data(35)= Rbpjstkjpk
data(36)= Cbpjstkjpk
data(37)= totalpotongan
data(38)= labelgaji

Response.Write  totaltunjangan & "<br>"
for each x in data
    Response.Write (x) &","
Next

 %>