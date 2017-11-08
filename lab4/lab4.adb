with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Lista is

type Element is
  record 
    Data : Integer := 0;
    Next : access Element := Null;
  end record; 

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:"); 
  end if; 
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop; 
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) ); 

-- do napisania !! 

procedure Add_to_head(List: in out Elem_Ptr; D: in Integer) is
begin
	Insert(List, D);
end Add_to_head;
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
	L: Elem_Ptr := List;
	tmp: Elem_Ptr;
begin
	-- napisz procedurę wstawiającą element zachowując posortowanie (rosnące) listy
	--processing for null lisy;
	if (L = Null) then
		Add_to_head(L, D);
		List := L;
	else
		--add to head
		if (D <= L.Data) then
			L := Insert(L, D);
			List := L;
		else 
			while (D > L.Data) and (L.Next /= Null) loop
				tmp := L;
				L := L.Next;
			end loop;
			
			if (D <= L.Data) then
				L := Insert(L, D);
				tmp.Next := L;
			else --add to tail
				L.Next := new Element;
				L.Next.Data := D;
				L.Next.Next := Null;
			end if;
		end if;
	end if;
	
end Insert_Sort;

Lista : Elem_Ptr := Null;

begin
  	Print(Lista);
  	Insert_Sort(Lista, 21);
	
  	Print(Lista);
  	for I in 1..30 loop
  		Insert_Sort(Lista, I);
  	end loop;
	Print(Lista);
	
  	Insert_Sort(Lista, 1); 
  	Print(Lista);
	
	Insert_Sort(Lista, 2);
	Print(Lista);
	
	Insert_Sort(Lista, 20);
	Print(Lista);
  
end Lab4Lista;
