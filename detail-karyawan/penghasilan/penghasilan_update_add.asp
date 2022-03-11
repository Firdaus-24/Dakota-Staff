<!-- #include file='../../connection.asp' -->
<!--#include file="../../layout/header.asp"-->
<% 
dim tgl, gapok, thr, insentif, bpjs, transport, kesehatan, keluarga, jabatan, makan, bpjstkjp, ttunjangan, bpjstkjht, bpjsp, koperasi, klaim, bpjsk, potabsen, lain, bpjsjkk, tpot, bpjsjp, nip
dim gaji, tampilgaji

nip = Request.form("nip")
tgl = Request.Form("tgl")

function Ceil(Number)

    Ceil = Int(Number)

    if Ceil <> Number then

        Ceil = Ceil + 1

    end if

end function

gapok = replace(replace(Request.Form("gapok"),".",""),",-","")
insentif = replace(replace(Request.Form("insentif"),".",""),",-","")
thr = replace(replace(Request.Form("thr"),".",""),",-","")
potpengembalian = replace(replace(Request.Form("potpengembalian"),".",""),",-","")
insentifDTP = replace(replace(Request.Form("insentifDTP"),".",""),",-","")


bpjs = replace(replace(Request.Form("bpjs"),".",""),",-","")
bpjstkjkk = replace(replace(Request.Form("bpjstkjkk"),".",""),",-","")
bpjstkjkm = replace(replace(Request.Form("bpjstkjkm"),".",""),",-","")
bpjsjp = replace(replace(Request.Form("bpjsjp"),".",""),",-","")
bpjsjht = replace(replace(Request.Form("bpjsjht"),".",""),",-","")
transport = replace(replace(Request.Form("transport"),".",""),",-","")
kesehatan = replace(replace(Request.Form("kesehatan"),".",""),",-","")
keluarga = replace(replace(Request.Form("keluarga"),".",""),",-","")
jabatan = replace(replace(Request.Form("jabatan"),".",""),",-","")
' makan = replace(replace(Request.Form("makan"),".",""),",-","")
ttunjangan = replace(replace(Request.Form("ttunjangan"),".",""),",-","")
bpjstkjht = replace(replace(Request.Form("bpjstkjht"),".",""),",-","")
bpjstkjhtk = replace(replace(Request.Form("bpjstkjhtk"),".",""),",-","")
bpjsjkk = replace(replace(Request.Form("bpjsjkk"),".",""),",-","")
bpjstkjp = replace(replace(Request.Form("bpjstkjp"),".",""),",-","")
bpjstkjpk = replace(replace(Request.Form("bpjstkjpk"),".",""),",-","")
potbpjstkjkm = replace(replace(Request.Form("potbpjstkjkm"),".",""),",-","")
bpjsk = replace(replace(Request.Form("bpjsk"),".",""),",-","")
bpjsp = replace(replace(Request.Form("bpjsp"),".",""),",-","")
koperasi = replace(replace(Request.Form("koperasi"),".",""),",-","")
klaim = replace(replace(Request.Form("klaim"),".",""),",-","")
potabsen = replace(replace(Request.Form("potabsen"),".",""),",-","")
lain = replace(replace(Request.Form("lain"),".",""),",-","")
potpph21 = replace(replace(Request.Form("potpph21"),".",""),",-","")
tpot = replace(replace(Request.Form("tpot"),".",""),",-","")
labelGaji = replace(replace(Request.Form("labelGaji"),".",""),",-","")
catatan = Request.Form("catatan")
'pinjaman = shakeNumber(replace(replace(Request.Form("pinjaman"),".",""),",-","")))
key=Request.Form("nomor")

'jumlahkan
jamsostek = Ceil(Cdbl(bpjstkjhtk) + Cdbl(bpjstkjpk))
asuransi = Ceil(Cdbl(bpjstkjkk) + Cdbl(bpjsjp) + Cdbl(bpjstkjkm))


set gaji = Server.CreateObject("ADODB.Command")
gaji.activeConnection = MM_Cargo_String

gaji.commandText = "UPDATE HRD_T_Salary_Convert SET Sal_StartDate = '"& tgl &"', Sal_gapok = '"& gapok &"', Sal_Insentif = '"& insentif &"', Sal_TunjTransport = '"& transport &"', Sal_TunjKesehatan = '"& kesehatan &"', Sal_TunjKeluarga = '"& keluarga &"', Sal_TunjJbt = '"& jabatan &"', Sal_Jamsostek = '"& jamsostek &"', Sal_PPh21 = '"& potpph21 &"', Sal_Pinjaman = '"& pinjaman &"', Sal_Koperasi = '"& koperasi &"', Sal_Klaim = '"& klaim &"', Sal_Asuransi = '"& asuransi &"', Sal_Absen = '"& potabsen &"', Sal_Lain = '"& lain &"', Sal_catatan = '"& catatan &"', Sal_THR = '"& thr &"', Sal_PengembalianPot = '"& potpengembalian &"', Sal_InsentifPPh21DTP = '"& insentifDTP &"' WHERE Sal_ID = '"& key &"' and Sal_Nip ='"& nip &"'"
' Response.Write gaji.commandText
gaji.execute
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='../penghasilan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"


 %>
<!-- #include file='../../layout/footer.asp' -->