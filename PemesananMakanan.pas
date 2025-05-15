program PemesananMakanan;

uses
  SysUtils; // Add this unit for the Format function

const
  MAX_MENU = 5;

type
  TMenu = record
    Nama: string;
    Harga: real;
  end;

var
  Menu: array[1..MAX_MENU] of TMenu;
  Pilihan, Jumlah: integer;
  TotalHarga, SubTotal: real;
  Lanjut: char;

begin
  { Inisialisasi daftar menu }
  Menu[1].Nama := 'Nasi Goreng'; Menu[1].Harga := 15000;
  Menu[2].Nama := 'Mie Goreng'; Menu[2].Harga := 13000;
  Menu[3].Nama := 'Ayam Bakar'; Menu[3].Harga := 20000;
  Menu[4].Nama := 'Sate Ayam'; Menu[4].Harga := 18000;
  Menu[5].Nama := 'Es Teh Manis'; Menu[5].Harga := 5000;

  TotalHarga := 0;

  repeat
    writeln('Daftar Menu:');
    writeln('-----------------------------------');
    for Pilihan := 1 to MAX_MENU do
      writeln(Pilihan, '. ', Menu[Pilihan].Nama, ' - Rp.', Format('%.0n', [Menu[Pilihan].Harga]));
    writeln('-----------------------------------');

    { Memilih menu }
    write('Pilih nomor menu yang ingin dipesan (1-', MAX_MENU, '): ');
    readln(Pilihan);

    if (Pilihan < 1) or (Pilihan > MAX_MENU) then
    begin
      writeln('Pilihan tidak valid. Silakan coba lagi.');
      continue;
    end;

    { Memasukkan jumlah pesanan }
    write('Masukkan jumlah pesanan untuk ', Menu[Pilihan].Nama, ': ');
    readln(Jumlah);

    { Menghitung subtotal dan total harga }
    SubTotal := Menu[Pilihan].Harga * Jumlah;
    TotalHarga := TotalHarga + SubTotal;

    writeln('Subtotal untuk ', Menu[Pilihan].Nama, ': Rp.', Format('%.0n', [SubTotal]));
    writeln('Total sementara: Rp.', Format('%.0n', [TotalHarga]));

    { Menanyakan apakah ingin memesan lagi }
    write('Apakah Anda ingin memesan menu lain? (y/n): ');
    readln(Lanjut);
  until (Lanjut = 'n') or (Lanjut = 'N');

  { Menampilkan total akhir }
  writeln('-----------------------------------');
  writeln('Total harga yang harus dibayar: Rp.', Format('%.0n', [TotalHarga]));
  writeln('Terima kasih atas pesanan Anda!');
  readln;
end.
