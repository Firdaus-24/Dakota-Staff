<!-- #include file='../connection.asp' -->
<!--#include file="../layout/header.asp"-->
<%

function Ceil(Number)

    Ceil = Int(Number)

    if Ceil <> Number then

        Ceil = Ceil + 1

    end if

end function

dim tgl, gapok, thr, insentif, bpjs, transport, kesehatan, keluarga, jabatan, makan, bpjstkjp, ttunjangan, bpjstkjht, bpjsp, koperasi, klaim, bpjsk, potabsen, lain, bpjsjkk, tpot, bpjsjp, nip
dim gaji, tampilgaji

nip = Request.form("nip")
tgl = Request.Form("tgl")

gapok = replace(replace(Request.Form("gapok"),".",""),",-","")
insentif = replace(replace(Request.Form("insentif"),".",""),",-","")
thr = replace(replace(Request.Form("thr"),".",""),",-","")
potpengembalian = replace(replace(Request.Form("potpengembalian"),".",""),",-","")
insentfDTP = replace(replace(Request.Form("insentfDTP"),".",""),",-","")

bpjs = replace(replace(Request.Form("bpjs"),".",""),",-","")
bpjstkjkk = replace(replace(Request.Form("bpjstkjkk"),".",""),",-","")
bpjstkjkm = replace(replace(Request.Form("bpjstkjkm"),".",""),",-","")
bpjsjp = replace(replace(Request.Form("bpjsjp"),".",""),",-","")
bpjsjht = replace(replace(Request.Form("bpjsjht"),".",""),",-","")
bpjstkjhtk = replace(replace(Request.Form("bpjstkjhtk"),".",""),",-","")
transport = replace(replace(Request.Form("transport"),".",""),",-","")
kesehatan = replace(replace(Request.Form("kesehatan"),".",""),",-","")
keluarga = replace(replace(Request.Form("keluarga"),".",""),",-","")
jabatan = replace(replace(Request.Form("jabatan"),".",""),",-","")
ttunjangan = replace(replace(Request.Form("ttunjangan"),".",""),",-","")

bpjstkjht = replace(replace(Request.Form("bpjstkjht"),".",""),",-","")
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
key=left(nip,3) & right("00" & month(date),2) & right(year(date),2)

'jumlahkan
jamsostek = ceil(Cdbl(bpjstkjhtk) + Cdbl(bpjstkjpk))
asuransi = ceil(Cdbl(bpjstkjkk) + Cdbl(bpjsjp) + Cdbl(bpjstkjkm))


set gaji = Server.CreateObject("ADODB.Command")
gaji.activeConnection = MM_Cargo_String

gaji.commandText = "SELECT * FROM HRD_T_Salary_convert WHERE Month(Sal_StartDate) = '"& month(tgl) &"' AND Year(Sal_startDate) = '"& year(tgl) &"' AND Sal_Nip = '"& nip &"'"
set pgaji = gaji.execute

if pgaji.eof then
    gaji.commandText = "exec sp_AddHRD_T_Salary_Convert '"& key &"','"& nip &"','"& tgl &"', '"& gapok &"', '"& insentif &"', '', '"& transport &"', '"& kesehatan &"', '"& keluarga &"', '"& jabatan &"', '"& jamsostek &"', '"& potpph21 &"', '', '"& koperasi &"', '"& klaim &"', '"& asuransi &"', '', '"& potabsen &"', '"& lain &"', '"& catatan &"', '"& thr &"', '"& potpengembalian &"', '"& insentifDTP &"'"
    ' Response.Write gaji.commandText
    gaji.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='penghasilan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Terdaftar</span><img src='../logo/stop_dakota.PNG'><a href='penghasilan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!--#include file="../layout/footer.asp"-->
