$(document).ready(function () {
  // cek tombol shift karja
  $('.shift').on('click', function () {
    let data = $(this).data('nip');
    $('.content-detail').load('ajax/shiftKerja.asp?nip=' + data);
  });
  // aksi ketika tombol cetak ditekan
  $(".cetak-detail").on("click", function () {
    // hilangkan navigasi atas
    $('.tombol-navigasi').hide();
    // $('.collapse').hide();
    $('.navbar').hide();
    $('.update-krywn').hide();
    $('.kembali').hide();
    $('.cetak-detail').hide();
    $('.judul-detail').hide();
    // cetak data yang di body
    var restorepage = $(document).innerHTML;
    var printcontent = $('.cotent-detail');
    $(document).innerHTML = printcontent;
    window.print();
    $(document).innerHTML = restorepage;

    // kembalikan tombol
    $('.tombol-navigasi').show();
    $('.update-krywn').show();
    $('.kembali').show();
    $('.cetak-detail').show();
    $('.judul-detail').show();

    // tombol add shift
    $('.tombol-Shift').on('click', function (e) {
      e.preventDefault();
    });
  });
  // fungsi inputan thn-cutiSakit
  // ambil parameter di url
  function getURL(param = null) {
    if (param !== null) {
      var vars = [],
        hash;
      var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
      for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
      }
      return vars[param];
    } else {
      return null;
    }
  }
  var param1 = getURL("nip");
  //user is "finished typing," do something
  // cuti
  $('.thn-cuti').unbind('keyup');
  $('.thn-cuti').bind('keyup', function () {
    let cuti = $('.thn-cuti').val();
    if (cuti.length == 4) {
      $.get('../ajax/cari-cutiSakitIzin.asp?nip=' + param1 + '&data=' + cuti, function (data) {
        $('.cari-izin').html(data);
        // jumlah potongan gaji
        let gaji = $('#tpotgaji').val();
        let cuti = $('#hcuti').val();
        $('#jpgaji').val(gaji);
        $('#scuti3').val(cuti);
      });
    }
  });

  // tampil by agen
  $("#select-agen").on("change", function () {
    let agen = $("#select-agen option:selected").attr("value");
    let shift = $("#shiftName option:selected").attr("value");

    if (shift === "") {
      Swal.fire(
        'Oppss..',
        'Mohon Untuk Pilih Shift Dahulu',
        'error'
      );
      $('#select-agen').val("");
    } else {
      let pakumar = `tampildivisikaryawan.asp?agen=${agen.trim()}`;
      $('#tampil_karyawan').load(pakumar);
    }

  });

  // tampil divisi karyawan berdasarkan shiftkerja
  $('#select-divisi').on('change', function () {
    let agen = $("#select-agen option:selected").attr("value");
    let id = $('#select-divisi  option:selected').attr("value");

    if (agen === "") {
      Swal.fire(
        'Oppss..',
        'Mohon Untuk Pilih Agen Dahulu',
        'error'
      )
      $('#select-divisi').val("");
    } else {
      let pakumar = `tampildivisikaryawan.asp?agen=${agen.trim()}&id=${id}`;
      $('#tampil_karyawan').load(pakumar);
    }
  });

  // filter tahun penghasilan
  $('#thn-penghasilan').unbind('keyup');
  $('#thn-penghasilan').bind('keyup', function () {
    let tahun = $('#thn-penghasilan').val();
    if (tahun.length >= 4 && tahun.length <= 4) {
      $('.loadpenghasilan').show();
      // let akhir = tahun.substring(tahun.length - 2);

      $.get('../ajax/cari-penghasilan.asp?nip=' + param1 + '&tahun=' + tahun, function (data) {

        $('.table-penghasilan').html(data)
        $('.loadpenghasilan').hide();
        // return false;

      });
    }
  });


  // cari user hakakses
  $('#cariuser').on('keyup', function () {
    $('#loaderHakAkses').show();
    setTimeout(() => {

      $.get(`getusername.asp?p=${$('#cariuser').val().replace(' ', '%20')}`, function (data) {

        $('.tableHakakses').html(data);

        $('#loaderHakAkses').hide()
      });
    }, 5000);

  });

});