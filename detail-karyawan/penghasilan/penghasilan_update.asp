<!-- #include file='../../connection.asp' -->
<% 
dim id
dim getsalary
dim bpjs, bpjsjkk, bpjsk, bpjstkjht, bpjstkjkm, bpjstkjp, bpjstkjpk, totaltunjangan, totalpotongan, labelgaji

id = Request.form("id")
p = Request.form("p")
q = Request.form("q")
nip = Request.Form("r")

Function Ceil(p_Number)
    Ceil = 0 - INT( 0 - p_Number)
End Function


set karyawan = Server.CreateObject("ADODB.COmmand")
karyawan.activeConnection = MM_Cargo_String

set getsalary = Server.CreateObject("ADODB.COmmand")
getsalary.activeConnection = MM_Cargo_String

getsalary.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE Sal_ID = '"& id &"' and Sal_Nip = '"& nip &"'"

set getsalary = getsalary.execute

' set umur karyawan 
karyawan.commandText = "SELECT Kry_TglLahir FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
set karyawan = karyawan.execute

umur = int(DateDiff("yyyy",karyawan("Kry_TglLahir"),(date)))
maxumur = int(56)



gapok = CDbl(getsalary("Sal_gapok"))

'set atribut baru yang tidak ada di db tunjangan
bpjs = (gapok / 100) * 4
bpjsk = (gapok / 100) * 1
bpjstkjht = (gapok / 100) * Cdbl(3.7)
bpjsjkk = (gapok / 100) * Cdbl(0.89)
bpjstkjkm = (gapok / 100) * Cdbl(0.30)
bpjstkjpk = (gapok / 100) * 1

if umur >= maxumur then
    bpjstkjp = 0
    bpjstkjpk = 0
else
    bpjstkjp = (gapok / 100) * 2
    bpjstkjpk = (gapok / 100) * 1
end if

tunjanganbpjsjp = (gapok / 100) * 2
potonganbpjstkjhtk = (gapok / 100) * 2

if p = "N" then 
    'make atribut to round or ceil number
    Rbpjstkjht = 0
    Rbpjsjkk = 0
    Rbpjstkjkm = 0
    Rbpjstkjp = 0
    Rbpjstkjpk = 0
    Rtunjanganbpjsjp = 0

    Cbpjstkjht = 0
    Cbpjsjkk = 0
    Cbpjstkjkm = 0
    Cbpjstkjp = 0
    Cbpjstkjpk = 0
    Ctunjanganbpjsjp = 0
    koperasi = 0
    Cbpjstkjhtk = 0

    totaltunjangan = 0
    labelgaji = gapok 
else
    'make atribut to round or ceil number
    Rbpjstkjht = Round(bpjstkjht)
    Rbpjsjkk = Round(bpjsjkk)
    Rbpjstkjkm = Round(bpjstkjkm)
    Rbpjstkjp = Round(bpjstkjp)
    Rbpjstkjpk = Round(bpjstkjpk)
    Rtunjanganbpjsjp = Round(tunjanganbpjsjp)

    Cbpjstkjht = Ceil(bpjstkjht)
    Cbpjsjkk = Ceil(bpjsjkk)
    Cbpjstkjkm = Ceil(bpjstkjkm)
    Cbpjstkjp = Ceil(bpjstkjp)
    Cbpjstkjpk = Ceil(bpjstkjpk)
    Ctunjanganbpjsjp = Ceil(tunjanganbpjsjp)
    koperasi = Cdbl(getsalary("Sal_Koperasi"))
    Cbpjstkjhtk = Round(potonganbpjstkjhtk)
end if

if q = "N" then 
    Rbpjs = 0
    Rbpjsk = 0
    Cbpjs = 0
    Cbpjsk = 0
else 
    Rbpjs = Round(bpjs)
    Rbpjsk = Round(bpjsk)
    Cbpjs = Ceil(bpjs)
    Cbpjsk = Ceil(bpjsk)
end if

totaltunjangan = Rbpjs + Round(bpjstkjp) + Rbpjsjkk + Cbpjstkjkm + Rbpjstkjht + getsalary("Sal_TunjKesehatan") + getsalary("Sal_TunjJbt") + getsalary("Sal_TunjTransport") + getsalary("Sal_TunjKeluarga")  

'set atribut untuk potongan
totalpotongan = Round(bpjstkjp) + Round(bpjstkjpk) + Round(bpjs) + Round(bpjsk) + koperasi + getsalary("Sal_Klaim") + getsalary("Sal_absen") + getsalary("Sal_lain") + getsalary("Sal_pph21") + Round(bpjstkjht) + Round(bpjsjkk) + Round(bpjstkjkm) + Cbpjstkjhtk

labelgaji = gapok + getsalary("Sal_Insentif") + getsalary("Sal_THR") + getsalary("Sal_PengembalianPot") + getsalary("Sal_InsentifPPh21DTP") + totaltunjangan - totalpotongan
                                                     
dim data(42)

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
data(12)= koperasi
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
data(39)= nip
data(40)= Cbpjstkjhtk
data(41)= getsalary("Sal_PengembalianPot")
data(42)= getsalary("Sal_InsentifPPh21DTP")


' Response.Write  totaltunjangan & "<br>"
for each x in data
    Response.Write (x) &","
Next
 %>