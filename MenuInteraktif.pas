program GameProgramModul1;
uses crt;

var
  pilihan: Integer;
  lanjutProgram: Boolean;

// === MODUL 1: DASAR ===

// 1. Jumlah Bilangan Positif
procedure JumlahBilanganPositif;
var
  masukan, total: Integer;
begin
  total := 0;
  writeln('Masukkan bilangan bulat positif (masukkan bilangan negatif untuk berhenti):');
  repeat
    write('Masukkan angka: ');
    readln(masukan);
    if masukan > 0 then
      total := total + masukan;
  until masukan <= 0;
  writeln('Jumlah bilangan positif: ', total);
  readln;
end;

// 2. Periksa Genap/Ganjil
procedure PeriksaGenapGanjil;
var
  angka: Integer;
begin
  write('Masukkan bilangan bulat: ');
  readln(angka);
  if angka mod 2 = 0 then
    writeln(angka, ' adalah genap.')
  else
    writeln(angka, ' adalah ganjil.');
  readln;
end;

// === MENU UTAMA ===
begin
  lanjutProgram := True;
  while lanjutProgram do
  begin
    clrscr;
    writeln('=== MENU UTAMA ===');
    writeln('1. Jumlah Bilangan Positif');
    writeln('2. Periksa Genap/Ganjil');
    writeln('3. Keluar');
    write('Pilih menu (1-3): ');
    readln(pilihan);

    case pilihan of
      1: JumlahBilanganPositif;
      2: PeriksaGenapGanjil;
      3: begin
           writeln('Terima kasih telah menggunakan program!');
           lanjutProgram := False;
         end;
    else
      writeln('Pilihan tidak valid! Tekan Enter untuk coba lagi.');
    end;

    if lanjutProgram and (pilihan in [1, 2]) then
    begin
      writeln;
      write('Tekan Enter untuk kembali ke menu...');
      readln;
    end;
  end;
end.
