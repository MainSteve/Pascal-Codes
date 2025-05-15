program CekNilai;

var
  nilai: integer;
  kategori: char;
  lanjut: char;
  valid: boolean;

  // Variabel tambahan
  totalNilai, jumlahInput: integer;
  rataRata: real;

begin
  totalNilai := 0;
  jumlahInput := 0;

  repeat
    
    // Header program
    writeln('=================================');
    writeln('     PROGRAM PENGECEK NILAI     ');
    writeln('=================================');
    writeln;
    
    // Input nilai
    write('Masukkan nilai (0-100): ');
    valid := false;
    
    // Validasi input
    while not valid do
    begin
      {$I-} // Mematikan error I/O
      readln(nilai);
      {$I+} // Menghidupkan error I/O
      
      if (IOResult <> 0) or (nilai < 0) or (nilai > 100) then
      begin
        write('Input tidak valid! Masukkan nilai 0-100: ');
      end
      else
      begin
        valid := true;
      end;
    end;

    // Tambahkan nilai ke total dan jumlah input
    totalNilai := totalNilai + nilai;
    jumlahInput := jumlahInput + 1;
    
    // Penentuan kategori nilai
    if nilai >= 85 then
      kategori := 'A'
    else if nilai >= 70 then
      kategori := 'B'
    else if nilai >= 55 then
      kategori := 'C'
    else if nilai >= 40 then
      kategori := 'D'
    else
      kategori := 'E';
    
    // Menampilkan hasil
    writeln;
    writeln('---------- HASIL ----------');
    writeln('Nilai Anda: ', nilai);
    writeln('Kategori  : ', kategori);
    
    case kategori of
      'A': writeln('Keterangan: Sangat Baik');
      'B': writeln('Keterangan: Baik');
      'C': writeln('Keterangan: Cukup');
      'D': writeln('Keterangan: Kurang');
      'E': writeln('Keterangan: Sangat Kurang');
    end;
    writeln('--------------------------');
    writeln;
    
    // Tanya user apakah ingin mengecek nilai lagi
    write('Cek nilai lagi? (Y/T): ');
    readln(lanjut);
    
  until (upcase(lanjut) = 'T');
  
  // Tampilkan statistik tambahan
  writeln;
  writeln('========== STATISTIK ==========');
  writeln('Jumlah nilai dimasukkan: ', jumlahInput);
  if jumlahInput > 0 then
  begin
    rataRata := totalNilai / jumlahInput;
    writeln('Rata-rata nilai        : ', rataRata:0:2);
  end;
  writeln('===============================');

  // Pesan penutup
  writeln;
  writeln('Terima kasih telah menggunakan program ini!');
  writeln('Tekan tombol apa saja untuk keluar...');
end.
