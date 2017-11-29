-- prot3.adb
-- komunikacja asynchroniczna przez bufor
-- kolejka FIFO

with Ada.Text_IO;
use Ada.Text_IO;

procedure Prot3 is
  
-- obiekt chroniony
type TBuf is array(Integer range <>) of Character; 
protected type TypeBuf(Rozmiar: Integer) is
  entry Wstaw(C : Character);
  entry Pobierz(C : out Character);
  procedure Show;
  private
   B: TBuf(1..Rozmiar);
   LicElem: Integer := 0;
   PozPobL : Integer := 1;
   PozWstaw : Integer := 1;
end TypeBuf;

protected body TypeBuf is
  entry Wstaw(C : Character) when LicElem<Rozmiar+1 is
  begin
    B(PozWstaw) := C;
	PozWstaw := (PozWstaw mod Rozmiar) + 1;
	LicElem := LicElem + 1;   
  end Wstaw;
  
  entry Pobierz(C : out Character) when LicElem > 0 is
  begin
    C := B(PozPobL);
	B(PozPobL) := ' ';
	PozPobL := (PozPobL mod Rozmiar) + 1;
    LicElem := LicElem - 1;
  end Pobierz;
  
  procedure Show is
	  I : Integer;
  begin
	  Put("Protected table: ");
	  for I in 1..Rozmiar loop
		  Put(B(I) & " ");
	  end loop;
	  New_Line;
  end Show;
end TypeBuf;

Buf: TypeBuf(3);

task Producent; 

task body Producent is
  Cl : Character := '1';
  Cl1: Character := '2';
  Cl2: Character := '3';
begin  
  --Put_Line("$ wstawiam: znak = '" & Cl & "'");
  Buf.Wstaw(Cl);
  Buf.Wstaw(Cl1);
  Buf.Wstaw(Cl2);
  Buf.Show;
  Buf.Wstaw(Cl2);
  Buf.Show;
  Put_Line("$ wstawiłem...");
end Producent;

task Konsument; 

task body Konsument is
  Cl : Character := ' ';
begin  
  Put_Line("# pobiorę...");
  Buf.Pobierz(Cl);
  Buf.Show;
  Buf.Pobierz(Cl);
  Buf.Show;
  Buf.Pobierz(Cl);
  --Put_Line("# pobrałem: znak = '" & Cl & "'");
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
  Buf.Show;
end Prot3;
  