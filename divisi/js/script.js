$(document).ready(function () {
  // input search
  $('#key').on('keyup', function () {
    var key = $('#key').val();
    $('.content').load('../divisi/ajax/CariDivisi.asp?key=' + key);
  });
  //button tambah
  $('#tombolTambah').on('click', function () {

    $('#formModalLabel').html('Tambah Data');
    $('.modal-footer button[type=submit]').html('Tambah');
    $('.modal-body form').attr('action', 'tambah.asp');
    $('#nama').html('');
    $('#code').val('');
    $('#nama').val('');

  });
});

function ubahData(id, nama) {
  $('#code').val(id);
  $('#nama').val(nama);
  $('#formModalLabel').html('Update Data ' + id);
  $('.modal-footer button[type=submit]').html('Update');
  $('.modal-body form').attr('action', 'update.asp');
}

function aktifDivisi(e) {
  Swal.fire({
    title: 'Yakin Untuk Dirubah?',
    text: "Aktifasi Divisi",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes'
  }).then((result) => {
    if (result.isConfirmed) {
      $.post("aktifId.asp", {
        code: e
      }, function (data, status) {
        location.reload();
      });
    }
  })
}