$(document).ready(function(){
  //button tambah
  $('#tombolTambah').on('click', function(){

    $('#formModalLabel').html('Tambah Data');
    $('.modal-footer button[type=submit]').html('Tambah');
    $('.modal-body form').attr('action', 'tambah.asp');
    $('#nama').html('');
    $('#code').val('');
    $('#nama').val('');
   
  });
  // button ubah
  $('.modalUbah').on('click', function(){
    const id = $(this).data('id');
    $('#formModalLabel').html('Update Data ' + id);
    $('.modal-footer button[type=submit]').html('Update');
    $('.modal-body form').attr('action', 'http://192.168.22.8/hrd/divisi/update.asp'); 
     
    const nama = $(this).data('nm');
    const code = $(this).data('id');

    $('#code').val(id);
    $('#nama').val(nama);
    });
  
  //button yes or no


  // input search
  $('#key').on('keyup', function(){
    var key = $('#key').val();
   $('.content').load('../divisi/ajax/CariDivisi.asp?key=' + key );
  });
});



